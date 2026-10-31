# LXI Integration & Cross-References

This document defines how all LXI components integrate and reference each other to maintain a cohesive, repository-centric workflow.

---

## Document Relationships

### Hierarchy & Flow

```
BUSINESS NEED
      ↓
┌─────────────┐
│    ADR      │ ← Architectural decision needed?
│ (If needed) │
└──────┬──────┘
       ↓
┌─────────────────┐
│ Design Review   │ ← Technical implementation planning
│   (Required)    │
└──────┬──────────┘
       ↓
┌─────────────────┐         ┌──────────────┐
│  Jira Epic      │────────▶│ LX Document  │
│  & Stories      │         │  (Weekly)    │
└──────┬──────────┘         └──────┬───────┘
       ↓                            ↑
┌─────────────────┐         ┌──────┴───────┐
│  Daily Work     │────────▶│   Standup    │
│  (Code/PRs)     │         │   (Daily)    │
└─────────────────┘         └──────────────┘
       │                            │
       └────────── Rolls up to ─────┘
```

---

## Cross-Reference Rules

### 1. ADR References

**ADRs must reference**:
- **Related Design Reviews**: Link to the design review that explored implementation options
- **Jira Epics**: The business work this decision supports
- **LX Document**: The week this decision was made (for historical context)
- **Other ADRs**: Decisions this supersedes or builds upon

**ADRs are referenced by**:
- **Design Reviews**: When design review requires architectural decision
- **Code**: In comments when implementing the decision
- **Other ADRs**: When building on or superseding previous decisions
- **LX Documents**: When decision impacts timeline or roadmap

**Example ADR Reference Section**:
```markdown
**Related**:
- Jira Epic: [TEAM-123](https://jira.../TEAM-123)
- Design Reviews: [API Gateway Design](../design-reviews/2024-10-api-gateway.md)
- LX Document: [2024-10-28](../../process/lx/2024-10-28-weekly.md)
- Supersedes: [ADR-0005](./0005-monolithic-api.md)
```

---

### 2. Design Review References

**Design Reviews must reference**:
- **Product Requirements**: Link to product gathering document or user story
- **Jira Stories**: Specific stories this design addresses
- **ADRs**: If architectural decision is required (before or after design review)
- **LX Document**: The week this design is being worked on

**Design Reviews are referenced by**:
- **ADRs**: When architectural decision is made based on design review
- **Code**: In pull/merge request descriptions
- **Jira Stories**: Linked from story description
- **LX Documents**: When design impacts timeline

**Example Design Review Reference Section**:
```markdown
**Related**:
- ADR: [ADR-0012](../adrs/0012-event-driven-architecture.md)
- Jira Link(s): [TEAM-456](https://jira.../TEAM-456), [TEAM-457](https://jira.../TEAM-457)
- LX Document: [2024-10-28](../../process/lx/2024-10-28-weekly.md)
- Product Gathering: [Link to Confluence doc]
```

---

### 3. LX Document References

**LX Documents must reference**:
- **Jira Epics**: All active epics for the team/product
- **ADRs**: Decisions made this week
- **Design Reviews**: Designs completed or in progress
- **Previous/Next LX Docs**: For historical tracking
- **Confluence**: Where this syncs externally

**LX Documents are referenced by**:
- **ADRs**: To provide timeline context
- **Design Reviews**: To show impact on roadmap
- **Daily Standups**: Where daily work rolls up
- **Other Repositories**: For multi-repo coordination

**Example LX Document Reference Section**:
```markdown
**Distribution**:
- Confluence: [Link to synced Confluence page]
- Jira Epics: [TEAM-123](https://jira.../TEAM-123), [TEAM-456](https://jira.../TEAM-456)
- Previous Week: [2024-10-21](./2024-10-21-weekly.md)
- Next Week: [2024-11-04](./2024-11-04-weekly.md)

**Related Documentation**:
- [ADR-0015: Microservice Decomposition](../../principles/adrs/0015-microservice-decomposition.md)
- [Design Review: User Authentication](../../principles/design-reviews/2024-10-auth-redesign.md)
```

