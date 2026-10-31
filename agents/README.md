# LXI AI Agent System

This directory contains configurations, rules, and skills for AI agents operating within the LXI framework.

---

## Core Principles for AI Agents

### 1. Work from Files, Not Memories

**Rule**: Always read the current state of files before making updates or providing answers.

**Why**: The repository is the source of truth. Files change frequently. Never assume you know the current state.

**Examples**:
```
❌ BAD: "Based on what I remember, the architecture uses PostgreSQL"
✅ GOOD: [Reads principles/adrs/0001-database-choice.md] "According to ADR-0001, the architecture uses PostgreSQL for..."
```

---

### 2. Analysis Grows Stale with Time

**Rule**: All analysis and decision documents MUST include dates. Flag documents older than 30 days as potentially stale.

**Date Requirements**:
- ADRs: Include `Date: YYYY-MM-DD` in header
- Design Reviews: Filename includes date `YYYY-MM-DD-title.md`
- LX Documents: Filename IS the date `YYYY-MM-DD-weekly.md`
- Context Analysis: Filename includes date `YYYY-MM-DD-topic.md`

**Freshness Checks**:
```
IF document_age > 30 days:
    FLAG as "potentially stale"
    SUGGEST "Consider refreshing this analysis"
```

---

### 3. Takeaways Cascade Upward

**Rule**: Insights and lessons learned from specific work (projects, incidents, implementations) should be extracted and promoted to reusable context.

**Cascade Flow**:
```
Specific Implementation
      ↓
context/projects/2024-q4-migration/lessons.md
      ↓
[Extract patterns, best practices]
      ↓
context/docs/migration-best-practices.md
```

**When to Cascade**:
- After completing a project
- When a pattern repeats 2-3 times
- When lessons apply broadly across team

---

### 4. Repository Updates External Systems

**Rule**: The repository is the source of truth. External systems (Jira, Confluence) are UPDATED by the repository, not the other way around.

**Sync Direction**:
```
Repository → Jira  ✅
Repository → Confluence  ✅
Jira → Repository  ❌ (Only for initial import or reference)
Confluence → Repository  ❌
```

---

## AI Agent Capabilities

### Reading Operations

**What AI agents MUST be able to do**:
1. Read all markdown files in the repository
2. Parse YAML frontmatter in documents
3. Extract cross-references and links
4. Validate link integrity
5. Check document freshness
6. Identify traffic light statuses (🟢🟡🔴)

### Writing Operations

**What AI agents SHOULD be able to do**:
1. Create new documents from templates
2. Update existing documents (LX docs, standups)
3. Add cross-references
4. Update status indicators
5. Append to change logs
6. Archive old documents

### External Integration Operations

**What AI agents COULD do** (with proper authentication):
1. Query Jira for epic/story status
2. Update Jira epic notes
3. Push LX documents to Confluence
4. Pull Git commit history for standup generation
5. Send notifications (Slack, Teams)

---

## Agent Skills

Agents should have reusable "skills" for common operations.

### Skill: `create-adr`

**Purpose**: Interactively create a new ADR from template

**Inputs**:
- Decision title
- Context and problem statement
- Options considered
- Recommended decision

**Process**:
1. Find next ADR number: `ls principles/adrs/ | grep -E '^[0-9]{4}' | sort | tail -1`
2. Increment number (e.g., 0015 → 0016)
3. Copy template: `principles/adrs/adr-template.md` → `principles/adrs/0016-decision-title.md`
4. Fill in template with provided inputs
5. Set status to "Proposed"
6. Set date to today

**Output**: New ADR file created and ready for review

---

### Skill: `create-design-review`

**Purpose**: Create a new Design Review from template

**Inputs**:
- Feature/initiative name
- Problem statement
- 2-3 solution options

**Process**:
1. Determine date: today's date YYYY-MM-DD
2. Copy template: `principles/design-reviews/design-review-template.md` → `principles/design-reviews/YYYY-MM-DD-title.md`
3. Fill in template sections
4. Link to related Jira stories
5. Set status to "Draft"

**Output**: New Design Review file ready for stakeholder review

---

### Skill: `update-lx`

**Purpose**: Generate or update weekly LX document

**Inputs**:
- Week date (e.g., 2024-10-28)
- Epic statuses
- Accomplishments
- Blockers

**Process**:
1. Check if `process/lx/YYYY-MM-DD-weekly.md` exists
2. If NO: Copy from template
3. If YES: Update existing
4. Populate epic status sections
5. Update metrics from Jira (if integrated)
6. Add accomplishments from daily standups
7. Flag blockers needing escalation

