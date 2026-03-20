```
████████╗███████╗ ██████╗██╗  ██╗     ██╗ ██████╗ ██╗   ██╗
╚══██╔══╝██╔════╝██╔════╝██║  ██║     ██║██╔═══██╗╚██╗ ██╔╝
   ██║   █████╗  ██║     ███████║     ██║██║   ██║ ╚████╔╝
   ██║   ██╔══╝  ██║     ██╔══██║██   ██║██║   ██║  ╚██╔╝
   ██║   ███████╗╚██████╗██║  ██║╚█████╔╝╚██████╔╝   ██║
   ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚════╝  ╚═════╝    ╚═╝
Provisioned for Nate Waddell
```

Dotfiles and dev environment config. One script to link everything into place on a fresh macOS or Linux box.

## Usage

Remote:
```bash
curl -fsSL https://raw.githubusercontent.com/najawa/.dotfiles/main/install | bash
```

Local:
```bash
chmod +x install
./install
```

The install script detects your OS (apt, pacman, or brew), installs packages, then runs `link-dotfiles.rb` to symlink everything into `$HOME`.

## What's Inside

### Shell
- **`.zshrc`** — oh-my-zsh config, plugin loading, language version managers (pyenv, nvm, asdf), Go/Ruby/PHP paths
- **`.zsh_aliases`** — aliases, utility functions (`wssh`, `scopy`, `erip`, `whereis`), colorized output, `thefuck` integration
- **`.zsh_prompt`** — custom prompt experimentation
- **`.zprofile`** — PATH setup for `~/.bin`, `~/.dotfiles/bin`, homebrew, fzf defaults

### Editors
- **`.vimrc`** — Vim configuration
- **`.emacs`** — Emacs configuration
- **`.config/nvim/`** — Neovim configuration

### Terminal & Multiplexer
- **`.tmux.conf`** — tmux configuration with tmuxinator support
- **`.alacritty.yml`** — Alacritty terminal config
- **`motd/`** — ASCII art banner displayed on shell startup (piped through `lolcat`)

### Git
- **`.gitconfig`** — global git settings, opendiff mergetool, pull rebase, autosquash, credential helpers for GitHub
- **`.gitignore_global`** — global ignore patterns
- **`.ctags`** — ctags configuration

### Window Management (macOS)
- **`.yabairc`** — yabai tiling window manager config
- **`.skhdrc`** — skhd hotkey daemon bindings

### Window Management (Linux)
- **`.i3/`** — i3 window manager config
- **`.i3status.conf`** — i3 status bar
- **`.config/rofi/`** — rofi launcher config
- **`.config/dunst/`** — notification daemon config
- **`.picom.conf`** — compositor config
- **`.Xresources`**, **`.xinitrc`**, **`.xprofile`**, **`.xmodmap`** — X11 setup
- **`.config/gtk-3.0/`**, **`.gtkrc-2.0`** — GTK theming

### AWS
- **`zsh-aws-borders.sh`** — changes iTerm2 profile/badge based on active AWS account so you never run commands in the wrong environment

### Tools
- **`Brewfile`** — declarative homebrew packages, casks, and Go tools
- **`porthole`** — identify which process or Docker container owns a port
- **`link-dotfiles.rb`** — symlink manager that links dotfiles into `$HOME`, handles nested `.config/` dirs
- **`keys/`** — gitignored directory for tokens, private aliases, and AWS account mappings

### Claude Code
- **`claude/`** — Claude Code configuration: agents, hooks, skills, rules, commands, and templates

### Package Managers (Linux)
- **`apt/`** — Debian/Ubuntu install scripts
- **`pacman/`** — Arch Linux install scripts

## Docker

Shell/tmux/vim demo:
```bash
docker run -it najawa/dotfiles
```