---

### 4. Standup/Progress References

**Standups must reference**:
- **Jira Stories**: Stories being worked on
- **LX Document**: The weekly doc this rolls up to
- **Pull/Merge Requests**: Code changes made

**Standups are referenced by**:
- **LX Documents**: Weekly rollup of accomplishments
- **Retrospectives**: To understand daily patterns

**Example Standup Reference Section**:
```markdown
**Jira Sync**:
- Stories in Progress: [TEAM-789](https://jira.../TEAM-789), [TEAM-790](https://jira.../TEAM-790)

**Rolls Up To**:
- LX Document: [2024-10-28](../../process/lx/2024-10-28-weekly.md)
```

---

## Integration with External Systems

### Jira Integration

```
Repository                          Jira
─────────────────────────────────────────────────────────────
ADR ──────────────────────────────▶ Epic (Impact noted)
                                     │
Design Review ─────────────────────▶ Stories (Linked)
                                     │
Daily Standup ─────────────────────▶ Story Status Updates
                                     │
LX Document (Weekly) ──────────────▶ Epic Progress & Notes
                                     │
                                     ▼
                          Jira is UPDATED by Repo
                          (Repo is source of truth)
```

**Sync Rules**:
1. **Daily**: Standup updates push to Jira story status
2. **Weekly**: LX Document updates epic progress, notes, and blockers
3. **On Decision**: ADRs update epic description with architectural context
4. **On Design Completion**: Design Review linked in story description

**Jira Fields Updated by LXI**:
- Epic Progress %
- Epic Notes (from LX Document summary)
- Story Status (from Daily Standup)
- Story Comments (from blockers, progress notes)
- Epic/Story Labels (Red/Yellow/Green status)

---

### Confluence Integration

```
Repository                      Confluence
─────────────────────────────────────────────────────────────
LX Document (Weekly) ──────────▶ Team/Product Page
                                 (Weekly update section)
                                      │
ADR ───────────────────────────▶ Architecture Decisions Page
                                      │
Design Review ─────────────────▶ Design Reviews Space
                                      │
                                      ▼
                        Confluence is SYNCED from Repo
                        (Repo is source of truth)
```

**Sync Rules**:
1. **Weekly**: LX Documents push to team/product Confluence page
2. **On Acceptance**: ADRs push to architecture decisions Confluence space
3. **On Approval**: Design Reviews push to design reviews Confluence space
4. **Archive**: Historical LX Documents create archive pages in Confluence

**Confluence Sync Strategy**:
- Use Confluence API to create/update pages
- Markdown converted to Confluence storage format
- Bidirectional links maintained (repo ↔ Confluence)
- Confluence pages link back to repository source

---

### Git Integration

```
Repository                      Git History
─────────────────────────────────────────────────────────────
Daily Work ────────────────────▶ Commits
                                      │
Pull/Merge Requests ───────────▶ References ADRs & Design Reviews
                                 in description
                                      │
Daily Standup ─────────────────▶ Generated from commit history
                                      │
                                      ▼
                            Git informs Progress Tracking
```

**Commit Message Convention**:
```
[TEAM-123] Brief description of change

Longer explanation of what changed and why.

References:
- ADR-0015: Event-driven architecture
- Design Review: API Gateway (2024-10-15)

Co-authored-by: [Names]
```

**Pull/Merge Request Description Template**:
```markdown
## Summary
<!-- What does this PR/MR do? -->

## References
- Jira: [TEAM-123](link)
- Design Review: [Link](../../principles/design-reviews/...)
- ADR: [ADR-0015](../../principles/adrs/0015-event-driven.md)

## Testing
<!-- How was this tested? -->

## Checklist
- [ ] Code reviewed
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] ADR/Design Review implemented as specified
```

---

## Multi-Repository Linking

When multiple repositories owned by the same team use LXI:

### Shared LX Document Pattern

**Repository A** and **Repository B** both reference the same weekly LX document:

