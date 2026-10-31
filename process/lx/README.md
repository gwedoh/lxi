# LX Weekly Documents

This directory contains weekly LX (Living Experience) documents that serve as the primary status update and coordination mechanism.

---

## What is an LX Document?

An **LX (Living Experience) Document** is a weekly progress report that captures:

- **Epic Status**: Current state of all active initiatives (🟢🟡🔴)
- **Last Week**: Accomplishments and completed work
- **This Week**: Planned work and priorities
- **Open Decisions**: Questions needing input from product/business/leadership
- **Blockers**: Issues requiring escalation or external help

LX documents are the **single source of truth** for team status and feed into:
- L10/L20 meetings
- Confluence (synced weekly)
- Jira epic updates
- Stakeholder communications

---

## Naming Convention

LX documents use **Monday-dated naming**:

```
2024-10-28-weekly.md  (week of Oct 28 - Nov 1)
2024-11-04-weekly.md  (week of Nov 4 - Nov 8)
2024-11-11-weekly.md  (week of Nov 11 - Nov 15)
```

**Why Monday?**
- Consistent anchor for each week
- Easy to find "week of [date]"
- Aligns with L10/L20 meeting schedule

---

## Creating Weekly LX Documents

### Auto-Generate

```bash
lxi update lx
```

This creates (or updates) the LX document for the current week.

### Specific Week

```bash
lxi update lx 2024-10-28
```

Creates LX document for the week of October 28.

---

## LX Document Structure

```markdown
# Weekly LX - Week of YYYY-MM-DD

## Epic Status

### TEAM-100: User Analytics Feature
**Status**: 🟢 Green
**Progress**: 85%
**Owner**: Engineering Team
**Target**: 2024-11-15

**This Week**:
- Complete dashboard UI
- Load testing

**Risks**: None

---

### TEAM-101: API v2 Migration
**Status**: 🟡 Yellow
**Progress**: 60%
**Owner**: Backend Team
**Target**: 2024-12-15

**This Week**:
- Endpoint implementation
- Client migration planning

**Risks**: Dependent on Database upgrade completion

---

## Last Week

**Accomplishments**:
- ✅ User Analytics SDK integration completed (TEAM-100)
- ✅ Database upgrade deployed to production (TEAM-103)
- ✅ API v2 schema design finalized (TEAM-101)
- 🔄 Dashboard UI in progress (TEAM-100)

**Metrics**:
- 12 story points completed
- 8 PRs merged
- 2 features deployed to production

---

## This Week

**Priorities**:
1. Complete User Analytics dashboard (TEAM-100)
2. Begin API v2 endpoint implementation (TEAM-101)
3. Mobile app design review (TEAM-102)

**Team Capacity**:
- Full team available
- No planned PTO

---

## Open Decisions

### Decision 1: Mobile app platform choice
**Context**: Need to decide iOS-first vs cross-platform
**Options**: Native (Swift/Kotlin) vs React Native vs Flutter
**Needed From**: Product team
**Urgency**: High - blocks TEAM-102 start
**Status**: Awaiting PM input

---

## Blockers

### Blocker 1: API Gateway Configuration
**Epic**: TEAM-101
**Issue**: Need production API gateway access
**Blocked Since**: 2024-10-25
**Owner**: Platform team
**Status**: 🔴 Escalated to L10

---

## Meeting Notes

**L10 (2024-10-28)**:
- Discussed API v2 timeline
- Escalated API gateway blocker
- Agreed to defer mobile app start by 1 week

---

## Links

- [Previous Week](2024-10-21-weekly.md)
- Confluence: [Link after sync]
- Jira Filter: [Team epics]
```

---

## Traffic Light System

All epics use traffic light status:

| Status | Meaning | When to Use |
|--------|---------|-------------|
| 🟢 **Green** | On track | No issues, progressing as planned |
| 🟡 **Yellow** | At risk | Potential issues, needs attention |
| 🔴 **Red** | Blocked | Critical issue, requires escalation |

### When to Use Yellow 🟡

- Timeline at risk (may miss deadline)
- Dependency delay
- Team capacity reduced (PTO, attrition)
- Technical challenges discovered
- Scope creep concerns

### When to Use Red 🔴

