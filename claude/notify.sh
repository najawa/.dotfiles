#!/usr/bin/env bash
INPUT=$(cat)
MESSAGE=$(echo "$INPUT" | /opt/homebrew/bin/jq -r '.message // "Needs attention"')
TITLE=$(echo "$INPUT" | /opt/homebrew/bin/jq -r '.title // "TechJoy"')
SESSION=$(echo "$INPUT" | /opt/homebrew/bin/jq -r '.session_id // "unknown"')
PROJECT=$(echo "$INPUT" | /opt/homebrew/bin/jq -r '.cwd // empty' | xargs basename 2>/dev/null || echo "")

/opt/homebrew/bin/terminal-notifier \
    -title "${TITLE}" \
    -subtitle "${PROJECT}" \
    -message "${MESSAGE}" \
    -group "claude-${SESSION}"