```
Repository A                    Repository B
├─ process/lx/                  ├─ process/lx/
│  └─ 2024-10-28-weekly.md      │  └─ 2024-10-28-weekly.md
│     │                         │     │
│     └─ References Epic        │     └─ References Same Epic
│        TEAM-123               │        TEAM-123
│                               │
└─ Links to Confluence ◀────────┴─────────────┐
   Weekly LX Page                              │
                                                │
                                    ┌───────────▼────────────┐
                                    │ Shared LX Document     │
                                    │ (Confluence)           │
                                    │                        │
                                    │ Epic: TEAM-123         │
                                    │ Repo A Progress: ...   │
                                    │ Repo B Progress: ...   │
                                    │ Combined Status: 🟡    │
                                    └────────────────────────┘
```

**Pattern**:
1. Each repository maintains its own `process/lx/YYYY-MM-DD-weekly.md`
2. Both reference the same Jira Epic(s)
3. Both sync to the same Confluence LX page (different sections)
4. Confluence page aggregates status across both repos

### Cross-Repo ADR References

When Repo A makes an architectural decision affecting Repo B:

**Repository A**: `principles/adrs/0020-shared-event-schema.md`
```markdown
**Affected Repositories**:
- [Repository B](https://github.com/org/repo-b): Must implement event consumer

**Cross-Repo Coordination**:
- Repo B ADR: [0012-event-consumption](https://github.com/org/repo-b/blob/main/principles/adrs/0012-event-consumption.md)
- Shared LX: [2024-10-28](link to Confluence page)
```

**Repository B**: `principles/adrs/0012-event-consumption.md`
```markdown
**Dependencies**:
- Repository A ADR: [0020-shared-event-schema](https://github.com/org/repo-a/blob/main/principles/adrs/0020-shared-event-schema.md)
```

---

## Naming Conventions

### File Naming

**ADRs**:
```
NNNN-short-kebab-case-title.md

Examples:
- 0001-use-postgresql-for-primary-db.md
- 0015-event-driven-microservices.md
```

**Design Reviews**:
```
YYYY-MM-DD-short-kebab-case-title.md

Examples:
- 2024-10-15-api-gateway-design.md
- 2024-10-28-user-authentication-redesign.md
```

**LX Documents**:
```
YYYY-MM-DD-weekly.md

Examples:
- 2024-10-28-weekly.md
- 2024-11-04-weekly.md
```

**Standups**:
```
YYYY-MM-DD-standup.md

Examples:
- 2024-10-28-standup.md
- 2024-10-29-standup.md
```

### Link Conventions

**Internal Repository Links**:
```markdown
[Link Text](../../path/to/document.md)
```

**External Jira Links**:
```markdown
[TEAM-123](https://jira.company.com/browse/TEAM-123)
```

**Confluence Links**:
```markdown
[Page Title](https://confluence.company.com/display/SPACE/Page+Title)
```

**Cross-Repository Links**:
```markdown
[Repo Name ADR-0015](https://github.com/org/repo-name/blob/main/principles/adrs/0015-topic.md)
```

---

## Status & State Management

### Traffic Light System

All work items use a consistent traffic light system:

| Status | Meaning | When to Use | Escalation |
|--------|---------|-------------|------------|
| 🟢 **Green** | On track | No issues, progressing as planned | No escalation needed |
| 🟡 **Yellow** | At risk | Potential blocker, needs attention | Discuss in current level (L5/L10/L20) |
| 🔴 **Red** | Blocked | Cannot proceed, critical issue | Escalate to next level up |

**Escalation Flow**:
```
🔴 Red at L5  → Escalate to L10
🔴 Red at L10 → Escalate to L20
🔴 Red at L20 → Executive decision required
```

### Document Status

**ADR Status Values**:
- `Proposed`: Draft, under discussion
- `Accepted`: Approved and being implemented
- `Deprecated`: No longer recommended, kept for historical reference
- `Superseded`: Replaced by newer ADR (link to replacement)

