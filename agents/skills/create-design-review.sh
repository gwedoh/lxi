#!/bin/bash
# Skill: create-design-review
# Purpose: Create a new Design Review from template
#
# Usage: lxi create design-review [feature]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
DR_DIR="$REPO_ROOT/principles/design-reviews"
TEMPLATE="$DR_DIR/design-review-template.md"

# Get feature name from argument or prompt
FEATURE="${1:-}"
if [ -z "$FEATURE" ]; then
    echo "Enter feature/initiative name:"
    read -r FEATURE
fi

# Create filename with today's date
TODAY=$(date +%Y-%m-%d)
FILENAME=$(echo "$FEATURE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
DR_FILE="$DR_DIR/${TODAY}-${FILENAME}.md"

# Copy template
cp "$TEMPLATE" "$DR_FILE"

# Update template with date and title
sed -i.bak "s/YYYY-MM-DD/$TODAY/" "$DR_FILE"
sed -i.bak "s/\\[Feature\\/Initiative Name\\]/$FEATURE/" "$DR_FILE"
rm "${DR_FILE}.bak"

echo "Created: $DR_FILE"
echo "Status: Draft"
echo "Date: $TODAY"
echo ""
echo "Next steps:"
echo "1. Fill in Requirements section"
echo "2. Add 2-3 solution options with pros/cons"
echo "3. Document recommended decision"
echo "4. Create technical implementation breakdown"
echo "5. Link to related Jira stories and ADRs"
