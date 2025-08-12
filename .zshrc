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

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="~/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP binary.
export PATH="~/Library/Application Support/Herd/bin/":$PATH


# Load Angular CLI autocompletion.
source <(ng completion script)

export FZF_BASE=/path/to/fzf/install/dir

### Go environment ###########################################################
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:/opt/homebrew/opt/go/libexec/bin:$GOBIN"
### End Go environment #######################################################
export PATH="/Users/nate/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/nate/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

export DOCKER_BUILDKIT=1

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"