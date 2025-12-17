# Keybindings Cheatsheet

Quick reference for all keybindings across configured applications.

## Philosophy

This configuration follows a **Vim-centric navigation philosophy**:

- `h` = left, `j` = down, `k` = up, `l` = right
- Consistent keybindings across all tools
- Seamless navigation between tmux panes and Vim splits

---

## tmux

**Prefix:** `Ctrl+A` (not the default `Ctrl+B`)

### Session Management

| Binding | Action |
|---------|--------|
| `Prefix + c` | New session |
| `Prefix + d` | Detach from session |
| `Prefix + $` | Rename session |
| `Prefix + s` | List sessions |

### Window Management

| Binding | Action |
|---------|--------|
| `Prefix + c` | New window |
| `Prefix + ,` | Rename window |
| `Prefix + n` | Next window |
| `Prefix + p` | Previous window |
| `Prefix + [0-9]` | Go to window N |

### Pane Management

| Binding | Action |
|---------|--------|
| `Prefix + \|` | Split vertically |
| `Prefix + -` | Split horizontally |
| `Prefix + x` | Close pane |
| `Prefix + z` | Toggle pane zoom |
| `Prefix + !` | Convert pane to window |

### Pane Navigation (vim-tmux-navigator)

| Binding | Action |
|---------|--------|
| `Ctrl+h` | Focus pane left (or Vim split) |
| `Ctrl+j` | Focus pane down (or Vim split) |
| `Ctrl+k` | Focus pane up (or Vim split) |
| `Ctrl+l` | Focus pane right (or Vim split) |
| `Ctrl+\` | Focus previous pane |

### Pane Resizing

| Binding | Action |
|---------|--------|
| `Alt+h` | Resize left (1 cell) |
| `Alt+j` | Resize down (1 cell) |
| `Alt+k` | Resize up (1 cell) |
| `Alt+l` | Resize right (1 cell) |
| `Ctrl+Alt+h` | Resize left (10 cells) |
| `Ctrl+Alt+j` | Resize down (10 cells) |
| `Ctrl+Alt+k` | Resize up (10 cells) |
| `Ctrl+Alt+l` | Resize right (10 cells) |

### Misc

| Binding | Action |
|---------|--------|
| `Prefix + r` | Reload tmux config |
| `Prefix + [` | Enter copy mode |
| `Prefix + ]` | Paste buffer |

---

## Vim / Neovim

**Leader Key:** `,` (comma)

### File Navigation

| Binding | Action |
|---------|--------|
| `Ctrl+p` | FZF file search (git-aware) |
| `Leader + t` | Search tags |
| `Leader + a` | Ag search |

### Window/Split Navigation

| Binding | Action |
|---------|--------|
| `Ctrl+h` | Move to left split/tmux pane |
| `Ctrl+j` | Move to bottom split/tmux pane |
| `Ctrl+k` | Move to top split/tmux pane |
| `Ctrl+l` | Move to right split/tmux pane |

### Editing

| Binding | Action |
|---------|--------|
| `Ctrl+s` | Save file and exit insert mode |
| `jk` or `kj` | Escape (exit insert mode) |
| `Leader + '` | Change surrounding `"` to `'` |
| `Leader + "` | Change surrounding `'` to `"` |
| `Leader + co` | Copy entire file to clipboard |

### Configuration

| Binding | Action |
|---------|--------|
| `Leader + so` | Source (reload) .vimrc |
| `Leader + vi` | Edit .vimrc in new tab |
| `Leader + vl` | Edit init.lua in new tab |
| `Leader + vn` | Edit notes.md in new tab |

### Git (vim-fugitive)

| Binding | Action |
|---------|--------|
| `Leader + g` | Git command prompt |

### Macros & Dispatch

| Binding | Action |
|---------|--------|
| `Leader + q` | Run macro in register q |
| `Leader + o` | Run Dispatch command |
| `Leader + r` | Resize terminal |

### Tags (ctags)

| Binding | Action |
|---------|--------|
| `Ctrl+\` | Jump to tag in new tab |
| `Alt+]` | Jump to tag in vertical split |

### File Operations

| Binding | Action |
|---------|--------|
| `Leader + n` | Rename current file |

### Arrow Keys

Arrow keys are **disabled** to encourage hjkl usage:

```
Up/Down/Left/Right -> (disabled in normal and insert mode)
```

---

## i3 Window Manager (Linux)

**Modifier Key:** `Super` (Windows/Command key)

### Applications

| Binding | Action |
|---------|--------|
| `Super+Return` | Open Alacritty terminal |
| `Super+b` | Open Google Chrome |
| `Super+d` | Rofi run menu |
| `Super+Shift+d` | Rofi desktop app menu |
| `Super+c` | Rofi SSH menu |
| `Super+t` | Connect Bose 700 Bluetooth |

### Window Focus

| Binding | Action |
|---------|--------|
| `Super+h` | Focus left |
| `Super+j` | Focus down |
| `Super+k` | Focus up |
| `Super+l` | Focus right |
| `Super+Left/Down/Up/Right` | Focus (arrow keys) |
| `Super+a` | Focus parent container |

### Window Movement

| Binding | Action |
|---------|--------|
| `Super+Shift+h` | Move window left |
| `Super+Shift+j` | Move window down |
| `Super+Shift+k` | Move window up |
| `Super+Shift+l` | Move window right |
| `Super+Shift+Left/Down/Up/Right` | Move (arrow keys) |

### Window Actions

| Binding | Action |
|---------|--------|
| `Super+Shift+q` | Kill focused window |
| `Super+f` | Toggle fullscreen |
| `Super+Shift+Space` | Toggle floating |
| `Super+Space` | Focus mode toggle (tiling/floating) |
| `Super+v` | Split vertical |
| `Super+Ctrl+h` | Split horizontal |

### Layout

| Binding | Action |
|---------|--------|
| `Super+w` | Tabbed layout |
| `Super+e` | Toggle split layout |

### Workspaces

| Binding | Action |
|---------|--------|
| `Super+[1-9,0]` | Switch to workspace 1-10 |
| `Super+Shift+[1-9,0]` | Move window to workspace 1-10 |
| `Super+Tab` | Move workspace to right monitor |
| `Super+Shift+Tab` | Move workspace to left monitor |

### Gaps

| Binding | Action |
|---------|--------|
| `Super+z` | Increase outer gaps (+5) |
| `Super+Shift+z` | Decrease outer gaps (-5) |

### Resize Mode

Press `Super+r` to enter resize mode:

| Binding | Action |
|---------|--------|
| `h` or `Left` | Shrink width |
| `j` or `Down` | Grow height |
| `k` or `Up` | Shrink height |
| `l` or `Right` | Grow width |
| `Escape` or `Return` | Exit resize mode |

### Media Keys

| Binding | Action |
|---------|--------|
| `XF86AudioRaiseVolume` | Volume up (+5%) |
| `XF86AudioLowerVolume` | Volume down (-5%) |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPlay` | Play/Pause |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |
| `XF86MonBrightnessUp` | Brightness up |
| `XF86MonBrightnessDown` | Brightness down |

