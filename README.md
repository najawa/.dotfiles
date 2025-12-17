# dotfiles

A comprehensive, cross-platform development environment configuration designed to fast-track setting up new machines.

```bash
# One-liner installation
curl -fsSL https://raw.githubusercontent.com/najawa/.dotfiles/main/install | bash
```

## Features

- **Cross-platform**: Linux (Debian/Ubuntu, Arch) and macOS
- **Automated installation**: Single command setup with OS detection
- **Consistent theming**: Dracula color scheme throughout
- **Vim-centric navigation**: hjkl keybindings everywhere
- **Docker support**: Try before you install with `docker run -it najawa/dotfiles`

## Quick Start

### Remote Installation

```bash
curl -fsSL https://raw.githubusercontent.com/najawa/.dotfiles/main/install | bash
```

### Local Installation

```bash
git clone https://github.com/najawa/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install
./install
```

### Docker Preview

```bash
docker run -it najawa/dotfiles
```

## What's Included

### Shell Environment

| Component | Description |
|-----------|-------------|
| **Zsh** | Default shell with Oh-My-Zsh framework |
| **Aliases** | 80+ productivity aliases for git, navigation, and tools |
| **Prompt** | robbyrussell theme with git integration |
| **History** | Extended history (1B lines) with timestamp support |

### Editors

| Editor | Configuration |
|--------|---------------|
| **Vim** | Full config with 15+ plugins, FZF integration, language support |
| **Neovim** | Lua-based config with LSP, Copilot, and vim-tmux-navigator |
| **Emacs** | Evil mode (Vim keybindings), FZF, and WakaTime integration |

### Terminal & Multiplexer

| Tool | Features |
|------|----------|
| **tmux** | Prefix `Ctrl+A`, vim-style pane navigation, Dracula theme |
| **Alacritty** | JetBrainsMono Nerd Font, transparent background |

### Window Managers

| Platform | WM | Features |
|----------|----|---------
| Linux | **i3** | Gaps, vim navigation, Rofi launcher, dunst notifications |
| macOS | **yabai** | BSP layout with skhd hotkeys |

### Development Tools

| Category | Tools |
|----------|-------|
| **Version Management** | ASDF (Ruby, Node.js, Crystal, Terraform) |
| **Databases** | PostgreSQL, MariaDB, Redis |
| **Containers** | Docker, Docker Compose |
| **Languages** | Ruby/Rails, Node.js, Python (pyenv), PHP (Herd), Crystal |

### Git Configuration

- Verbose commits with rebase-based workflow
- Autosquash and autostash on rebase
- Git LFS support
- Local config include (`~/.gitconfig.local` for personal settings)

## Platform Support

| Platform | Package Manager | Status |
|----------|-----------------|--------|
| Ubuntu/Debian | apt | Supported |
| Arch Linux | pacman | Supported |
| macOS | Homebrew | Supported |
| Docker | - | Supported |

## Directory Structure

```
~/.dotfiles/
├── install                 # Main entry point (OS detection)
├── link-dotfiles.rb        # Symlink manager
├── apt/                    # Debian/Ubuntu installers
│   ├── install             # Main apt installer
│   ├── asdf/               # ASDF version manager
│   ├── docker/             # Docker & Docker Compose
│   ├── postgresql/         # PostgreSQL database
│   ├── redis/              # Redis with systemd
│   └── zsh/                # Zsh + Oh-My-Zsh
├── brew/                   # macOS Homebrew installer
│   └── install             # Homebrew + apps
├── pacman/                 # Arch Linux installer
│   ├── install             # Main pacman installer
│   └── pkglist.txt         # Package list
├── .config/                # XDG config directory
│   ├── nvim/               # Neovim configuration
│   ├── rofi/               # Application launcher
│   └── dunst/              # Notification daemon
├── .i3/                    # i3 window manager
│   ├── config              # Main i3 config
│   └── *.sh                # Helper scripts
├── bin/                    # Custom compiled binaries (gitignored)
├── keys/                   # Secrets and tokens (gitignored)
└── setup_scripts/          # Optional post-install scripts
```

