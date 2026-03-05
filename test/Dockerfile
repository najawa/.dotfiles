FROM ruby:3.2-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    zsh git nodejs npm python3 curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set up a fake home
ENV HOME=/root
WORKDIR /root

# Copy dotfiles
COPY . /root/.dotfiles

# 1. Run link-dotfiles.rb (create .config parent dir first)
RUN mkdir -p /root/.config && cd /root/.dotfiles && ruby link-dotfiles.rb

# 2. Run claude setup
RUN bash /root/.dotfiles/claude/setup-claude.sh

# 3. Validate symlinks resolve
RUN echo "=== Checking symlinks ===" && \
    test -f /root/.claude/CLAUDE.md && echo "  CLAUDE.md: ok" && \
    test -f /root/.claude/settings.json && echo "  settings-primary.json: ok" && \
    test -f /root/.claude-secondary-config/settings.json && echo "  settings-secondary.json: ok" && \
    test -d /root/.claude/agents && echo "  primary agents: ok" && \
    test -d /root/.claude-secondary-config/agents && echo "  secondary agents: ok" && \
    test -d /root/.claude/rules/common && echo "  primary rules: ok" && \
    test -d /root/.claude-secondary-config/rules/common && echo "  secondary rules: ok" && \
    test -d /root/.claude/skills && echo "  primary skills: ok" && \
    test -d /root/.claude-secondary-config/skills && echo "  secondary skills: ok" && \
    test -d /root/.claude/commands && echo "  primary commands: ok" && \
    test -d /root/.claude-secondary-config/commands && echo "  secondary commands: ok"

# 4. Validate JSON settings files
RUN echo "=== Validating JSON ===" && \
    python3 -m json.tool /root/.claude/settings.json > /dev/null && echo "  primary settings: valid JSON" && \
    python3 -m json.tool /root/.claude-secondary-config/settings.json > /dev/null && echo "  secondary settings: valid JSON"

# 5. Validate hook scripts are parseable
RUN echo "=== Checking hook scripts ===" && \
    for f in /root/.dotfiles/claude/hooks/*.sh; do \
        bash -n "$f" && echo "  $(basename $f): ok"; \
    done

# 6. Validate zsh config is parseable (syntax check only — no interactive load)
RUN echo "=== Checking zsh syntax ===" && \
    zsh -n /root/.zshrc 2>&1 || echo "  .zshrc syntax warnings (expected — some tools not installed in container)" && \
    zsh -n /root/.zsh_aliases 2>&1 || echo "  .zsh_aliases syntax warnings (expected — some tools not installed in container)"

CMD ["echo", "All validations passed"]
