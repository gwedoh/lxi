#!/bin/bash
# Skill: create-adr
# Purpose: Interactively create a new ADR from template
#
# Usage: lxi create adr [topic]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ADR_DIR="$REPO_ROOT/principles/adrs"
TEMPLATE="$ADR_DIR/adr-template.md"

# Get topic from argument or prompt
TOPIC="${1:-}"
if [ -z "$TOPIC" ]; then
    echo "Enter ADR topic:"
    read -r TOPIC
fi

# Find next ADR number
LAST_ADR=$(ls "$ADR_DIR" | grep -E '^[0-9]{4}' | sort | tail -1 | cut -d'-' -f1)
if [ -z "$LAST_ADR" ]; then
    NEXT_NUM="0001"
else
    NEXT_NUM=$(printf "%04d" $((10#$LAST_ADR + 1)))
fi

# Create filename from topic (lowercase, replace spaces with hyphens)
FILENAME=$(echo "$TOPIC" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
ADR_FILE="$ADR_DIR/${NEXT_NUM}-${FILENAME}.md"

# Copy template
cp "$TEMPLATE" "$ADR_FILE"

# Update template with date and title
TODAY=$(date +%Y-%m-%d)
sed -i.bak "s/YYYY-MM-DD/$TODAY/" "$ADR_FILE"
sed -i.bak "s/ADR-NNNN/ADR-$NEXT_NUM/" "$ADR_FILE"
sed -i.bak "s/\\[Short Decision Title\\]/$TOPIC/" "$ADR_FILE"
rm "${ADR_FILE}.bak"

echo "Created: $ADR_FILE"
echo "Status: Proposed"
echo "Date: $TODAY"
echo ""
echo "Next steps:"
echo "1. Fill in Context and Problem Statement"
echo "2. Add Options Considered"
echo "3. Document Decision and Consequences"
echo "4. Link to related Jira epics"
