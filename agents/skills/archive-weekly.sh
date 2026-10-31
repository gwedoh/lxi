#!/bin/bash
# Skill: archive-weekly
# Purpose: Archive old LX documents
#
# Usage: lxi archive lx [YYYY-MM-DD]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LX_DIR="$REPO_ROOT/process/lx"

# Cutoff date (default: 30 days ago)
CUTOFF="${1:-}"
if [ -z "$CUTOFF" ]; then
    CUTOFF=$(date -v-30d +%Y-%m-%d 2>/dev/null || date -d "30 days ago" +%Y-%m-%d)
fi

CUTOFF_TIMESTAMP=$(date -j -f "%Y-%m-%d" "$CUTOFF" +%s 2>/dev/null || date -d "$CUTOFF" +%s)

echo "Archiving LX documents older than $CUTOFF..."
echo ""

ARCHIVED=0

# Find and archive old LX documents
find "$LX_DIR" -name "*-weekly.md" -not -path "*/archive/*" | while read -r FILE; do
    FILENAME=$(basename "$FILE")

    # Extract date from filename
    if [[ "$FILENAME" =~ ^([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
        DOC_DATE="${BASH_REMATCH[1]}"
        DOC_TIMESTAMP=$(date -j -f "%Y-%m-%d" "$DOC_DATE" +%s 2>/dev/null || date -d "$DOC_DATE" +%s)

        if [ $DOC_TIMESTAMP -lt $CUTOFF_TIMESTAMP ]; then
            # Extract year and month for archive structure
            YEAR=$(echo "$DOC_DATE" | cut -d'-' -f1)
            MONTH=$(echo "$DOC_DATE" | cut -d'-' -f2)

            # Create archive directory
            ARCHIVE_DIR="$LX_DIR/archive/$YEAR/$MONTH"
            mkdir -p "$ARCHIVE_DIR"

            # Move file to archive
            mv "$FILE" "$ARCHIVE_DIR/"
            echo "Archived: $FILENAME → archive/$YEAR/$MONTH/"
            ARCHIVED=$((ARCHIVED + 1))
        fi
    fi
done

if [ $ARCHIVED -eq 0 ]; then
    echo "No documents to archive (cutoff: $CUTOFF)"
else
    echo ""
    echo "Archived $ARCHIVED document(s)"
    echo "Location: $LX_DIR/archive/"
fi
