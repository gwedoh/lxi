# Daily Progress Tracking

This directory contains daily standup updates and progress tracking for the team.

---

## Overview

The `progress/` directory captures **daily work** performed by the team, serving as:

- Individual standup updates (Yesterday/Today/Blockers)
- Progress history for weekly rollup into LX documents
- Reference for what was accomplished each day
- Input for automated standup generation

---

## Daily Standup Format

Each day's standup is captured in a file: `YYYY-MM-DD-standup.md`

**Structure**:
```markdown
# Daily Standup - YYYY-MM-DD

## Team Updates

### [Team Member Name]

**Yesterday:**
- Completed task A
- Made progress on task B

**Today:**
- Continue task B
- Start task C

**Blockers:**
- None

---

### [Another Team Member]

**Yesterday:**
- Reviewed PR for feature X

**Today:**
- Implement feature Y

**Blockers:**
- Waiting on API access from Platform team
```

---

## Creating Daily Standups

### Auto-Generate from Git

The easiest way to create a standup is to auto-generate from Git commits:

```bash
lxi standup generate
```

This creates `YYYY-MM-DD-standup.md` with:
- **Yesterday** section populated from Git commits
- **Today** section as placeholder (fill manually or from Jira)
- **Blockers** section initialized to "None"

### Manual Creation

Copy from template:

```bash
cp product/progress/standup-template.md product/progress/$(date +%Y-%m-%d)-standup.md
```

Fill in manually during standup meeting.

---

## Standup Workflow

### Daily Cycle

1. **Morning** (before standup):
   ```bash
   lxi standup generate
   ```
   Generates draft with yesterday's commits.

2. **During Standup**:
   - Each team member reviews their section
   - Updates "Today" with planned work
   - Flags any blockers

3. **After Standup**:
   - Commit the standup file
   ```bash
   git add product/progress/
   git commit -m "Daily standup $(date +%Y-%m-%d)"
   git push
   ```

4. **End of Week**:
   - Daily standups roll up into LX document
   - Use for "Last Week" accomplishments section

---

## What to Include

### Yesterday

**Good examples**:
```markdown
**Yesterday:**
- Completed user authentication feature (TEAM-123)
- Reviewed 2 PRs (TEAM-125, TEAM-127)
- Fixed bug in payment flow (TEAM-130)
- Attended design review for notification system
```

**What to avoid**:
```markdown
**Yesterday:**
- Worked on stuff
- Meetings
- Coding
```

**Tips**:
- Reference Jira tickets
- Be specific about what was completed
- Mention PR reviews, meetings if significant

---

### Today

**Good examples**:
```markdown
**Today:**
- Continue implementing notification backend (TEAM-140)
- Pair with Jane on database migration
- Write unit tests for authentication module
- Deploy authentication feature to staging
```

**What to avoid**:
```markdown
**Today:**
- More coding
- Working on the same thing
```

**Tips**:
- Be concrete about tasks
- Reference specific work items
- Indicate if continuing from yesterday

---

### Blockers

**Good examples**:
```markdown
**Blockers:**
- Waiting on API key from Platform team (requested 2024-10-25)
- Need design mockups for settings page from UX team
- Database migration blocked - staging environment down
```

**Non-blockers**:
```markdown
**Blockers:**
- Need to write tests (this is work, not a blocker)
- Need to finish feature (also not a blocker)
```

**Tips**:
- Blocker = something you can't control that prevents progress
- Include context (when requested, who is responsible)
- If no blockers, write "None"

---

## Auto-Generation from Git

The `lxi standup generate` command:

1. Queries Git for commits from yesterday
2. Groups by commit author
3. Populates "Yesterday" section with commit messages
4. Creates template for "Today" and "Blockers"

**Example output**:
```markdown
# Daily Standup - 2024-10-26

## Team Updates

### John Doe

**Yesterday:**
- Add user authentication endpoint (TEAM-123)
- Fix bug in login validation (TEAM-125)
- Update API documentation

**Today:**
- _[Update with planned work]_

**Blockers:**
- None
```