- Completely blocked (cannot proceed)
- Will definitely miss deadline without intervention
- Critical dependency not delivered
- Major technical blocker discovered
- Need executive decision to proceed

### Escalation

- 🟡 Yellow → Discuss in L10 meeting
- 🔴 Red → Escalate to L10 (or L20 if product-wide impact)

---

## Weekly Workflow

### Monday

1. **Generate LX document**:
   ```bash
   lxi update lx
   ```

2. **Fill in "Last Week"**:
   - Review daily standups from previous week
   - Aggregate accomplishments
   - Calculate metrics (story points, PRs, deploys)

3. **Update Epic Status**:
   - Review each epic's progress
   - Update traffic light (🟢🟡🔴)
   - Update progress percentage

4. **Plan "This Week"**:
   - List priorities
   - Note team capacity (PTO, etc.)

5. **Document Open Decisions**:
   - Questions for product team
   - Technical decisions needing input
   - Prioritization needs

6. **Flag Blockers**:
   - Anything preventing progress
   - Include context and ownership

7. **Review in L10 Meeting**:
   - Present status
   - Discuss Yellow/Red items
   - Get decisions on Open Decisions
   - Update blockers

### Tuesday - Friday

- Update epic status as needed
- Add new blockers if they arise
- Update Open Decisions when answered

### Friday

1. **Finalize LX Document**:
   - Ensure all sections up to date
   - Review for accuracy

2. **Sync to External Systems**:
   ```bash
   lxi sync all
   ```
   - Pushes to Confluence
   - Updates Jira epic notes
   - Creates weekly snapshot

3. **Preview Next Week**:
   - Identify upcoming priorities
   - Flag potential issues early

---

## Integration with Other Documents

### Daily Standups → LX Document

Daily standups (`product/progress/`) feed into "Last Week":

```
Daily standups (Oct 21-25) → LX Doc "Last Week" section
```

### LX Document → Confluence

```bash
lxi sync confluence
```

Pushes LX document to Confluence page for visibility.

### LX Document → Jira

```bash
lxi sync jira
```

Updates Jira epic descriptions with:
- Current status (🟢🟡🔴)
- Progress percentage
- Link to LX document

---

## Epic Progress Tracking

### Calculating Progress

Progress can be based on:

1. **Story Points**: Completed / Total planned
   - Example: 17 / 20 points = 85%

2. **Story Count**: Stories done / Total stories
   - Example: 8 / 10 stories = 80%

3. **Milestone-based**: Phases completed
   - Design (25%) → Dev (50%) → Test (75%) → Deploy (100%)

4. **Time-based**: Weeks elapsed / Total weeks
   - Example: 3 / 4 weeks = 75%

**Best practice**: Use story points for accuracy.

### Updating Progress

Update progress in Jira, then sync:

```bash
lxi sync jira
```

Or update manually in LX document.

---

## Open Decisions

Use this section to **escalate questions** that need product/business/leadership input.

**Good Open Decision**:
```markdown
### Decision: Mobile Platform Choice

**Context**: TEAM-102 (Mobile App) starting soon
**Question**: iOS-first or cross-platform (React Native)?
**Options**:
  1. iOS-first (Swift) - faster to market, native UX
  2. React Native - code reuse, slower initial dev

**Needed From**: Product team (timeline priority)
**Urgency**: High - blocks epic start
**Status**: Awaiting PM input by 2024-11-01
```

**Bad Open Decision**:
```markdown
### Decision: Should we write tests?

**Status**: Thinking about it
```

---

## Blockers Section

**Good Blocker**:
```markdown
### API Gateway Access

**Epic**: TEAM-101 (API v2)
**Issue**: Need production API gateway credentials
**Impact**: Cannot deploy endpoints to prod
**Blocked Since**: 2024-10-25
**Owner**: Platform team (John Doe)
**Action**: Escalated to L10, need by 2024-11-05
**Status**: 🔴 Red
```

**Bad Blocker**:
```markdown
### Need to write code

**Status**: Blocked
```

**Tips**:
- Be specific about the issue
- Identify who owns the blocker
- Include timeline (when blocked, when needed by)
- Escalate if not resolved within a few days

---

## Archiving

### When to Archive

