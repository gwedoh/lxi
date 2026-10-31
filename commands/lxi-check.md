# lxi check

Check document freshness and staleness.

## Usage

```bash
lxi check freshness [threshold-days]
```

## Commands

### lxi check freshness

Identify stale analysis and documents that may need updating.

**Usage:**
```bash
lxi check freshness [threshold]
```

**Arguments:**
- `threshold` (optional): Number of days before a document is considered stale. Default: 30 days.

**Examples:**
```bash
lxi check freshness       # Use default 30-day threshold
lxi check freshness 60    # Use 60-day threshold
lxi check freshness 14    # More aggressive 14-day threshold
```

## What it does

Scans dated documents and checks their age:

**Documents checked:**
1. **ADRs** - `principles/adrs/XXXX-*.md`
2. **Design Reviews** - `principles/design-reviews/YYYY-MM-DD-*.md`
3. **LX Documents** - `process/lx/YYYY-MM-DD-weekly.md`
4. **Context Analysis** - `context/analysis/YYYY-MM-DD-*.md`

**Date extraction:**
- Filenames with dates: `YYYY-MM-DD-topic.md`
- ADR headers: `Date: YYYY-MM-DD`

## Output

**Success:**
```
Checking document freshness (threshold: 30 days)...

## Architecture Decision Records
## Design Reviews
## LX Documents
## Context Analysis

✅ All documents are fresh (< 30 days old)
```

**Stale documents found:**
```
Checking document freshness (threshold: 30 days)...

## Architecture Decision Records
⚠️  STALE: principles/adrs/0001-database-selection.md
   Date: 2024-08-15 (72 days old)

## Design Reviews
⚠️  STALE: principles/design-reviews/2024-09-01-auth-flow.md
   Date: 2024-09-01 (55 days old)

## LX Documents
⚠️  STALE: process/lx/2024-08-05-weekly.md
   Date: 2024-08-05 (82 days old)

Found 3 stale document(s)

Recommendations:
1. Review stale documents for accuracy
2. Update with current information or archive
3. Use 'lxi archive lx' for old LX documents
```

## Philosophy: Analysis Grows Stale

From [LXI Core Principles](../ARCHITECTURE.md#core-philosophy):

> **Analysis grows stale** - Documentation must be dated and refreshed

**Why dates matter:**
- Technical decisions age as systems evolve
- Old analysis can mislead new team members
- Dated documents signal "review before trusting"

**What to do with stale documents:**
1. **Review**: Is the information still accurate?
2. **Update**: Refresh with current state, update date
3. **Archive**: Move to archive if no longer relevant
4. **Supersede**: Create new ADR/Design Review that supersedes old one

## Integration

### In CI/CD
```yaml
# .gitlab-ci.yml
check-freshness:
  script:
    - lxi check freshness
  allow_failure: true  # Warning, not error
  only:
    - schedules  # Run weekly
```

### As Pre-commit Hook
```bash
# .git/hooks/pre-commit
#!/bin/bash
lxi check freshness 30 || {
    echo "⚠️  Warning: Some documents are stale"
    echo "Run 'lxi check freshness' for details"
}
```

### Periodic Review
```bash
# Weekly review of stale docs
lxi check freshness 30 > stale-docs-$(date +%Y-%m-%d).txt
```

## Related

- Skill: `agents/skills/check-freshness.sh`
- Archive command: `lxi archive`
- Core Principle: [Analysis Grows Stale](../ARCHITECTURE.md#2-analysis-grows-stale-with-time)

---

## See Also

- [lxi archive](lxi-archive.md) - Archive old documents
- [lxi validate](lxi-validate.md) - Validate cross-references
- [Architecture](../ARCHITECTURE.md#context-management) - Context management
