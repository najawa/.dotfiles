# ~/.zsh/aws-iterm2-profile.zsh  (language: zsh)

# --- iTerm2 helpers (OSC 1337) ---
it2_set_profile() { printf '\033]1337;SetProfile=%s\007' "$1"; }
it2_set_badge()   { printf '\033]1337;SetBadge=%s\007' "$1"; }
it2_clear_badge() { printf '\033]1337;SetBadge=\007'; }

# --- Fast account resolver with caching ---
zmodload zsh/datetime
zmodload zsh/stat

typeset -gA _AWS_KEY_TO_ACCT=(
  AKIATCKAN5LNGA2A72R3 REDACTED_AWS_ACCT_1
  AKIARFTO3HKQGGS6REIX REDACTED_AWS_ACCT_2
)

typeset -g _AWS_CACHE_ACCT=""
typeset -g _AWS_CACHE_KEY=""
typeset -g _AWS_CACHE_PROFILE=""
typeset -g _AWS_CACHE_CRED_MTIME=""
typeset -g _AWS_STS_LAST=0

_fast_aws_account() {
  # compose a cheap-change key from env + creds mtime
  local key="$AWS_ACCESS_KEY_ID" prof="$AWS_PROFILE" cred="$HOME/.aws/credentials" mtime="none"
  if [[ -r $cred ]]; then
    local -A st; zstat -A st +mtime -- "$cred" 2>/dev/null && mtime="${st[mtime]}"
  fi
  if [[ "$key$prof$mtime" == "$_AWS_CACHE_KEY$_AWS_CACHE_PROFILE$_AWS_CACHE_CRED_MTIME" && -n $_AWS_CACHE_ACCT ]]; then
    print -r -- "$_AWS_CACHE_ACCT"; return
  fi

  local acct=""
  if [[ -n "$AWS_ACCOUNT_ID" ]]; then
    acct="$AWS_ACCOUNT_ID"
  elif [[ -n "$_AWS_KEY_TO_ACCT[$key]" ]]; then
    acct="$_AWS_KEY_TO_ACCT[$key]"
  elif command -v aws >/dev/null 2>&1; then
    # throttle STS to once per 15s to avoid prompt lag
    local now=$EPOCHSECONDS
    if (( now - _AWS_STS_LAST >= 15 )); then
      acct=$(aws sts get-caller-identity --query Account --output text 2>/dev/null)
      _AWS_STS_LAST=$now
    fi
  fi

  # normalize whitespace without forking external tools
  acct=${acct//[[:space:]]/}

  _AWS_CACHE_KEY="$key"
  _AWS_CACHE_PROFILE="$prof"
  _AWS_CACHE_CRED_MTIME="$mtime"
  _AWS_CACHE_ACCT="$acct"
  print -r -- "$acct"
}

# --- Theme application with change detection ---
typeset -g _IT2_CUR_PROFILE=""

apply_iterm2_aws_theme() {
  [[ "$TERM_PROGRAM" == "iTerm.app" ]] || return 0

  local acct; acct=$(_fast_aws_account)

  local profile="Default" badge=""
  case "$acct" in
    REDACTED_AWS_ACCT_1) profile="AWS-TJ";  badge="AWS REDACTED_AWS_ACCT_1" ;;
    REDACTED_AWS_ACCT_2) profile="AWS-FFS"; badge="AWS REDACTED_AWS_ACCT_2" ;;
    *)            profile="Default"; badge="" ;;
  esac

  # only emit OSC if profile actually changes
  if [[ "$profile" != "$_IT2_CUR_PROFILE" ]]; then
    it2_set_profile "$profile"
    [[ -n "$badge" ]] && it2_set_badge "$badge" || it2_clear_badge
    _IT2_CUR_PROFILE="$profile"
  fi
}

# --- Hooks ---
autoload -Uz add-zsh-hook
_aws_iterm2_precmd() { apply_iterm2_aws_theme }
add-zsh-hook precmd _aws_iterm2_precmd
_aws_iterm2_chpwd()  { apply_iterm2_aws_theme }
add-zsh-hook chpwd _aws_iterm2_chpwd
