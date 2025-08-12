# ~/.zsh/aws-iterm2-profile.zsh

it2_set_profile() { printf '\033]1337;SetProfile=%s\007' "$1"; }
it2_set_badge()   { printf '\033]1337;SetBadge=%s\007' "$1"; }
it2_clear_badge() { printf '\033]1337;SetBadge=\007'; }

zmodload zsh/datetime

# Map profiles to accounts for instant, zero-process resolution
typeset -gA _AWS_PROFILE_TO_ACCT=(
  tj  REDACTED_AWS_ACCT_1
  ffs REDACTED_AWS_ACCT_2
)

typeset -g _IT2_CUR_PROFILE=""

_resolve_account_fast() {
  local a=""
  [[ -n "$AWS_ACCOUNT_ID" ]] && a="$AWS_ACCOUNT_ID"
  [[ -z "$a" && -n "$_AWS_PROFILE_TO_ACCT[$AWS_PROFILE]" ]] && a="$_AWS_PROFILE_TO_ACCT[$AWS_PROFILE]"
  a=${a//[[:space:]]/}
  print -r -- "$a"
}

_resolve_account_sts() {
  local a
  a=$(aws sts get-caller-identity --query Account --output text 2>/dev/null) || a=""
  a=${a//[[:space:]]/}
  [[ "$a" == "None" ]] && a=""
  print -r -- "$a"
}

_apply_from_acct() {
  local acct="$1" profile="Default" badge=""
  case "$acct" in
    REDACTED_AWS_ACCT_1) profile="AWS-TJ";  badge="AWS REDACTED_AWS_ACCT_1" ;;
    REDACTED_AWS_ACCT_2) profile="AWS-FFS"; badge="AWS REDACTED_AWS_ACCT_2" ;;
    *)            profile="Default"; badge="" ;;
  esac
  if [[ "${ITERM_PROFILE:-$_IT2_CUR_PROFILE}" != "$profile" ]]; then
    it2_set_profile "$profile"
    [[ -n "$badge" ]] && it2_set_badge "$badge" || it2_clear_badge
    _IT2_CUR_PROFILE="$profile"
  fi
}

# Public entry points
apply_iterm2_aws_theme_on_start() {
  [[ "$TERM_PROGRAM" == "iTerm.app" ]] || return 0
  _apply_from_acct "$(_resolve_account_fast)"
  _apply_from_acct "$(_resolve_account_sts)"
}

_aws_iterm2_precmd() {
  [[ "$TERM_PROGRAM" == "iTerm.app" ]] || return 0
  _apply_from_acct "$(_resolve_account_fast)"
}

_aws_iterm2_preexec() {
  [[ "$TERM_PROGRAM" == "iTerm.app" ]] || return 0
  case "$1" in
    aws|\aws\ *|aws\ *) _apply_from_acct "$(_resolve_account_sts)" ;;
  esac
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd  _aws_iterm2_precmd
add-zsh-hook preexec _aws_iterm2_preexec

apply_iterm2_aws_theme_on_start