**Output**: Updated LX document ready for review/publishing

---

### Skill: `standup-update`

**Purpose**: Auto-generate daily standup from Git commits, Jira updates

**Inputs**:
- Team member names
- Date (default: today)

**Process**:
1. Pull Git commits from yesterday for each team member
2. Query Jira for story status changes
3. Generate "Yesterday" section from commits
4. Generate "Today" section from Jira stories in "In Progress"
5. Flag any stories marked as blocked

**Output**: Daily standup document

---

### Skill: `sync-jira`

**Purpose**: Sync repository state to Jira

**Inputs**:
- Epic ID
- Status (Green/Yellow/Red)
- Progress notes

**Process**:
1. Read LX document for epic
2. Extract status, progress %, notes
3. Update Jira epic via API:
   - Progress %
   - Notes in epic comments
   - Labels for traffic light status
4. Update story statuses from daily standup

**Output**: Jira updated, sync timestamp recorded

---

### Skill: `sync-confluence`

**Purpose**: Push LX document to Confluence

**Inputs**:
- LX document path
- Confluence space and page ID

**Process**:
1. Read LX markdown document
2. Convert markdown to Confluence storage format
3. Update Confluence page via API
4. Maintain bidirectional links (repo ↔ Confluence)

**Output**: Confluence page updated, link back to repo maintained

---

### Skill: `validate-references`

**Purpose**: Check all cross-references for validity

**Inputs**: None (scans entire repository)

**Process**:
1. Find all markdown files
2. Extract all internal links `[text](path)`
3. Check each link target exists
4. Report broken links
5. Optionally suggest fixes for renamed files

**Output**: Report of broken links and suggestions

---

### Skill: `check-freshness`

**Purpose**: Identify stale analysis and documents

**Inputs**: Staleness threshold (default: 30 days)

**Process**:
1. Scan all documents with dates
2. Calculate age: `current_date - document_date`
3. If age > threshold: flag as stale
4. Generate report with recommendations

**Output**: List of stale documents needing refresh or archiving

---

### Skill: `archive-weekly`

**Purpose**: Archive old LX documents

**Inputs**: Cutoff date (default: 30 days ago)

**Process**:
1. Find all LX documents in `process/lx/` older than cutoff
2. Create archive directory structure: `process/lx/archive/YYYY/MM/`
3. Move old documents to archive
4. Update links to archived documents
5. Update LX template's "Previous Week" link

**Output**: Old documents archived, links updated

---

## Agent Perspectives

AI agents can adopt different perspectives when reviewing or creating content.

### Engineer Perspective

**Focus**:
- Technical accuracy
- Implementation feasibility
- Code quality and maintainability
- Testing and observability

**Questions to Ask**:
- Does this design follow our architecture principles?
- Is this testable?
- How will we monitor this in production?
- What are the edge cases?

**Document Review**:
- ADRs: Check technical consequences, risks
- Design Reviews: Validate solution approaches, estimate effort
- Code: Ensure it follows documented decisions

---

### Product Manager Perspective

**Focus**:
- Business value
- User impact
- Roadmap alignment
- Timeline and scope

**Questions to Ask**:
- Does this solve the user problem?
- What is the ROI?
- How does this fit the roadmap?
- What is the MVP?

**Document Review**:
- ADRs: Ensure business context is clear
- Design Reviews: Validate problem statement, scope
- LX Documents: Check alignment with product goals

---

### QA Perspective

**Focus**:
- Test coverage
- Quality gates
- Edge cases and failure modes
- User acceptance criteria

**Questions to Ask**:
- How will we test this?
- What could go wrong?
- What are the acceptance criteria?
- How do we verify success?

**Document Review**:
- Design Reviews: Ensure success metrics, testing strategy
- ADRs: Check for quality/testing implications
- Code: Validate test coverage

---

### User Perspective

**Focus**:
- Usability
- Value delivered
- Pain points addressed
- Experience quality

**Questions to Ask**:
- Is this intuitive?
- Does this solve my problem?
- How will I know it works?
- What if something goes wrong?

**Document Review**:
- Design Reviews: User value, UX considerations
- ADRs: User impact of architectural decisions

---

## Agent Commands

AI agents respond to specific commands within documents or prompts.

### Command: `@lxi create adr [topic]`

**Action**: Create new ADR for given topic using `create-adr` skill

**Example**:
```
@lxi create adr database selection
```

**Result**: New ADR file created, user guided through filling it out

---

### Command: `@lxi create design-review [feature]`

**Action**: Create new Design Review for feature

**Example**:
```
@lxi create design-review user authentication
```

