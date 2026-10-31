# lxi standup

Generate daily standup updates from Git commits and Jira.

## Usage

```bash
lxi standup <command> [options]
```

## Commands

### lxi standup generate

Auto-generate daily standup from Git commit history.

**Usage:**
```bash
lxi standup generate [YYYY-MM-DD]
```

**Arguments:**
- `YYYY-MM-DD` (optional): The date for the standup. Defaults to today.

**Examples:**
```bash
lxi standup generate              # Generate for today
lxi standup generate 2024-10-26   # Generate for specific date
```

**What it does:**
1. Queries Git for commits from yesterday by each team member
2. Generates "Yesterday" section from commit messages
3. Creates placeholder for "Today" section (can be filled from Jira)
4. Identifies team members from Git commit history
5. Creates standup document in `product/progress/`

**Output:**
- Creates: `product/progress/YYYY-MM-DD-standup.md`
- Format:
  ```markdown
  # Daily Standup - YYYY-MM-DD

  ## Team Updates

  ### [Team Member Name]

  **Yesterday:**
  - [Commit messages from yesterday]

  **Today:**
  - _[Update with planned work]_

  **Blockers:**
  - None
  ```

**Integration:**
- Git commits → Yesterday section (automatic)
- Jira stories "In Progress" → Today section (future integration)
- Jira blocked stories → Blockers section (future integration)

**Related:**
- Skill: `agents/skills/standup-update.sh`
- Weekly rollup: `lxi update lx`

---

## See Also

- [lxi update](lxi-update.md) - Update LX documents
- [Architecture](../ARCHITECTURE.md#progress-tracking) - Progress tracking overview