### Audio Switcher

| Binding | Action |
|---------|--------|
| `Super+[` | Switch to Yeti microphone |
| `Super+]` | Switch to speakers |

### System

| Binding | Action |
|---------|--------|
| `Super+Ctrl+l` | Lock screen |
| `Super+Shift+s` | Screenshot |
| `Super+Shift+c` | Reload i3 config |
| `Super+Shift+r` | Restart i3 |
| `Super+Shift+e` | Exit i3 (logout) |

### Keyboard Layout

| Binding | Action |
|---------|--------|
| `Super+s` | US QWERTY layout |
| `Super+;` | US Dvorak layout |

---

## yabai + skhd (macOS)

**Modifier Key:** `Alt/Option`

### Applications

| Binding | Action |
|---------|--------|
| `Alt+Return` | Open Alacritty |
| `Alt+s` | Open Slack |
| `Alt+b` | Open Google Chrome |
| `Alt+o` | Open Obsidian |
| `Alt+t` | Open Tuple |

### Window Focus

| Binding | Action |
|---------|--------|
| `Alt+h` | Focus window west |
| `Alt+j` | Focus window south |
| `Alt+k` | Focus window north |
| `Alt+l` | Focus window east |

### Window Movement

| Binding | Action |
|---------|--------|
| `Alt+Shift+h` | Warp window west |
| `Alt+Shift+j` | Warp window south |
| `Alt+Shift+k` | Warp window north |
| `Alt+Shift+l` | Warp window east |

### Window Actions

| Binding | Action |
|---------|--------|
| `Alt+Shift+q` | Close window |
| `Alt+f` | Toggle native fullscreen |
| `Alt+Shift+Space` | Toggle float |

### Layout

| Binding | Action |
|---------|--------|
| `Alt+w` | Float layout |
| `Alt+e` | BSP (tiling) layout |

### Spaces (requires Mission Control setup)

| Binding | Action |
|---------|--------|
| `Alt+[1-4]` | Switch to space 1-4 (set in System Preferences) |
| `Alt+Shift+[1-4]` | Move window to space 1-4 |

### System

| Binding | Action |
|---------|--------|
| `Alt+Shift+r` | Restart skhd & yabai |
| `Alt+Shift+s` | Screenshot to clipboard |

---

## Shell (Zsh)

### FZF

| Binding | Action |
|---------|--------|
| `Ctrl+t` | Fuzzy file finder |
| `Ctrl+r` | Fuzzy history search |
| `Alt+c` | Fuzzy cd |

### Navigation Aliases

| Alias | Expands To |
|-------|------------|
| `..` | `cd ..` |
| `...` | `cd ../../../` |
| `....` | `cd ../../../../` |

---

## Cross-Application Navigation

The killer feature of this configuration is **seamless navigation** between tmux and Vim using the vim-tmux-navigator plugin:

```
┌──────────────────────────────────────────────────────┐
│  tmux pane 1  │  tmux pane 2 (running Vim)           │
│               │  ┌────────────┬────────────┐        │
│               │  │ Vim split 1│ Vim split 2│        │
│               │  │            │            │        │
│               │  └────────────┴────────────┘        │
└──────────────────────────────────────────────────────┘

Ctrl+h/j/k/l moves focus seamlessly between:
- tmux panes
- Vim splits within those panes
```

This works because both tmux and Vim are configured to use the same navigation commands and the vim-tmux-navigator plugin handles the boundary detection.