---

### Command: `@lxi update lx [week]`

**Action**: Update or create LX document for specified week

**Example**:
```
@lxi update lx 2024-10-28
```

---

### Command: `@lxi standup generate`

**Action**: Auto-generate today's standup from Git and Jira

**Example**:
```
@lxi standup generate
```

---

### Command: `@lxi sync [target]`

**Action**: Sync repository to external system

**Examples**:
```
@lxi sync jira
@lxi sync confluence
@lxi sync all
```

---

### Command: `@lxi validate`

**Action**: Validate cross-references and document integrity

**Example**:
```
@lxi validate
```

---

### Command: `@lxi check freshness`

**Action**: Check for stale documents

**Example**:
```
@lxi check freshness
```

---

### Command: `@lxi archive lx [before-date]`

**Action**: Archive old LX documents

**Example**:
```
@lxi archive lx 2024-09-01
```

---

## Update Context Command

Special command placed at the end of context files to remind agents to update after changes.

**Usage in documents**:
```markdown
---

## 🤖 AI Agent Note

When work related to this topic is completed:
1. Extract lessons learned
2. Update this document with insights
3. Add date of update
4. If patterns emerge, cascade to context/docs/

@lxi update_context
```

**Agent Behavior**:
When agent sees `@lxi update_context` in a document it has modified:
1. Check if any insights should be added
2. Update the document's date
3. Consider if takeaways should cascade upward

---

## Error Handling

### When Links Break

**Detection**: During `validate-references`

**Action**:
1. Report broken link
2. Search for file that might have been renamed
3. Suggest correction
4. If auto-fix enabled: Update link

### When Documents are Stale

**Detection**: During `check-freshness`

**Action**:
1. Flag document as stale
2. Notify owner (from document metadata)
3. Suggest: Refresh or Archive
4. Add to next L10 Opportunity Items if critical

### When Sync Fails

**Detection**: During `sync-jira` or `sync-confluence`

**Action**:
1. Log error with details
2. Retry with exponential backoff (3 attempts)
3. If still failing: Create issue in `improvements/`
4. Notify team via Slack/Teams
5. Repository remains source of truth (do not block local work)

---

## Agent Configuration

### profiles/

Contains AI agent voice and behavior settings.

**Example: `profiles/technical-writer.yml`**:
```yaml
name: Technical Writer
description: Focused on clear, concise documentation
voice:
  tone: Professional, clear
  style: Direct, concise
  level: Accessible to all stakeholders
behaviors:
  - Prefer simple language over jargon
  - Use bullet points for clarity
  - Include examples
  - Link to related docs
```

### perspectives/

Contains perspective-specific rules.

**Example: `perspectives/engineer.yml`**:
```yaml
name: Engineer
focus:
  - Technical accuracy
  - Implementation feasibility
  - Testability
  - Maintainability
review_checklist:
  adrs:
    - Technical consequences documented
    - Risks identified with mitigation
    - Implementation effort estimated
  design_reviews:
    - Solutions are technically sound
    - Edge cases considered
    - Testing strategy defined
```

### skills/

Contains reusable skill scripts or definitions.

**Example: `skills/create-adr.sh`**:
```bash
#!/bin/bash
# Skill: create-adr
# Creates a new ADR from template

# Implementation would go here
```

---

## Best Practices for AI Agents

### DO:
✅ Always read files before updating
✅ Include dates in all analysis
✅ Validate links after creating cross-references
✅ Flag stale content
✅ Cascade learnings upward
✅ Keep external systems in sync
✅ Ask for clarification when ambiguous

### DON'T:
❌ Assume file contents without reading
❌ Create documents without dates
❌ Leave broken links
❌ Let analysis go stale without flagging
❌ Duplicate content across documents (link instead)
❌ Make Jira/Confluence the source of truth
❌ Guess when information is unclear

---

## Metrics for Agent Effectiveness

Track these metrics to evaluate AI agent performance:

| Metric | Target | How to Measure |
|--------|--------|----------------|
| **Document Freshness** | 100% of docs < 30 days old | `lxi check-freshness` |
| **Link Validity** | 100% valid links | `lxi validate-references` |
| **Sync Success Rate** | > 95% | Sync logs |
| **Standup Auto-Generation** | 90% auto, 10% manual edits | Compare generated vs. final |
| **LX Doc Update Time** | < 15 minutes/week | Time tracking |
| **Cross-Reference Coverage** | 100% of ADRs/Designs linked | Manual review |

---

_This AI agent system supports the LXI framework. See [ARCHITECTURE.md](../ARCHITECTURE.md) for system overview._
