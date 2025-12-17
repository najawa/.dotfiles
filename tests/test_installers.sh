#!/usr/bin/env bash
#
# Test suite for dotfiles installers
# Validates script syntax, conventions, and basic functionality
#

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"
TESTS_PASSED=0
TESTS_FAILED=0
FAILED_TESTS=()

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

print_header() {
  echo ""
  echo "=========================================="
  echo "  $1"
  echo "=========================================="
}

pass() {
  echo -e "  ${GREEN}✓${NC} $1"
  ((TESTS_PASSED++))
}

fail() {
  echo -e "  ${RED}✗${NC} $1"
  ((TESTS_FAILED++))
  FAILED_TESTS+=("$1")
}

warn() {
  echo -e "  ${YELLOW}⚠${NC} $1"
}

# Collect all installer scripts
get_installer_scripts() {
  find "${SCRIPT_DIR}" -type f \( -name "install" -o -name "install.sh" \) \
    ! -path "*/node_modules/*" \
    ! -path "*/.git/*" \
    2>/dev/null | sort
}

#
# Test: Shebang validation
#
test_shebangs() {
  print_header "Testing Shebangs"

  for script in $(get_installer_scripts); do
    local shebang
    shebang=$(head -n1 "$script")

    if [[ "$shebang" == "#!/usr/bin/env bash" ]]; then
      pass "$(basename "$(dirname "$script")")/$(basename "$script"): Correct shebang"
    elif [[ "$shebang" == "#!"* ]]; then
      fail "$(basename "$(dirname "$script")")/$(basename "$script"): Non-standard shebang: $shebang"
    else
      fail "$(basename "$(dirname "$script")")/$(basename "$script"): Missing or malformed shebang"
    fi
  done
}

#
# Test: Error handling (set -e, set -u, set -o pipefail)
#
test_error_handling() {
  print_header "Testing Error Handling"

  for script in $(get_installer_scripts); do
    local script_name
    script_name="$(basename "$(dirname "$script")")/$(basename "$script")"

    if grep -q "set -euo pipefail" "$script" || grep -q "set -e" "$script"; then
      pass "$script_name: Has error handling"
    else
      fail "$script_name: Missing error handling (set -e)"
    fi
  done
}

#
# Test: No deprecated apt-key usage
#
test_no_deprecated_apt_key() {
  print_header "Testing for Deprecated apt-key"

  local found_issues=false

  for script in $(get_installer_scripts); do
    if grep -q "apt-key add" "$script" 2>/dev/null; then
      fail "$(basename "$(dirname "$script")")/$(basename "$script"): Uses deprecated apt-key"
      found_issues=true
    fi
  done

  if [[ "$found_issues" == false ]]; then
    pass "No scripts use deprecated apt-key"
  fi
}

#
# Test: Bash syntax validation
#
test_bash_syntax() {
  print_header "Testing Bash Syntax"

  for script in $(get_installer_scripts); do
    local script_name
    script_name="$(basename "$(dirname "$script")")/$(basename "$script")"

    if bash -n "$script" 2>/dev/null; then
      pass "$script_name: Valid bash syntax"
    else
      fail "$script_name: Bash syntax error"
    fi
  done
}

#
# Test: No unquoted variables in dangerous contexts
#
test_variable_quoting() {
  print_header "Testing Variable Quoting"

  local patterns=(
    'cd \$[A-Za-z_]'      # cd $var (should be cd "$var")
    'rm -rf \$[A-Za-z_]'  # rm -rf $var (dangerous!)
    '\| xargs.*\$[A-Za-z_]' # pipe to xargs with unquoted var
  )

  local found_issues=false

  for script in $(get_installer_scripts); do
    for pattern in "${patterns[@]}"; do
      if grep -E "$pattern" "$script" 2>/dev/null | grep -v '"\$' >/dev/null; then
        warn "$(basename "$(dirname "$script")")/$(basename "$script"): Potentially unquoted variable"
        found_issues=true
      fi
    done
  done

  if [[ "$found_issues" == false ]]; then
    pass "No obvious unquoted variable issues found"
  fi
}

