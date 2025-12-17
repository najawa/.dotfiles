# Configuration Reference

Complete reference for all configuration files in this dotfiles repository.

## Table of Contents

- [Shell Configuration](#shell-configuration)
- [Editor Configuration](#editor-configuration)
- [Terminal & Multiplexer](#terminal--multiplexer)
- [Window Manager Configuration](#window-manager-configuration)
- [Git Configuration](#git-configuration)
- [Development Tools](#development-tools)
- [Desktop Environment](#desktop-environment)

---

## Shell Configuration

### `.zshrc`

Main Zsh configuration file.

```bash
# Location: ~/.zshrc -> ~/.dotfiles/.zshrc
```

**Key Settings:**

| Setting | Value | Description |
|---------|-------|-------------|
| `ZSH_THEME` | `robbyrussell` | Oh-My-Zsh prompt theme |
| `EDITOR` | `vim` | Default editor |
| `HISTSIZE` | `1000000000` | Command history size |
| `HIST_STAMPS` | `yyyy-mm-dd` | History timestamp format |

**Plugins Loaded:**

```
git, github, rails, bundler, terraform, tmux, tmuxinator,
asdf, docker, docker-compose, ssh-agent, heroku, aws, gh, fzf
```

**Customization:**

- Modify `ZSH_THEME` to change prompt appearance
- Add/remove plugins from the `plugins=()` array
- Create `~/.zshrc.local` for machine-specific settings (source it at the end)

### `.zsh_aliases`

Shell aliases and functions.

```bash
# Location: ~/.zsh_aliases -> ~/.dotfiles/.zsh_aliases
```

**Categories:**

| Category | Examples |
|----------|----------|
| Navigation | `..`, `...`, `ll`, `l.` |
| Git | `g`, `gs`, `ga`, `gca`, `gdc` |
| Development | `m`, `k`, `mux`, `air` |
| Utilities | `path`, `ports`, `diskusage` |
| Clipboard | `copy`, `paste` |

**Functions:**

| Function | Usage | Description |
|----------|-------|-------------|
| `log` | `log command` | Run command, save output to log.txt |
| `copy` | `copy command` | Copy command output to clipboard |
| `whereis` | `whereis IP` | IP geolocation lookup |
| `pwc` | `pwc` | Copy current path to clipboard |
| `wssh` | `wssh user@host` | Wait for host, then SSH |
| `getcol` | `cmd \| getcol 2` | Extract column from output |

### `.zprofile`

Login shell configuration (runs once at login).

```bash
# Location: ~/.zprofile -> ~/.dotfiles/.zprofile
```

**Contains:**

- PATH modifications
- Environment variable exports
- One-time initialization

---

## Editor Configuration

### `.vimrc`

Vim configuration with plugin management.

```vim
" Location: ~/.vimrc -> ~/.dotfiles/.vimrc
```

**Plugin Manager:** vim-plug

**Key Settings:**

| Setting | Value | Description |
|---------|-------|-------------|
| Leader | `,` | Custom leader key |
| Tab width | `2` | Spaces per tab |
| `expandtab` | `yes` | Spaces instead of tabs |
| `relativenumber` | `yes` | Relative line numbers |
| `spell` | `yes` | Spell checking enabled |

**Plugins:**

| Plugin | Purpose |
|--------|---------|
| `fzf` + `fzf.vim` | Fuzzy file finding |
| `vim-fugitive` | Git integration |
| `vim-gitgutter` | Git diff in gutter |
| `vim-polyglot` | Language syntax support |
| `vim-rails` | Rails development |
| `emmet-vim` | HTML/CSS expansion |
| `LanguageClient-neovim` | LSP support |
| `dracula_pro` | Color scheme |

**Colorscheme:** Dracula Pro (buffy variant)

### `.config/nvim/init.lua`

Neovim Lua configuration.

```lua
-- Location: ~/.config/nvim/init.lua -> ~/.dotfiles/.config/nvim/init.lua
```

**Plugin Manager:** packer.nvim

**Plugins:**

| Plugin | Purpose |
|--------|---------|
| `nvim-lspconfig` | Native LSP configuration |
| `vim-crystal` | Crystal language support |
| `vim-tmux-navigator` | tmux/vim navigation |
| `copilot.vim` | GitHub Copilot |

### `.emacs`

Emacs configuration with Evil mode (Vim keybindings).

```elisp
;; Location: ~/.emacs -> ~/.dotfiles/.emacs
```

**Key Features:**

- Evil mode (Vim emulation)
- FZF integration
- WakaTime tracking
- vim-tmux navigator

---

## Terminal & Multiplexer

### `.tmux.conf`

tmux configuration.

```bash
# Location: ~/.tmux.conf -> ~/.dotfiles/.tmux.conf
```

**Key Settings:**

| Setting | Value | Description |
|---------|-------|-------------|
| Prefix | `Ctrl+A` | Command prefix (not Ctrl+B) |
| Base index | `1` | Windows start at 1 |
| History limit | `25000` | Scrollback lines |
| Escape time | `0` | No delay (for Neovim) |

**Split Bindings:**

| Binding | Action |
|---------|--------|
| `Prefix + \|` | Vertical split |
| `Prefix + -` | Horizontal split |

**Pane Navigation:**

Uses vim-tmux-navigator for seamless Vim/tmux navigation with `Ctrl+h/j/k/l`.

**Resize Bindings:**

| Binding | Action |
|---------|--------|
| `Alt+h/j/k/l` | Resize by 1 |
| `Ctrl+Alt+h/j/k/l` | Resize by 10 |

**Color Scheme:** Dracula (custom colors defined)

### `.alacritty.yml`

Alacritty terminal configuration.

```yaml
# Location: ~/.alacritty.yml -> ~/.dotfiles/.alacritty.yml
```

**Settings:**

| Setting | Value |
|---------|-------|
| Font | JetBrainsMono Nerd Font |
| Opacity | 0.98 |
| Decorations | None |

---

## Window Manager Configuration

### `.i3/config` (Linux)

i3 window manager configuration.

```bash
# Location: ~/.i3/config -> ~/.dotfiles/.i3/config
```

**Key Settings:**

| Setting | Value |
|---------|-------|
| Modifier | `Super` (Windows key) |
| Font | JetBrainsMono Nerd Font |
| Inner gaps | 10px |
| Outer gaps | 10px |

**Startup Applications:**

- Wallpaper setter
- Battery monitor
- Redshift (blue light filter)
- Picom (compositor)
- Dunst (notifications)

**Color Scheme:** Dracula

### `.yabairc` (macOS)

yabai tiling window manager.

```bash
# Location: ~/.yabairc -> ~/.dotfiles/.yabairc
```

**Settings:**

| Setting | Value |
|---------|-------|
| Layout | BSP (Binary Space Partitioning) |
| Padding | 12px (all sides) |
| Window gap | 6px |

### `.skhdrc` (macOS)

skhd hotkey daemon configuration.

```bash
# Location: ~/.skhdrc -> ~/.dotfiles/.skhdrc
```

**Application Shortcuts:**

| Binding | Application |
|---------|-------------|
| `Alt+Return` | Alacritty |
| `Alt+S` | Slack |
| `Alt+B` | Google Chrome |
| `Alt+O` | Obsidian |
| `Alt+T` | Tuple |

---

## Git Configuration

### `.gitconfig`

Global Git configuration.

```ini
# Location: ~/.gitconfig -> ~/.dotfiles/.gitconfig
```

**Settings:**

| Section | Setting | Value |
|---------|---------|-------|
| `core` | `editor` | `nano` |
| `push` | `default` | `simple` |
| `pull` | `rebase` | `true` |
| `rebase` | `autosquash` | `true` |
| `rebase` | `autoStash` | `true` |
| `commit` | `verbose` | `true` |
| `init` | `defaultBranch` | `main` |

**Local Config:**

Machine-specific settings go in `~/.gitconfig.local`:

```ini
[user]
    name = Your Name
    email = your@email.com
[github]
    user = yourusername
```

### `.gitignore_global`

Global gitignore patterns.

```bash
# Location: ~/.gitignore_global -> ~/.dotfiles/.gitignore_global
```

---

## Development Tools

### `.asdfrc`

ASDF version manager configuration.

```bash
# Location: ~/.asdfrc -> ~/.dotfiles/.asdfrc
```

**Settings:**

```
legacy_version_file = yes
```

This enables reading version files like `.ruby-version`, `.nvmrc`, etc.

### `.default-gems`

Gems installed automatically with each Ruby version.

```
bundler
pry
solargraph
```

### `.default-python-packages`

Packages installed automatically with each Python version.

### `.railsrc`

Rails generator defaults.

```
--database=postgresql
--skip-spring
```

### `.pryrc`

Pry REPL configuration for Ruby.

---

## Desktop Environment

### `.config/rofi/config.rasi`

Rofi application launcher.

```css
/* Location: ~/.config/rofi/config.rasi */
```

**Settings:**

| Setting | Value |
|---------|-------|
| Theme | Arc-Dark |
| DPI | 250 |

### `.config/dunst/dunstrc`

Dunst notification daemon.

```ini
# Location: ~/.config/dunst/dunstrc
```

**Settings:**

| Setting | Value |
|---------|-------|
| Font | JetBrains Mono 14 |

### `.picom.conf`

Picom X11 compositor.

```bash
# Location: ~/.picom.conf -> ~/.dotfiles/.picom.conf
```

Handles transparency, shadows, animations, and blur effects.

### `.i3status.conf`

i3 status bar configuration.

```bash
# Location: ~/.i3status.conf -> ~/.dotfiles/.i3status.conf
```

**Modules:**

- IPv6 status
- Disk usage
- Wireless/Ethernet
- Battery
- System load
- Volume
- Date/Time

---

## File Locations Summary

| File | Symlinked From | Purpose |
|------|----------------|---------|
| `~/.zshrc` | `~/.dotfiles/.zshrc` | Shell config |
| `~/.zsh_aliases` | `~/.dotfiles/.zsh_aliases` | Aliases |
| `~/.vimrc` | `~/.dotfiles/.vimrc` | Vim config |
| `~/.config/nvim/init.lua` | `~/.dotfiles/.config/nvim/init.lua` | Neovim config |
| `~/.tmux.conf` | `~/.dotfiles/.tmux.conf` | tmux config |
| `~/.gitconfig` | `~/.dotfiles/.gitconfig` | Git config |
| `~/.i3/config` | `~/.dotfiles/.i3/config` | i3 config |
| `~/.alacritty.yml` | `~/.dotfiles/.alacritty.yml` | Terminal config |

---

## Environment Variables

Key environment variables set by these configurations:

| Variable | Set In | Purpose |
|----------|--------|---------|
| `EDITOR` | `.zshrc` | Default editor |
| `HISTSIZE` | `.zshrc` | History size |
| `FZF_BASE` | `.zshrc` | FZF location |
| `PYENV_ROOT` | `.zshrc` | Pyenv location |
| `NVM_DIR` | `.zshrc` | NVM location |
| `CLICOLOR` | `.zsh_aliases` | Colorize ls |
