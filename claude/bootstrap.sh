#!/bin/bash
set -e

DOTFILES_CLAUDE="$HOME/.dotfiles/claude"
SCRIPT_NAME=$(basename "$0")

usage() {
    echo "Usage: $SCRIPT_NAME <project-path> [--template <minimal|backend>] [--skills <skill1,skill2,...>]"
    echo ""
    echo "Bootstrap Claude Code infrastructure for a project."
    echo ""
    echo "Options:"
    echo "  --template <name>    Skill rules template (default: minimal)"
    echo "                       Available: minimal, backend"
    echo "  --skills <list>      Comma-separated tech-specific skills to copy"
    echo "                       Available: backend-dev-guidelines, frontend-dev-guidelines,"
    echo "                                  error-tracking, route-tester"
    echo ""
    echo "Examples:"
    echo "  $SCRIPT_NAME /path/to/my-project"
    echo "  $SCRIPT_NAME /path/to/my-project --template backend"
    echo "  $SCRIPT_NAME /path/to/my-project --template backend --skills backend-dev-guidelines,error-tracking"
    echo "  $SCRIPT_NAME .  # Bootstrap current directory"
}

# Parse arguments
PROJECT_PATH=""
TEMPLATE="minimal"
SKILLS=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --template)
            TEMPLATE="$2"
            shift 2
            ;;
        --skills)
            SKILLS="$2"
            shift 2
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            if [[ -z "$PROJECT_PATH" ]]; then
                PROJECT_PATH="$1"
            else
                echo "Error: Unexpected argument '$1'"
                usage
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$PROJECT_PATH" ]]; then
    echo "Error: Project path is required"
    usage
    exit 1
fi

# Resolve to absolute path
PROJECT_PATH=$(cd "$PROJECT_PATH" 2>/dev/null && pwd || echo "$PROJECT_PATH")

if [[ ! -d "$PROJECT_PATH" ]]; then
    echo "Error: Directory '$PROJECT_PATH' does not exist"
    exit 1
fi

echo "Bootstrapping Claude Code infrastructure for: $PROJECT_PATH"
echo "Template: $TEMPLATE"
echo ""

# Create .claude/skills directory
mkdir -p "$PROJECT_PATH/.claude/skills"
echo "  Created .claude/skills/"

# Copy skill-rules.json template
TEMPLATE_FILE="$DOTFILES_CLAUDE/templates/skill-rules-${TEMPLATE}.json"
if [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "Error: Template '$TEMPLATE' not found at $TEMPLATE_FILE"
    echo "Available templates:"
    ls "$DOTFILES_CLAUDE/templates/" | sed 's/skill-rules-//;s/\.json//' | while read t; do
        echo "  - $t"
    done
    exit 1
fi

cp "$TEMPLATE_FILE" "$PROJECT_PATH/.claude/skills/skill-rules.json"
echo "  Copied skill-rules.json (template: $TEMPLATE)"

# Copy tech-specific skills if requested
if [[ -n "$SKILLS" ]]; then
    # Source showcase repo for tech-specific skills
    SHOWCASE="$HOME/Development/artificial_intelligence/claude-code-infrastructure-showcase"

    IFS=',' read -ra SKILL_LIST <<< "$SKILLS"
    for skill in "${SKILL_LIST[@]}"; do
        skill=$(echo "$skill" | xargs)  # trim whitespace
        SKILL_SRC="$SHOWCASE/.claude/skills/$skill"
        if [[ -d "$SKILL_SRC" ]]; then
            cp -r "$SKILL_SRC" "$PROJECT_PATH/.claude/skills/"
            echo "  Copied skill: $skill"
        else
            echo "  Warning: Skill '$skill' not found at $SKILL_SRC, skipping"
        fi
    done
fi

# Create dev docs directories
mkdir -p "$PROJECT_PATH/dev/active"
mkdir -p "$PROJECT_PATH/dev/archive"
echo "  Created dev/active/ and dev/archive/"

# Copy dev docs README
cp "$DOTFILES_CLAUDE/dev/README.md" "$PROJECT_PATH/dev/README.md"
echo "  Copied dev/README.md"

echo ""
echo "Done! Project bootstrapped at $PROJECT_PATH"
echo ""
echo "Next steps:"
echo "  1. Review .claude/skills/skill-rules.json and adjust pathPatterns for your project"
echo "  2. Add tech-specific skills if needed: $SCRIPT_NAME $PROJECT_PATH --skills backend-dev-guidelines"
echo "  3. Add .claude/tsc-cache/ and dev/active/ to .gitignore if desired"