#
# Test: Scripts are executable
#
test_executable_permissions() {
  print_header "Testing Executable Permissions"

  for script in $(get_installer_scripts); do
    local script_name
    script_name="$(basename "$(dirname "$script")")/$(basename "$script")"

    if [[ -x "$script" ]]; then
      pass "$script_name: Is executable"
    else
      fail "$script_name: Not executable"
    fi
  done
}

#
# Test: No backtick command substitution (deprecated)
#
test_no_backticks() {
  print_header "Testing for Deprecated Backticks"

  local found_issues=false

  for script in $(get_installer_scripts); do
    # Look for backticks but exclude comments and strings that might legitimately contain them
    if grep -E '`[^`]+`' "$script" 2>/dev/null | grep -v '^[[:space:]]*#' >/dev/null; then
      fail "$(basename "$(dirname "$script")")/$(basename "$script"): Uses deprecated backtick substitution"
      found_issues=true
    fi
  done

  if [[ "$found_issues" == false ]]; then
    pass "No scripts use deprecated backtick substitution"
  fi
}

#
# Test: link-dotfiles.rb syntax
#
test_ruby_syntax() {
  print_header "Testing Ruby Syntax"

  local ruby_script="${SCRIPT_DIR}/link-dotfiles.rb"

  if [[ -f "$ruby_script" ]]; then
    if command -v ruby &>/dev/null; then
      if ruby -c "$ruby_script" &>/dev/null; then
        pass "link-dotfiles.rb: Valid Ruby syntax"
      else
        fail "link-dotfiles.rb: Ruby syntax error"
      fi
    else
      warn "Ruby not installed, skipping Ruby syntax check"
    fi
  else
    warn "link-dotfiles.rb not found"
  fi
}

#
# Test: ShellCheck (if available)
#
test_shellcheck() {
  print_header "Testing with ShellCheck"

  if ! command -v shellcheck &>/dev/null; then
    warn "ShellCheck not installed, skipping"
    return
  fi

  for script in $(get_installer_scripts); do
    local script_name
    script_name="$(basename "$(dirname "$script")")/$(basename "$script")"

    if shellcheck -S warning "$script" &>/dev/null; then
      pass "$script_name: Passes ShellCheck"
    else
      fail "$script_name: ShellCheck warnings/errors"
    fi
  done
}

#
# Test: Required files exist
#
test_required_files() {
  print_header "Testing Required Files"

  local required_files=(
    "install"
    "link-dotfiles.rb"
    "apt/install"
    "brew/install"
    "pacman/install"
    ".zshrc"
    ".vimrc"
    ".tmux.conf"
    ".gitconfig"
  )

  for file in "${required_files[@]}"; do
    if [[ -f "${SCRIPT_DIR}/${file}" ]]; then
      pass "$file exists"
    else
      fail "$file missing"
    fi
  done
}

#
# Test: OS detection in main installer
#
test_os_detection() {
  print_header "Testing OS Detection Logic"

  local main_install="${SCRIPT_DIR}/install"

  if grep -q "darwin" "$main_install" && \
     grep -q "apt-get" "$main_install" && \
     grep -q "pacman" "$main_install"; then
    pass "Main installer handles macOS, Debian, and Arch"
  else
    fail "Main installer missing OS detection logic"
  fi
}

#
# Main test runner
#
main() {
  echo ""
  echo "╔══════════════════════════════════════════╗"
  echo "║     Dotfiles Installer Test Suite        ║"
  echo "╚══════════════════════════════════════════╝"

  test_required_files
  test_shebangs
  test_error_handling
  test_bash_syntax
  test_executable_permissions
  test_no_deprecated_apt_key
  test_no_backticks
  test_variable_quoting
  test_ruby_syntax
  test_shellcheck
  test_os_detection

  print_header "Test Summary"
  echo ""
  echo -e "  ${GREEN}Passed:${NC} ${TESTS_PASSED}"
  echo -e "  ${RED}Failed:${NC} ${TESTS_FAILED}"
  echo ""

  if [[ ${TESTS_FAILED} -gt 0 ]]; then
    echo -e "${RED}Failed tests:${NC}"
    for test in "${FAILED_TESTS[@]}"; do
      echo "  - $test"
    done
    echo ""
    exit 1
  else
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
  fi
}

main "$@"
