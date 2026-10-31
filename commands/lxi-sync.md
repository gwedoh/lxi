# lxi sync

Synchronize repository state to external systems (Jira, Confluence).

## Usage

```bash
lxi sync <target>
```

## Commands

### lxi sync jira

Sync repository state to Jira (epics, stories, status).

**Usage:**
```bash
lxi sync jira
```

**Prerequisites:**
- Jira configuration file: `.lxi/jira.yml`
  ```yaml
  url: https://your-domain.atlassian.net
  email: your-email@example.com
  api_token: your-api-token
  ```

**What it does:**
1. Reads latest LX document from `process/lx/`
2. Extracts epic statuses, progress percentages
3. Updates Jira via API:
   - Epic progress percentage
   - Status labels (green/yellow/red)
   - Notes in epic comments
4. Updates story statuses from progress tracking
5. Records sync timestamp

**Direction:**
```
Repository → Jira  ✅
Jira → Repository  ❌
```

**Related:**
- Skill: `agents/skills/sync-jira.sh`
- Configuration: `.lxi/jira.yml`

---

### lxi sync confluence

Push LX document to Confluence.

**Usage:**
```bash
lxi sync confluence [lx-file]
```

**Arguments:**
- `lx-file` (optional): Path to specific LX document. Defaults to latest weekly document.

**Prerequisites:**
- Confluence configuration file: `.lxi/confluence.yml`
  ```yaml
  url: https://your-domain.atlassian.net/wiki
  email: your-email@example.com
  api_token: your-api-token
  space: SPACE_KEY
  parent_page_id: 123456
  ```

**What it does:**
1. Reads LX markdown document
2. Converts markdown to Confluence storage format
3. Creates or updates Confluence page via API
4. Maintains bidirectional link (repo ↔ Confluence)

**Direction:**
```
Repository → Confluence  ✅
Confluence → Repository  ❌
```

**Related:**
- Skill: `agents/skills/sync-confluence.sh`
- Configuration: `.lxi/confluence.yml`

---

### lxi sync all

Sync to all configured external systems.

**Usage:**
```bash
lxi sync all
```

**What it does:**
1. Runs `lxi sync jira`
2. Runs `lxi sync confluence`
3. Reports sync status for each system

---

## Configuration

### Setting up Jira Sync

1. Create directory:
   ```bash
   mkdir -p .lxi
   ```

2. Create `.lxi/jira.yml`:
   ```yaml
   url: https://your-domain.atlassian.net
   email: your-email@example.com
   api_token: your-api-token
   ```

3. Get API token:
   - Visit: https://id.atlassian.com/manage-profile/security/api-tokens
   - Create token
   - Add to `.lxi/jira.yml`

4. Add `.lxi/` to `.gitignore` (contains credentials)

### Setting up Confluence Sync

1. Create `.lxi/confluence.yml`:
   ```yaml
   url: https://your-domain.atlassian.net/wiki
   email: your-email@example.com
   api_token: your-api-token
   space: TEAM
   parent_page_id: 123456789
   ```

2. Find parent page ID:
   - Navigate to parent page in Confluence
   - Page ID is in URL: `.../pages/123456789/...`

---

## Sync Philosophy

The repository is the **source of truth**. External systems are **updated by** the repository, never the reverse.

```
┌─────────────┐
│ Repository  │ (Source of Truth)
│   (LXI)     │
└──────┬──────┘
       │
       ├──────────────┐
       ▼              ▼
   ┌──────┐      ┌────────────┐
   │ Jira │      │ Confluence │
   └──────┘      └────────────┘
```

**Why?**
- Single source of truth prevents conflicts
- Code and docs stay in sync
- Engineers work in familiar environment (Git)
- External systems for visibility, not authoring

---

## See Also

- [lxi update](lxi-update.md) - Update LX documents
- [Architecture](../ARCHITECTURE.md#information-flow) - Information flow overview
- [AI Agents](../agents/README.md#agent-skills) - Sync skills
