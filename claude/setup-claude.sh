#!/usr/bin/env bash
# setup-claude.sh — Symlink Claude Code configs from dotfiles to config directories
set -euo pipefail

DOTFILES_CLAUDE="$HOME/.dotfiles/claude"
PRIMARY="$HOME/.claude"
SECONDARY="$HOME/.claude-secondary-config"

# Ensure target directories exist
mkdir -p "$PRIMARY" "$SECONDARY"

link_item() {
    local src="$1"
    local dest="$2"
    local name
    name=$(basename "$src")

    if [ -L "$dest" ]; then
        local current
        current=$(readlink "$dest")
        if [ "$current" = "$src" ]; then
            echo "  [ok]  $dest"
            return
        fi
        rm "$dest"
    elif [ -e "$dest" ]; then
        echo "  [SKIP] $dest exists and is not a symlink — back it up manually"
        return
    fi

    ln -s "$src" "$dest"
    echo "  [NEW] $dest -> $src"
}

echo "Setting up Claude Code configs..."
echo ""

# Shared directories: agents, commands, skills, rules
for dir in agents commands skills rules; do
    src="$DOTFILES_CLAUDE/$dir"
    if [ -d "$src" ]; then
        echo "[$dir]"
        link_item "$src" "$PRIMARY/$dir"
        link_item "$src" "$SECONDARY/$dir"
        echo ""
    fi
done

# Config files (different per instance)
echo "[config]"
link_item "$DOTFILES_CLAUDE/config/CLAUDE.md" "$PRIMARY/CLAUDE.md"
link_item "$DOTFILES_CLAUDE/config/CLAUDE.md" "$SECONDARY/CLAUDE.md"
link_item "$DOTFILES_CLAUDE/config/settings-primary.json" "$PRIMARY/settings.json"
link_item "$DOTFILES_CLAUDE/config/settings-secondary.json" "$SECONDARY/settings.json"
echo ""

echo "Done."
