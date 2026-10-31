#!/bin/bash
# Skill: standup-update
# Purpose: Auto-generate daily standup from Git commits and Jira updates
#
# Usage: lxi standup generate [YYYY-MM-DD]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
PROGRESS_DIR="$REPO_ROOT/product/progress"

# Get date from argument or use today
DATE="${1:-$(date +%Y-%m-%d)}"
STANDUP_FILE="$PROGRESS_DIR/${DATE}-standup.md"

# Get yesterday's date for commit lookup (handle both macOS and Linux date commands)
if date -v-1d +%Y-%m-%d >/dev/null 2>&1; then
    # macOS
    YESTERDAY=$(date -v-1d +%Y-%m-%d)
else
    # GNU/Linux
    YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
fi

echo "Generating standup for $DATE..."
echo ""

# Start building the standup document
cat > "$STANDUP_FILE" <<EOF
# Daily Standup - $DATE

## Team Updates

EOF

# Get unique authors from yesterday's commits
AUTHORS=$(git log --since="$YESTERDAY 00:00" --until="$YESTERDAY 23:59" --format="%an" | sort -u)

if [ -z "$AUTHORS" ]; then
    echo "No Git activity found for $YESTERDAY"
    AUTHORS=$(git log --since="7 days ago" --format="%an" | sort -u | head -5)
fi

# For each author, get their commits
for AUTHOR in $AUTHORS; do
    echo "### $AUTHOR" >> "$STANDUP_FILE"
    echo "" >> "$STANDUP_FILE"

    # Yesterday's work (from commits)
    echo "**Yesterday:**" >> "$STANDUP_FILE"
    git log --author="$AUTHOR" --since="$YESTERDAY 00:00" --until="$YESTERDAY 23:59" \
        --format="- %s" >> "$STANDUP_FILE" 2>/dev/null || echo "- No commits" >> "$STANDUP_FILE"
    echo "" >> "$STANDUP_FILE"

    # Today's plan (TODO: integrate with Jira)
    echo "**Today:**" >> "$STANDUP_FILE"
    echo "- _[Update with planned work]_" >> "$STANDUP_FILE"
    echo "" >> "$STANDUP_FILE"

    # Blockers
    echo "**Blockers:**" >> "$STANDUP_FILE"
    echo "- None" >> "$STANDUP_FILE"
    echo "" >> "$STANDUP_FILE"
done

echo "Created: $STANDUP_FILE"
echo ""
echo "Review and update the standup document with:"
echo "- Today's planned work for each team member"
echo "- Any blockers or dependencies"