**Limitations**:
- Only captures work that was committed
- Commit messages should be descriptive
- Meetings, reviews, non-code work must be added manually

---

## Integration with Jira

_(Future enhancement)_

Integrate with Jira to auto-populate "Today" section:

```bash
lxi standup generate --with-jira
```

Would pull stories marked "In Progress" for each team member.

---

## Weekly Rollup

At the end of the week, standup updates feed into the LX document:

```bash
lxi update lx
```

This aggregates daily standups into:
- **Last Week** section (accomplishments)
- **Blockers** section (ongoing issues)

**Example**:

From daily standups:
```
2024-10-21: John completed TEAM-123
2024-10-22: John reviewed TEAM-125, TEAM-127
2024-10-23: John fixed TEAM-130
2024-10-24: Jane completed TEAM-140
2024-10-25: Jane deployed TEAM-140 to staging
```

Becomes LX entry:
```markdown
## Last Week

**Engineering Team**:
- ✅ User authentication feature completed (TEAM-123)
- ✅ Notification system implemented and deployed to staging (TEAM-140)
- ✅ Payment flow bug fixed (TEAM-130)
- 🔄 Code reviews completed: TEAM-125, TEAM-127
```

---

## Metrics & Insights

Daily standups provide data for:

### Velocity Tracking
- Story points completed per week
- Commit frequency by team member
- Feature delivery cadence

### Blocker Analysis
- How long blockers persist
- Which types of blockers most common
- Cross-team dependencies

### Retrospective Input
- What went well (completed items)
- What didn't go well (blockers, challenges)
- Patterns over time

---

## Best Practices

### DO ✅

- **Be specific**: "Completed TEAM-123" not "Worked on auth"
- **Reference tickets**: Include Jira IDs for traceability
- **Update daily**: Don't batch multiple days
- **Flag blockers early**: Don't wait until they're critical
- **Keep it concise**: Bullet points, not paragraphs

### DON'T ❌

- **Don't skip days**: Breaks historical record
- **Don't be vague**: "Worked on stuff" helps no one
- **Don't over-detail**: High-level bullets, not every line of code
- **Don't duplicate**: If it's in a ticket, just reference the ticket

---

## Archiving

### Monthly Archive

At the end of each month, archive old standups:

```bash
mkdir -p product/progress/archive/2024/10
mv product/progress/2024-10-*.md product/progress/archive/2024/10/
```

### Keep Recent

Keep last 30 days in main directory for easy access.

---

## Templates

### Standup Template

Located at: `product/progress/standup-template.md`

Use as starting point for new standups.

---

## Tools & Commands

### Generate Today's Standup

```bash
lxi standup generate
```

### Generate Specific Date

```bash
lxi standup generate 2024-10-25
```

### List All Standups

```bash
ls -la product/progress/2024-*.md
```

### Search Standups

```bash
grep -r "TEAM-123" product/progress/
```

### Weekly Rollup

```bash
lxi update lx
```

---

## Common Questions

**Q: Do we need a standup file if we have a standup meeting?**
A: Yes. The file creates a historical record and feeds into LX documents. It takes 2 minutes to generate and update.

**Q: What if I didn't commit anything yesterday?**
A: Manually add what you worked on (meetings, reviews, planning, learning, etc.). Not all work results in commits.

**Q: Should we update standups asynchronously?**
A: Yes! Async standups work well. Each person updates their section when convenient, then everyone reads before the (optional) sync meeting.

**Q: How detailed should "Yesterday" be?**
A: High-level bullets. "Implemented user auth" not "Added import statement, created class, wrote method..."

**Q: What counts as a blocker?**
A: Something outside your control that prevents progress. Waiting on another team, missing access/credentials, broken environment, unclear requirements.

---

## Related Documentation

- [process/README.md](../../process/README.md) - Workflows
- [process/lx/](../../process/lx/) - Weekly LX documents
- [commands/lxi-standup.md](../../commands/lxi-standup.md) - Standup command reference

---

_This directory follows the LXI framework. See [ARCHITECTURE.md](../../ARCHITECTURE.md) for system overview._
