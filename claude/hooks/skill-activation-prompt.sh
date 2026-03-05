#!/bin/bash
set -e

cd "$HOME/.dotfiles/claude/hooks"
cat | npx tsx skill-activation-prompt.ts
