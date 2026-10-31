# lxi archive

Archive old documents to maintain repository cleanliness.

## Usage

```bash
lxi archive <type> [cutoff-date]
```

## Commands

### lxi archive lx

Archive old LX (Living Experience) weekly documents.

**Usage:**
```bash
lxi archive lx [YYYY-MM-DD]
```

**Arguments:**
- `YYYY-MM-DD` (optional): Cutoff date. Documents older than this will be archived. Default: 30 days ago.

**Examples:**
```bash
lxi archive lx                  # Archive docs older than 30 days
lxi archive lx 2024-09-01       # Archive docs before Sept 1, 2024
lxi archive lx 2024-01-01       # Archive all docs from last year
```

## What it does

1. Finds LX documents older than cutoff date
2. Creates archive directory structure: `process/lx/archive/YYYY/MM/`
3. Moves old documents to appropriate year/month folder
4. Maintains organization by year and month

**Archive structure:**
```
process/lx/
├─ 2024-10-21-weekly.md          # Current/recent
├─ 2024-10-28-weekly.md
├─ archive/
│  ├─ 2024/
│  │  ├─ 01/
│  │  │  ├─ 2024-01-01-weekly.md
│  │  │  └─ 2024-01-08-weekly.md
│  │  ├─ 02/
│  │  │  ├─ 2024-02-05-weekly.md
│  │  │  └─ 2024-02-12-weekly.md
│  │  └─ 08/
│  │     └─ 2024-08-26-weekly.md
│  └─ 2023/
│     └─ 12/
│        └─ 2023-12-25-weekly.md
└─ lx-template.md
```

## Output

**No documents to archive:**
```
Archiving LX documents older than 2024-09-26...

No documents to archive (cutoff: 2024-09-26)
```

**Documents archived:**
```
Archiving LX documents older than 2024-09-01...

Archived: 2024-08-05-weekly.md → archive/2024/08/
Archived: 2024-08-12-weekly.md → archive/2024/08/
Archived: 2024-08-19-weekly.md → archive/2024/08/
Archived: 2024-08-26-weekly.md → archive/2024/08/

Archived 4 document(s)
Location: /path/to/repo/process/lx/archive/
```

## When to Archive

### Monthly Cleanup
```bash
# At the start of each month, archive last month's docs
lxi archive lx $(date -v-1m +%Y-%m-01)
```

### Quarterly Review
```bash
# Archive everything older than 90 days
lxi archive lx $(date -v-90d +%Y-%m-%d)
```

### Year-end Cleanup
```bash
# Archive all documents from previous year
lxi archive lx $(date +%Y-01-01)
```

## Benefits

1. **Clean working directory**: Keep only recent, relevant documents visible
2. **Historical record**: Archived docs available for reference
3. **Performance**: Faster searches and validations with fewer files
4. **Organization**: Year/month structure easy to navigate

## Finding Archived Documents

```bash
# List all archived documents
find process/lx/archive -name "*.md"

# Find specific month
ls process/lx/archive/2024/08/

# Search archived content
grep -r "TEAM-100" process/lx/archive/
```

## Integration

### Automated Monthly Archive
```bash
# Cron job (1st of each month at 9am)
0 9 1 * * cd /path/to/repo && lxi archive lx $(date -v-60d +%Y-%m-%d)
```

### CI/CD Scheduled Job
```yaml
# .gitlab-ci.yml
archive-old-docs:
  script:
    - lxi archive lx $(date -v-60d +%Y-%m-%d)
    - git add process/lx/archive/
    - git commit -m "Archive old LX documents"
    - git push
  only:
    - schedules  # Run monthly
```

## Related

- Skill: `agents/skills/archive-weekly.sh`
- Check for stale docs: `lxi check freshness`
- LX template: `process/lx/lx-template.md`

---

## See Also

- [lxi check](lxi-check.md) - Check document freshness
- [lxi update](lxi-update.md) - Update LX documents
- [Architecture](../ARCHITECTURE.md#lx-documents-living-experience) - LX document structure
