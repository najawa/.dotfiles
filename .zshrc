ZSH=$HOME/.oh-my-zsh
if [ -d /usr/share/oh-my-zsh ]; then
  ZSH=/usr/share/oh-my-zsh
fi

export EDITOR='vim'

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY SHARE_HISTORY

if [ -d /opt/asdf-vm ]; then
  ASDF_DIR=/opt/asdf-vm
fi

export FZF_BASE=/opt/homebrew/bin/fzf
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
CASE_SENSITIVE="false"
COMPLETION_WAITING_DOTS="true"
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_UNICODE=true
HIST_STAMPS="yyyy-mm-dd"
DISABLE_UPDATE_PROMPT="true"

# Plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git github rails bundler terraform tmux tmuxinator asdf docker docker-compose \
         ssh-agent heroku aws gh fzf)

source $ZSH/oh-my-zsh.sh

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# An experimental way to color zsh terminal parts. Not as nice as the simpler bash ones :(
# PS1_DEBUG=false
# if [[ -f ~/.zsh_prompt ]]; then
#   . ~/.zsh_prompt
# fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Created by `pipx` on 2024-02-27 18:23:19
export PATH="$PATH:~/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Herd PHP configuration
[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"
if [[ -d ~/Library/Application\ Support/Herd/config/php/83 ]]; then
    export HERD_PHP_83_INI_SCAN_DIR="~/Library/Application Support/Herd/config/php/83/"
fi
if [[ -d ~/Library/Application\ Support/Herd/bin ]]; then
    export PATH="~/Library/Application Support/Herd/bin/":$PATH
fi

# Load Angular CLI autocompletion
if command -v ng &>/dev/null; then
    source <(ng completion script)
fi

### Go environment ###########################################################
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:/opt/homebrew/opt/go/libexec/bin:$GOBIN"
### End Go environment #######################################################

if [[ -d /Users/nate/.config/herd-lite/bin ]]; then
    export PATH="/Users/nate/.config/herd-lite/bin:$PATH"
    export PHP_INI_SCAN_DIR="/Users/nate/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
fi

export DOCKER_BUILDKIT=1

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Default command uses the standard ~/.claude directory
claude() {
  CLAUDE_CONFIG_DIR="$HOME/.claude" /opt/homebrew/bin/claude "$@"
}
claude-secondary() {
  CLAUDE_CONFIG_DIR="$HOME/.claude-secondary-config" /opt/homebrew/bin/claude "$@"
}

# Claude time tracker
if [[ -d "$HOME/claude-time-tracker" ]]; then
    export CTT_SCRIPT_DIR="$HOME/claude-time-tracker"
    source "$CTT_SCRIPT_DIR/shell-hooks.sh"
fi

# ── Private project morning checks ──────────────
if [ -f ~/.dotfiles/keys/PRIVATE_PROJECTS ]; then
    source ~/.dotfiles/keys/PRIVATE_PROJECTS
fi

_goldrush_morning() {
  local today=$(date +%Y-%m-%d)
  local stamp_file="/tmp/.goldrush-morning-$today"
  [[ -f "$stamp_file" ]] && return
  [[ -z "$GOLDRUSH_PROJECT" || ! -d "$GOLDRUSH_PROJECT" ]] && return
  touch "$stamp_file"
  echo ""
  echo "  Good morning!"
  echo ""
  echo -n "  Perform morning maintenance tasks? (y/n) "
  read -r reply
  if [[ "$reply" =~ ^[Yy] ]]; then
    gmorning
  fi
}

gmorning() {
  [[ -z "$GOLDRUSH_PROJECT" || ! -d "$GOLDRUSH_PROJECT" ]] && return
  pushd -q "$GOLDRUSH_PROJECT"
  node tools/submissions.mjs dashboard
  node tools/submissions.mjs queue
  echo ""
  echo -n "  Browse extension checklists? (y/n) "
  read -r reply
  if [[ "$reply" =~ ^[Yy] ]]; then
    node tools/submissions.mjs checklist
  fi
  popd -q
}

_goldrush_morning

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/bin:$PATH"
