# LXI Commands

Command-line interface for the LX In-Sync (LXI) framework.

**LXI** = **LX In-Sync**, where LX is derived from the L10 meeting model, In-Sync means engineering and business stay automatically synchronized, and I completes "In-Sync" - the system that keeps multiple levels (L5, L10, L20) aligned.

---

## Overview

LXI provides a set of commands to manage repository-centric workflow documentation. All user-facing commands are prefixed with `lxi` to maintain consistency.

**Core Philosophy:**
- Work from files, not memories
- Repository is the source of truth
- External systems are updated by the repository
- Analysis grows stale and must be dated

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `lxi create adr [topic]` | Create new Architecture Decision Record |
| `lxi create design-review [feature]` | Create new Design Review document |
| `lxi update lx [week]` | Update weekly LX document |
| `lxi standup generate [date]` | Generate daily standup from Git commits |
| `lxi sync jira` | Sync repository to Jira |
| `lxi sync confluence` | Push LX document to Confluence |
| `lxi sync all` | Sync to all external systems |
| `lxi validate` | Validate cross-references |
| `lxi check freshness [days]` | Check for stale documents |
| `lxi archive lx [date]` | Archive old LX documents |

---

## Commands by Category

### 📝 Document Creation

#### [lxi create](lxi-create.md)
Create new documentation artifacts from templates.

**Usage:**
```bash
lxi create adr [topic]              # Create ADR
lxi create design-review [feature]  # Create Design Review
```

**Examples:**
```bash
lxi create adr "Event Streaming Architecture"
lxi create design-review "User Authentication"
```

---

### 🔄 Document Updates

#### [lxi update](lxi-update.md)
Update or generate documentation from repository state.

**Usage:**
```bash
lxi update lx [YYYY-MM-DD]  # Update weekly LX document
```

**Examples:**
```bash
lxi update lx              # Current week
lxi update lx 2024-10-28   # Specific week
```

---

### 👥 Standup Generation

#### [lxi standup](lxi-standup.md)
Generate daily standup updates from Git commits.

**Usage:**
```bash
lxi standup generate [YYYY-MM-DD]
```

**Examples:**
```bash
lxi standup generate              # Today
lxi standup generate 2024-10-26   # Specific date
```

---

### 🔗 External System Sync

#### [lxi sync](lxi-sync.md)
Synchronize repository state to external systems (Jira, Confluence).

**Usage:**
```bash
lxi sync jira         # Sync to Jira
lxi sync confluence   # Sync to Confluence
lxi sync all          # Sync to all systems
```

**Prerequisites:**
- Configuration files in `.lxi/`:
  - `jira.yml`
  - `confluence.yml`

---

### ✅ Validation & Quality

#### [lxi validate](lxi-validate.md)
Validate repository documentation integrity.

**Usage:**
```bash
lxi validate
```

**What it checks:**
- All markdown cross-references
- Internal link validity
- Reports broken links

---

#### [lxi check](lxi-check.md)
Check document freshness and staleness.

**Usage:**
```bash
lxi check freshness [threshold-days]
```

**Examples:**
```bash
lxi check freshness       # 30-day threshold (default)
lxi check freshness 60    # 60-day threshold
```

---

### 🗄️ Archiving

#### [lxi archive](lxi-archive.md)
Archive old documents to maintain repository cleanliness.

**Usage:**
```bash
lxi archive lx [YYYY-MM-DD]
```

**Examples:**
```bash
lxi archive lx                # Archive docs older than 30 days
lxi archive lx 2024-09-01     # Archive before specific date
```

---

## Installation & Setup

### Prerequisites

- Git repository
- Bash shell (macOS, Linux, WSL on Windows)
- Optional: Jira/Confluence API access for sync commands

### Setup

1. **Clone or initialize LXI structure:**
   ```bash
   # Your repository should have this structure:
   principles/
   ├─ adrs/
   └─ design-reviews/
   process/
   └─ lx/
   product/
   └─ progress/
   agents/
   └─ skills/
   ```

2. **Add LXI to PATH** (optional):
   ```bash
   # Add to ~/.bashrc or ~/.zshrc
   export PATH="$PATH:/path/to/lxi/agents/skills"

   # Create symlink (alternative)
   ln -s /path/to/lxi/agents/skills/create-adr.sh /usr/local/bin/lxi-create-adr
   ```

