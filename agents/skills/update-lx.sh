#!/bin/bash
# Skill: update-lx
# Purpose: Generate or update weekly LX document
#
# Usage: lxi update lx [YYYY-MM-DD]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LX_DIR="$REPO_ROOT/process/lx"
TEMPLATE="$LX_DIR/lx-template.md"

# Get week date from argument or use Monday of current week
WEEK_DATE="${1:-}"
if [ -z "$WEEK_DATE" ]; then
    # Get Monday of current week
    WEEK_DATE=$(date -v-$(date +%u)d -v+1d +%Y-%m-%d 2>/dev/null || date -d "last monday" +%Y-%m-%d)
fi

LX_FILE="$LX_DIR/${WEEK_DATE}-weekly.md"

# Check if file exists
if [ -f "$LX_FILE" ]; then
    echo "Updating existing LX document: $LX_FILE"
    # TODO: Implement update logic
    # - Pull from Jira for epic statuses
    # - Aggregate daily standups for accomplishments
    # - Identify blockers
else
    echo "Creating new LX document: $LX_FILE"
    cp "$TEMPLATE" "$LX_FILE"

    # Update date in template
    sed -i.bak "s/Week of: YYYY-MM-DD/Week of: $WEEK_DATE/" "$LX_FILE"
    rm "${LX_FILE}.bak"
fi

echo ""
echo "LX Document: $LX_FILE"
echo ""
echo "Next steps:"
echo "1. Update epic statuses (🟢🟡🔴)"
echo "2. Fill in 'Last Week' accomplishments"
echo "3. Add 'This Week' planned work"
echo "4. Document open decisions"
echo "5. Flag any blockers"
echo "6. Sync to Confluence: lxi sync confluence"