## Key Bindings

### tmux

| Binding | Action |
|---------|--------|
| `Ctrl+A` | Prefix (replaces `Ctrl+B`) |
| `Prefix + \|` | Split vertically |
| `Prefix + -` | Split horizontally |
| `Ctrl+h/j/k/l` | Navigate panes (vim-aware) |
| `Alt+h/j/k/l` | Resize panes |
| `Prefix + r` | Reload config |

### Vim/Neovim

| Binding | Action |
|---------|--------|
| `,` | Leader key |
| `Ctrl+P` | FZF file search |
| `Ctrl+h/j/k/l` | Navigate splits/tmux panes |

### i3 Window Manager

| Binding | Action |
|---------|--------|
| `Super+Enter` | Open terminal |
| `Super+d` | Rofi launcher |
| `Super+h/j/k/l` | Navigate windows |
| `Super+Shift+h/j/k/l` | Move windows |
| `Super+[1-9]` | Switch workspace |
| `Super+Shift+q` | Close window |

### macOS (skhd + yabai)

| Binding | Action |
|---------|--------|
| `Alt+Return` | Open Alacritty |
| `Alt+h/j/k/l` | Focus window |
| `Alt+Shift+h/j/k/l` | Move window |
| `Alt+[1-4]` | Switch space |

## Shell Aliases

### Git

```bash
g       # git
gs      # git status -sb
ga      # git add -p
gca     # git commit --amend
gdc     # git diff --cached
gfc     # git fetch origin && git checkout origin/main
gfr     # git fetch origin && git rebase -i origin/main
gcf     # git diff-tree (show files in commit)
```

### Navigation

```bash
..      # cd ..
...     # cd ../../../
....    # cd ../../../../
c       # clear
ll      # ls -al
l.      # ls -d .* (hidden files)
```

### Development

```bash
m       # make
k       # kubectl
mux     # tmuxinator
air     # asdf install ruby (from .ruby-version)
vim     # nvim (if installed)
a       # alias | fzf (search aliases)
```

### Utilities

```bash
h           # ping 8.8.8.8 (connectivity check)
path        # echo PATH (one per line)
ports       # netstat -tulanp
diskusage   # du -h -d1 | sort -h
copy/paste  # xclip clipboard integration
```

## Customization

### Local Git Config

Create `~/.gitconfig.local` for personal settings:

```ini
[user]
    name = Your Name
    email = your@email.com
```

### Secrets

Store tokens in `~/.dotfiles/keys/` (gitignored):

```bash
# ~/.dotfiles/keys/GITLAB_TOKEN
export GITLAB_TOKEN="your-token-here"
```

### Adding Custom Aliases

Add to `~/.zsh_aliases` or create `~/.zsh_aliases.local`:

```bash
alias myalias='my command'
```

## Troubleshooting

### Symlink Conflicts

If `link-dotfiles.rb` reports "File Exists":

```bash
# Back up the existing file
mv ~/.vimrc ~/.vimrc.backup

# Re-run the linker
~/.dotfiles/link-dotfiles.rb
```

### Font Issues

Install a Nerd Font for proper icon rendering:

```bash
# macOS
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Arch
sudo pacman -S ttf-jetbrains-mono-nerd

# Ubuntu/Debian
# Download from https://www.nerdfonts.com/font-downloads
```

### tmux Colors

If colors appear wrong:

```bash
# Ensure terminal supports 256 colors
echo $TERM  # Should be xterm-256color or similar

# In tmux
tmux kill-server && tmux
```

## CI/CD

- **GitHub Actions**: Automated testing on Ubuntu and Arch Docker
- **Docker Hub**: Auto-publish on merge to main

## License

MIT License - Copyright 2017 Alex Piechowski

## Credits

Fork of [grepsedawk/.dotfiles](https://github.com/grepsedawk/.dotfiles)
