# Global Claude Code Instructions

## Docker Port Conflict Policy
When Docker containers fail to start due to port conflicts:
1. **NEVER kill, stop, or restart the process holding the port.** Assume all existing port bindings are mission-critical unless the user explicitly says otherwise.
2. **Identify the conflicting port(s)** from the error message.
3. **Check if `docker-compose.yml` already uses env var substitution** for that port (e.g., `${MYSQL_PORT:-3306}`). If not, add it with the default as the current hardcoded value.
4. **Add the port variable to `.env.example`** (or `.env.docker`, whichever is the committed template) with the default port value, so the repo ships with standard defaults.
5. **Update the local `.env` file** (which should be gitignored) with an alternate, non-conflicting port. Use `sed` or similar to update just the conflicting port — don't overwrite the whole file.
6. **Pick safe alternate ports:** For well-known ports, offset by a predictable amount (e.g., 3306 → 33060, 6379 → 63790, 80 → 8880, 443 → 8443).
7. **Re-run `docker compose up -d`** and verify the conflict is resolved.

This ensures default ports ship unchanged for new clones, while local development adapts to the user's environment without disrupting other services.
