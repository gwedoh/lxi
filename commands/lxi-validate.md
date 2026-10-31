# lxi validate

Validate repository documentation integrity.

## Usage

```bash
lxi validate
```

## What it does

Checks all cross-references in markdown files for validity.

**Validation checks:**
1. Finds all markdown files in the repository
2. Extracts all internal links: `[text](path)`
3. Resolves relative paths
4. Checks if each link target exists
5. Reports broken links with file location

**What it skips:**
- External URLs (`https://...`)
- Anchor-only links (`#section`)
- Files in `node_modules/` or `.git/`

## Output

**Success:**
```
✅ All cross-references are valid
```

**Failures:**
```
❌ Broken link in principles/adrs/0001-database.md
   Link: [Design Review](../design-reviews/2024-10-15-auth.md)
   Target: /path/to/repo/principles/design-reviews/2024-10-15-auth.md

❌ Broken link in process/lx/2024-10-21-weekly.md
   Link: [Epic TEAM-100](../../product/epics/team-100.md)
   Target: /path/to/repo/product/epics/team-100.md

Found 2 broken link(s)
```

## Examples

```bash
# Validate all links
lxi validate

# Run as part of CI/CD
lxi validate || exit 1
```

## Exit Codes

- `0`: All links are valid
- `1`: One or more broken links found

## Use Cases

### Before Committing
```bash
# Validate before pushing
lxi validate
git commit -am "Update documentation"
git push
```

### In CI/CD Pipeline
```yaml
# .gitlab-ci.yml
validate-docs:
  script:
    - lxi validate
  only:
    - merge_requests
```

### After Refactoring
```bash
# After renaming/moving files
git mv old-path.md new-path.md
lxi validate  # Check for broken links
# Fix any broken links
git commit -am "Refactor documentation structure"
```

## Related

- Skill: `agents/skills/validate-references.sh`
- Best Practice: Run `lxi validate` before committing documentation changes

---

## See Also

- [lxi check](lxi-check.md) - Check document freshness
- [Architecture](../ARCHITECTURE.md#documentation-artifacts) - Documentation structure