Archive LX documents older than **30 days**:

```bash
lxi archive lx
```

This moves old documents to:
```
process/lx/archive/YYYY/MM/YYYY-MM-DD-weekly.md
```

### Archive Structure

```
process/lx/
├─ 2024-10-28-weekly.md  (current)
├─ 2024-11-04-weekly.md  (current)
├─ archive/
│  ├─ 2024/
│  │  ├─ 09/
│  │  │  ├─ 2024-09-02-weekly.md
│  │  │  ├─ 2024-09-09-weekly.md
│  │  │  └─ ...
│  │  └─ 10/
│  │     ├─ 2024-10-07-weekly.md
│  │     └─ 2024-10-14-weekly.md
```

---

## Multi-Repository Linking

When multiple microservices use LXI, they can share weekly LX documents.

**Example**:

**Repo A** (`user-service`):
```markdown
# Weekly LX - Week of 2024-10-28

## Epic Status

### TEAM-100: User Analytics
**Service**: User Service
**Status**: 🟢 Green
[...]
```

**Repo B** (`analytics-service`):
```markdown
# Weekly LX - Week of 2024-10-28

## Epic Status

### TEAM-100: User Analytics
**Service**: Analytics Service
**Status**: 🟢 Green
[...]

**Cross-repo dependency**: Waiting on User Service API (see user-service LX)
```

**Shared Confluence Page**:
Both repos sync to same Confluence page, creating unified view.

---

## Tools & Commands

### Create/Update LX Document

```bash
lxi update lx              # Current week
lxi update lx 2024-10-28   # Specific week
```

### Sync to External Systems

```bash
lxi sync confluence        # Push to Confluence
lxi sync jira             # Update Jira epics
lxi sync all              # Sync everything
```

### Archive Old Documents

```bash
lxi archive lx                # Archive >30 days
lxi archive lx 2024-09-01     # Archive before date
```

### Validate Links

```bash
lxi validate
```

---

## Best Practices

### DO ✅

- **Update weekly**: Monday for planning, Friday for finalization
- **Be honest about status**: Yellow/Red when needed
- **Be specific**: "85% complete" not "almost done"
- **Link everything**: Jira epics, ADRs, Design Reviews
- **Update blockers**: Add resolution when unblocked
- **Sync regularly**: Keep Confluence/Jira up to date

### DON'T ❌

- **Don't let documents go stale**: Update weekly
- **Don't hide issues**: Yellow/Red early is better than surprise
- **Don't be vague**: "Working on it" doesn't help stakeholders
- **Don't forget to close decisions**: Update when answered
- **Don't skip the sync**: Stakeholders need visibility

---

## Metrics & Success

Track LX document effectiveness:

| Metric | Target | How to Measure |
|--------|--------|----------------|
| **Update frequency** | Weekly | Last modified date |
| **Sync success** | >95% | Confluence/Jira sync logs |
| **Staleness** | <7 days old | Check freshness command |
| **Blocker resolution** | <5 days avg | Track blocked date to resolved date |
| **Decision closure** | <7 days avg | Track open to answered |

---

## Common Questions

**Q: Who updates the LX document?**
A: Engineering Manager or Tech Lead, with input from the team.

**Q: How long should it take to update?**
A: 15-30 minutes on Monday, 10-15 on Friday.

**Q: Do we need LX docs if we have Jira?**
A: Yes. LX docs provide context, narrative, and decisions that Jira doesn't capture. They also sync **to** Jira, not from it.

**Q: What if we have multiple teams?**
A: Each team can have their own LX document, or a shared one with sections per team.

**Q: Should we update daily?**
A: No. Daily standups are for daily updates. LX is weekly summary/planning.

**Q: What if an epic is Green all week?**
A: Still include it with brief status. "On track" is valuable signal to stakeholders.

---

## Related Documentation

- [process/README.md](../README.md) - Workflows and procedures
- [product/progress/](../../product/progress/) - Daily standups
- [commands/lxi-update.md](../../commands/lxi-update.md) - Update command reference
- [commands/lxi-sync.md](../../commands/lxi-sync.md) - Sync command reference

---

_This directory follows the LXI framework. See [ARCHITECTURE.md](../../ARCHITECTURE.md) for system overview._
