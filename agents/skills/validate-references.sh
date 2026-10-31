#!/bin/bash
# Skill: validate-references
# Purpose: Check all cross-references for validity
#
# Usage: lxi validate

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "Validating cross-references in repository..."
echo ""

BROKEN_LINKS=0

# Find all markdown files
find "$REPO_ROOT" -name "*.md" -not -path "*/node_modules/*" -not -path "*/.git/*" | while read -r FILE; do
    # Extract markdown links [text](path)
    grep -oE '\[([^]]+)\]\(([^)]+)\)' "$FILE" | while read -r LINK; do
        # Extract path from link
        PATH_PART=$(echo "$LINK" | sed -E 's/\[([^]]+)\]\(([^)]+)\)/\2/')

        # Skip external URLs
        if [[ "$PATH_PART" =~ ^https?:// ]]; then
            continue
        fi

        # Skip anchors-only links
        if [[ "$PATH_PART" =~ ^# ]]; then
            continue
        fi

        # Remove anchor if present
        FILE_PATH=$(echo "$PATH_PART" | cut -d'#' -f1)

        # Resolve relative path
        if [[ "$FILE_PATH" =~ ^\.\. ]]; then
            # Relative to current file
            DIR=$(dirname "$FILE")
            TARGET="$DIR/$FILE_PATH"
        elif [[ "$FILE_PATH" =~ ^\. ]]; then
            DIR=$(dirname "$FILE")
            TARGET="$DIR/$FILE_PATH"
        else
            # Assume relative to repo root
            TARGET="$REPO_ROOT/$FILE_PATH"
        fi

        # Check if target exists
        if [ ! -e "$TARGET" ]; then
            echo "❌ Broken link in $FILE"
            echo "   Link: $LINK"
            echo "   Target: $TARGET"
            echo ""
            BROKEN_LINKS=$((BROKEN_LINKS + 1))
        fi
    done
done

if [ $BROKEN_LINKS -eq 0 ]; then
    echo "✅ All cross-references are valid"
else
    echo "Found $BROKEN_LINKS broken link(s)"
    exit 1
fi
