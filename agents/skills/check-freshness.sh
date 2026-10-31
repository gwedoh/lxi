#!/bin/bash
# Skill: check-freshness
# Purpose: Identify stale analysis and documents
#
# Usage: lxi check freshness [threshold-days]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Staleness threshold in days (default: 30)
THRESHOLD="${1:-30}"
CURRENT_DATE=$(date +%s)
STALE_COUNT=0

echo "Checking document freshness (threshold: $THRESHOLD days)..."
echo ""

# Function to check if a document is stale
check_stale() {
    local FILE="$1"
    local DATE_PATTERN="$2"

    # Extract date from filename or content
    if [[ "$FILE" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
        DOC_DATE="${BASH_REMATCH[1]}"
        DOC_TIMESTAMP=$(date -j -f "%Y-%m-%d" "$DOC_DATE" +%s 2>/dev/null || date -d "$DOC_DATE" +%s)
        AGE_DAYS=$(( (CURRENT_DATE - DOC_TIMESTAMP) / 86400 ))

        if [ $AGE_DAYS -gt $THRESHOLD ]; then
            echo "⚠️  STALE: $FILE"
            echo "   Date: $DOC_DATE ($AGE_DAYS days old)"
            echo ""
            STALE_COUNT=$((STALE_COUNT + 1))
        fi
    fi
}

# Check ADRs
echo "## Architecture Decision Records"
find "$REPO_ROOT/principles/adrs" -name "*.md" -not -name "*template*" | while read -r FILE; do
    check_stale "$FILE"
done

# Check Design Reviews
echo "## Design Reviews"
find "$REPO_ROOT/principles/design-reviews" -name "*.md" -not -name "*template*" | while read -r FILE; do
    check_stale "$FILE"
done

# Check LX Documents
echo "## LX Documents"
find "$REPO_ROOT/process/lx" -name "*-weekly.md" | while read -r FILE; do
    check_stale "$FILE"
done

# Check Context Analysis
if [ -d "$REPO_ROOT/context/analysis" ]; then
    echo "## Context Analysis"
    find "$REPO_ROOT/context/analysis" -name "*.md" | while read -r FILE; do
        check_stale "$FILE"
    done
fi

if [ $STALE_COUNT -eq 0 ]; then
    echo "✅ All documents are fresh (< $THRESHOLD days old)"
else
    echo "Found $STALE_COUNT stale document(s)"
    echo ""
    echo "Recommendations:"
    echo "1. Review stale documents for accuracy"
    echo "2. Update with current information or archive"
    echo "3. Use 'lxi archive lx' for old LX documents"
fi