3. **Configure external integrations** (optional):
   ```bash
   mkdir -p .lxi

   # Create .lxi/jira.yml
   # Create .lxi/confluence.yml

   # Add to .gitignore
   echo ".lxi/" >> .gitignore
   ```

---

## Common Workflows

### Starting a New Initiative

```bash
# 1. Create ADR for architectural decision
lxi create adr "Microservices Architecture"

# 2. Create Design Review for implementation
lxi create design-review "User Service API"

# 3. Fill in documents, link them together

# 4. Validate links
lxi validate
```

### Weekly Status Update

```bash
# 1. Update LX document
lxi update lx

# 2. Fill in epic statuses, accomplishments, blockers

# 3. Sync to external systems
lxi sync all

# 4. Archive old documents (monthly)
lxi archive lx
```

### Daily Standup

```bash
# Generate from Git commits
lxi standup generate

# Review and update with today's plan

# Commit to repository
git add product/progress/
git commit -m "Daily standup $(date +%Y-%m-%d)"
```

### Periodic Maintenance

```bash
# Check for stale documents
lxi check freshness

# Validate all cross-references
lxi validate

# Archive old LX documents
lxi archive lx $(date -v-60d +%Y-%m-%d)
```

---

## Command Implementation

All commands are implemented as bash skills in `agents/skills/`:

| Command | Skill Script |
|---------|--------------|
| `lxi create adr` | `agents/skills/create-adr.sh` |
| `lxi create design-review` | `agents/skills/create-design-review.sh` |
| `lxi update lx` | `agents/skills/update-lx.sh` |
| `lxi standup generate` | `agents/skills/standup-update.sh` |
| `lxi sync jira` | `agents/skills/sync-jira.sh` |
| `lxi sync confluence` | `agents/skills/sync-confluence.sh` |
| `lxi validate` | `agents/skills/validate-references.sh` |
| `lxi check freshness` | `agents/skills/check-freshness.sh` |
| `lxi archive lx` | `agents/skills/archive-weekly.sh` |

---

## AI Agent Integration

Commands can also be invoked via AI agent directives:

```markdown
@lxi create adr "Database Selection"
@lxi update lx 2024-10-28
@lxi standup generate
@lxi sync all
@lxi validate
@lxi check freshness
@lxi archive lx 2024-09-01
```

See [AI Agents README](../agents/README.md) for details.

---

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success |
| `1` | Error or validation failure |

**Example:**
```bash
lxi validate || echo "Fix broken links before committing"
```

---

## Troubleshooting

### Command not found
```bash
# Ensure skills are executable
chmod +x agents/skills/*.sh

# Or call directly
bash agents/skills/create-adr.sh "My Topic"
```

### Sync failures
```bash
# Check configuration
cat .lxi/jira.yml
cat .lxi/confluence.yml

# Test API access
curl -u "email:api_token" https://your-domain.atlassian.net/rest/api/2/myself
```

### Date parsing errors
```bash
# macOS uses different date format
date -v-30d +%Y-%m-%d   # macOS

# Linux uses:
date -d "30 days ago" +%Y-%m-%d  # Linux
```

---

## Contributing

### Adding New Commands

1. **Create skill script:**
   ```bash
   # agents/skills/new-command.sh
   #!/bin/bash
   set -e
   # Implementation...
   ```

2. **Make executable:**
   ```bash
   chmod +x agents/skills/new-command.sh
   ```

3. **Create documentation:**
   ```bash
   # commands/lxi-new-command.md
   # Include usage, examples, related info
   ```

4. **Update this README:**
   - Add to Quick Reference table
   - Add to appropriate category
   - Update Command Implementation table

---

## See Also

- [Architecture](../ARCHITECTURE.md) - System overview
- [AI Agents](../agents/README.md) - Agent capabilities and skills
- [Setup Guide](../SETUP.md) - Detailed setup instructions
- [Examples](../EXAMPLE.md) - Real-world usage examples

---

_Commands implement the LXI framework's core principle: **Work from files, not memories**._
