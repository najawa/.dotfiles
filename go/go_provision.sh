#!/usr/bin/env bash
###############################################################################
# provisioning.sh – Go 1.23+ workstation bootstrap for Apple-silicon MacBooks #
# (JetBrains GoLand-centric edition)                                           #
#                                                                             #
# Author : Nate (Principal DevOps / AI Eng.)                                  #
# Target : macOS 14 “Sequoia” on M3 Max (arm64)                                #
###############################################################################
set -Eeuo pipefail
IFS=$'\n\t'

### ───────────────────────────────────────────────────────────── ARCH CHECK ──
ARCH=$(uname -m)
if [[ "${ARCH}" != "arm64" ]]; then
  echo "⚠️  This script is optimised for Apple-silicon (arm64). Exiting." >&2
  exit 1
fi

### ─────────────────────────────────────────── XCODE COMMAND-LINE TOOLS ────
if ! xcode-select -p &>/dev/null; then
  echo "⏳ Installing Xcode Command-Line Tools…"
  xcode-select --install
  until xcode-select -p &>/dev/null; do sleep 20; done
fi

### ─────────────────────────────────────────────── ROSETTA 2 (OPTIONAL) ────
if /usr/bin/pgrep oahd &>/dev/null; then
  echo "✅ Rosetta 2 already present."
else
  echo "⏳ Installing Rosetta 2 for x86_64 compatibility…"
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
fi

### ──────────────────────────────────────────────────────────── HOMEBREW ☕ ──
if ! command -v brew &>/dev/null; then
  echo "⏳ Installing Homebrew…"
  NONINTERACTIVE=1 \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "${HOME}/.zprofile"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew analytics off
brew update

### ──────────────────────────────────────────────── BREWFILE CONTENTS ──────
cat <<'BREWFILE' > /tmp/Brewfile.go
brew  "go"                  # Go compiler (latest stable)
brew  "gopls"               # LSP – optional for CLI tools, not required by GoLand
brew  "delve"               # Debugger (GoLand delegates to this if present)
brew  "golangci-lint"       # Meta-linter (GoLand can call it as an External Tool)
brew  "direnv"              # Env dir autoloader – good with GoLand's Terminal
brew  "ripgrep"             # Fast grep (used by Toolbox Search-Everywhere)
brew  "jq"                  # JSON swiss-army-knife
brew  "pre-commit"          # Git hook manager
brew  "gh"                  # GitHub CLI
# NOTE: No VS Code cask – GoLand is assumed to be installed already.
BREWFILE

echo "⏳ Installing formulae…"
brew bundle --file=/tmp/Brewfile.go

### ────────────────────────────────────────── GO WORKSPACE & ENV VARS ──────
mkdir -p "${HOME}/go/"{bin,pkg,src}

_ZSHFILE="${HOME}/.zshrc"
if ! grep -q '### Go environment ###' "${_ZSHFILE}"; then
  cat <<'EOSHELL' >> "${_ZSHFILE}"

### Go environment ###########################################################
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:/opt/homebrew/opt/go/libexec/bin:$GOBIN"
### End Go environment #######################################################
EOSHELL
fi

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:/opt/homebrew/opt/go/libexec/bin:$GOBIN"

### ─────────────────────────────────────────────── GO CLI UTILITIES ────────
echo "⏳ Installing useful command-line helpers…"
go install golang.org/x/tools/cmd/goimports@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest
go install github.com/go-delve/delve/cmd/dlv@latest  # backup install path
go install github.com/securego/gosec/v2/cmd/gosec@latest

### ──────────────────────────────── PRE-COMMIT SEED (FIRST-TIME ONLY) ──────
if [[ -d .git && ! -f .pre-commit-config.yaml ]]; then
  cat <<'YAML' > .pre-commit-config.yaml
repos:
  - repo: https://github.com/dnephin/pre-commit-golang
    rev: v1.4.0
    hooks:
      - id: go-fmt
      - id: go-vet
      - id: go-imports
      - id: go-staticcheck
      - id: go-test
YAML
  pre-commit install
fi

### ──────────────────────────────────────────── OPTIONAL GoLand CLI ────────
# If you installed GoLand via JetBrains Toolbox, it already placed `goland`
# in ~/Library/Application\ Support/JetBrains/Toolbox/scripts. We’ll symlink it.
if [[ -x "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts/goland" ]] \
   && ! command -v goland &>/dev/null; then
  ln -s "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts/goland" /opt/homebrew/bin/goland
  echo "✅ 'goland' CLI linked to /opt/homebrew/bin. (Re-open Terminal to use.)"
fi

### ───────────────────────────────────────────────── CLEANUP ────────────────
brew cleanup --prune=all -s

echo -e "\n✅ Go development environment ready for GoLand!  Next steps:"
cat <<'EONEXT'
1. Open GoLand → **Preferences ▶ Go ▶ GOROOT**
   • Click “+” → “Local” → select **/opt/homebrew/opt/go/libexec**
   (GoLand detects the version and tags it “Go 1.23.x (brew)”.)

2. Still in Preferences ▶ **Go ▶ GOPATH**
   • Click “Add” → select **~/go** (matches what this script exported).
   • Leave “Index entire GOPATH” disabled for speed; modules are primary.

3. Preferences ▶ **Go ▶ Linter**
   • Change “Run Go tool:” → **golangci-lint**
   • Binary should auto-resolve from **$GOBIN/golangci-lint**.

4. Preferences ▶ **Go ▶ Delve**
   • Ensure “Use external dlv” is enabled; GoLand will find the Homebrew build.

5. (Optional) File ▶ **New Project from existing sources**
   • Make sure **“Enable Go modules integration”** is checked.

Tip: You can launch a project from the CLI:
   ```bash
   cd ~/code/your-repo
   goland .