**Design Review Status Values**:
- `Draft`: Initial document, not yet reviewed
- `In Review`: Shared with stakeholders, feedback being gathered
- `Approved`: Decision made, ready for implementation
- `Approved with Conditions`: Approved but with specific modifications
- `Needs Rework`: Issues identified, needs revision

**LX Document Status**:
- `Draft`: Being prepared for the week
- `Published`: Shared with team/stakeholders
- `Archived`: Historical document, moved to archive/

---

## Automation & AI Agent Hooks

### Automated Cross-Reference Validation

LXI AI agents can validate cross-references:

**Validation Rules**:
1. All ADRs must link to at least one Jira Epic or Design Review
2. All Design Reviews must link to at least one Jira Story
3. All LX Documents must reference at least one Epic
4. Links must be valid (not 404)
5. Dates in documents match filename dates

**Command**: `lxi validate-references`

### Automated Sync

**Daily Sync** (automated via CI/CD or cron):
```bash
lxi sync daily
  ├─ Pull latest from Jira
  ├─ Generate standup from Git commits
  ├─ Update story statuses in Jira
  └─ Flag stale analysis (>30 days)
```

**Weekly Sync** (automated every Monday):
```bash
lxi sync weekly
  ├─ Generate LX document draft
  ├─ Push to Confluence
  ├─ Update Epic progress in Jira
  ├─ Archive previous week's LX doc
  └─ Send summary to Slack/Teams
```

**On-Demand Sync**:
```bash
lxi sync now          # Sync everything immediately
lxi sync jira         # Sync only Jira
lxi sync confluence   # Sync only Confluence
```

---

## Best Practices

### 1. Always Link, Never Duplicate

✅ **Do**: Link to the source document
```markdown
See [ADR-0015](../../principles/adrs/0015-event-driven.md) for architecture decision.
```

❌ **Don't**: Copy content from another document
```markdown
We decided to use event-driven architecture because... [duplicated reasoning]
```

### 2. Bidirectional Links

When Document A references Document B, ensure Document B back-references Document A:

**ADR-0015** references **Design Review (2024-10-api-gateway)**:
```markdown
# ADR-0015
...
**Related**:
- Design Reviews: [API Gateway](../design-reviews/2024-10-api-gateway.md)
```

**Design Review** back-references **ADR-0015**:
```markdown
# Design Review: API Gateway
...
**Related**:
- ADR: [ADR-0015](../adrs/0015-event-driven.md)
```

### 3. Date Everything

All analysis and decisions must include dates:
- Filenames include dates (Design Reviews, LX Docs, Standups)
- ADRs have `Date:` field in header
- Status changes logged with dates in Change Log

### 4. Keep Links Relative

Use relative links within the repository:
```markdown
✅ [ADR-0015](../../principles/adrs/0015-event-driven.md)
❌ [ADR-0015](https://github.com/org/repo/blob/main/principles/adrs/0015-event-driven.md)
```

Absolute links only for external resources (Jira, Confluence, other repos).

### 5. Update README on Major Changes

When significant decisions or changes occur, update the top-level README.md to reflect current state. The README is the entry point for all stakeholders.

---

## Troubleshooting Integration Issues

### Broken Links

**Problem**: Links returning 404 or pointing to wrong documents

**Solution**:
```bash
lxi validate-references --fix
```

This will:
- Scan all documents for links
- Check if targets exist
- Suggest corrections for broken links
- Optionally auto-fix simple cases (renamed files)

### Sync Conflicts

**Problem**: Confluence or Jira out of sync with repository

**Solution**:
1. Repository is always source of truth
2. Force push from repository:
   ```bash
   lxi sync --force
   ```
3. Review sync logs to identify conflict source

### Stale Analysis

**Problem**: Documents older than 30 days not refreshed

**Solution**:
```bash
lxi check-freshness
```

This will:
- List all documents older than 30 days
- Flag documents needing update
- Suggest archiving or refreshing

---

_This integration guide follows the LXI framework. See [ARCHITECTURE.md](./ARCHITECTURE.md) for system overview._
