# LXI Process & Workflows

This document defines the end-to-end workflows for using LXI in your repository.

---

## Table of Contents

1. [Work Lifecycle](#work-lifecycle)
2. [Decision Trees](#decision-trees)
3. [Workflows by Role](#workflows-by-role)
4. [Common Scenarios](#common-scenarios)
5. [Meeting Cadences](#meeting-cadences)
6. [Escalation Procedures](#escalation-procedures)

---

## Work Lifecycle

### Overview

```
┌────────────────────────────────────────────────────────────┐
│ 1. IDEATION & PLANNING                                     │
│    Business need identified                                │
│    ├─ Product requirements gathered                        │
│    ├─ ADR needed? (architecture impact)                    │
│    └─ Design Review created                                │
└────────────────┬───────────────────────────────────────────┘
                 ↓
┌────────────────────────────────────────────────────────────┐
│ 2. DECISION & DESIGN                                       │
│    ├─ Design Review meeting held                           │
│    ├─ Solution selected                                    │
│    ├─ ADR created (if architectural)                       │
│    └─ Epic/Stories created in Jira                         │
└────────────────┬───────────────────────────────────────────┘
                 ↓
┌────────────────────────────────────────────────────────────┐
│ 3. IMPLEMENTATION                                          │
│    ├─ Work begins (tracked in Daily Standup)               │
│    ├─ Code written, PRs/MRs created                        │
│    ├─ Status tracked: 🟢 🟡 🔴                             │
│    └─ Blockers escalated as needed                         │
└────────────────┬───────────────────────────────────────────┘
                 ↓
┌────────────────────────────────────────────────────────────┐
│ 4. TRACKING & SYNC                                         │
│    ├─ Daily: Standup updates → Jira sync                   │
│    ├─ Weekly: LX Document → Confluence sync                │
│    └─ Progress visible to all stakeholders                 │
└────────────────┬───────────────────────────────────────────┘
                 ↓
┌────────────────────────────────────────────────────────────┐
│ 5. COMPLETION & LEARNING                                   │
│    ├─ Work merged and deployed                             │
│    ├─ Success metrics evaluated                            │
│    ├─ Lessons learned captured in context/analysis         │
│    └─ Takeaways cascade up to context/docs                 │
└────────────────────────────────────────────────────────────┘
```

---

## Decision Trees

### Do I need an ADR?

```
Start: Proposed change or decision
    │
    ↓
Is this an ARCHITECTURAL decision?
(Affects system structure, technology choice,
 cross-cutting concerns, or multiple services)
    │
    ├─ YES ────────────────────────────────────┐
    │                                           ↓
    ↓                                   Create ADR
Is the impact LOW?                      (Use template in
(Small scope, easily reversible,         principles/adrs/)
 no cross-team effects)                          │
    │                                            │
    ├─ YES ─────────────────────────────────────┤
    │                                            │
    ↓                                            ↓
Document in Design Review only          Link ADR to Design Review
(Reference in code comments)             and continue to Design Review
```

### Do I need a Design Review?

```
Start: Feature or change to implement
    │
    ↓
Is this SIGNIFICANT work?
(More than 1 day, affects multiple files,
 has multiple possible approaches)
    │
    ├─ YES ────────────────────────────────────┐
    │                                           ↓
    ↓                                   Create Design Review
Is this TRIVIAL?                        (Use template in
(Bugfix, small refactor, obvious path)   principles/design-reviews/)
    │                                            │
    ├─ YES ─────────────────────────────────────┤
    │                                            │
    ↓                                            ↓
Document in PR/MR description only       Hold Design Review meeting
Update LX Document if noteworthy         Make decision, link to ADR if needed
                                         Update Jira, LX Document
```

### What meeting level do I escalate to?

```
Start: Blocker or decision needed
    │
    ↓
Can MY TEAM resolve this?
(Within team's authority and capability)
    │
    ├─ YES ────────────────────────────────────┐
    │                                           ↓
    ↓                                   Discuss in L5 Meeting
Does it affect MULTIPLE TEAMS in              Mark 🟢 when resolved
same product?                                  Continue work
    │
    ├─ YES ────────────────────────────────────┐
    │                                           ↓
    ↓                                   Escalate to L10 Meeting
Does it affect MULTIPLE PRODUCTS or            Mark 🔴 in L5
strategic direction?                           Add to L10 Remedial Items
    │
    ├─ YES ────────────────────────────────────┐
    │                                           ↓
    ↓                                   Escalate to L20 Meeting
This shouldn't happen often!                   Mark 🔴 in L10
Likely needs executive decision                Add to L20 Strategic Decisions
```

---

## Workflows by Role

### Product Manager

**Weekly Cycle**:

1. **Monday Morning**:
   - Review previous week's LX Document
   - Identify any Open Decisions that need answers
   - Prepare for L10/L20 meetings

2. **Throughout Week**:
   - Answer Open Decisions in LX Document
   - Prioritize new work in backlog
   - Monitor epic progress (Green/Yellow/Red status)

3. **Friday Afternoon**:
   - Review draft of next week's LX Document
   - Ensure product goals are reflected
   - Flag any concerns for Monday's meetings

**Key Documents**:
- **Reads**: LX Documents (weekly), Design Reviews (as needed)
- **Writes**: Product requirements, Open Decision responses
- **Updates**: Jira epic descriptions and priorities

---

### Engineering Manager

**Daily Cycle**:

1. **Morning**:
   - Review yesterday's standup notes
   - Check for 🔴 blockers
   - Facilitate team standup (if applicable)

2. **Throughout Day**:
   - Clear blockers for team
   - Make decisions on escalated items
   - Review PRs/MRs if needed

**Weekly Cycle**:

1. **Start of Week**:
   - L10 Meeting (Monday/Tuesday)
   - Review team capacity and assignments
   - Update LX Document with team status

2. **End of Week**:
   - Review week's accomplishments
   - Prepare LX Document for next week
   - Identify risks for coming week

**Key Documents**:
- **Reads**: Daily Standups, LX Documents, ADRs (major decisions)
- **Writes**: LX Documents (team section), ADRs (decisions), Design Review approvals
- **Updates**: Team status, blocker resolution, meeting notes

---

### Engineer / Tech Lead

**Daily Cycle**:

1. **Morning**:
   - Update yesterday's work in standup
   - Plan today's work
   - Flag any blockers

2. **Throughout Day**:
   - Implement features per Design Reviews
   - Reference ADRs in code
   - Create PRs/MRs with proper references

3. **End of Day**:
   - Commit work with proper references
   - Update story status in Jira

**When Starting New Work**:

1. Check if Design Review exists
   - If NO → Create Design Review
   - If YES → Review and follow design

2. Check if ADR needed
   - If YES → Create ADR or reference existing
   - If NO → Proceed with implementation

3. Link everything:
   - PR/MR → Design Review, ADR, Jira Story
   - Code comments → ADR decisions
   - Commit messages → Jira story

**Key Documents**:
- **Reads**: Design Reviews (for implementation), ADRs (for decisions), LX Documents (for context)
- **Writes**: Design Reviews (technical details), ADRs (if architectural decisions), Standup updates
- **Updates**: Code, PRs/MRs, Jira story status

---

### Scrum Master

**Daily**:
- Facilitate standup
- Update LX Document with blockers
- Help escalate issues

**Weekly**:
- Collect retrospective items for L10
- Roll up team metrics for LX Document
- Archive previous week's docs

**Sprint Cycle**:
- Sprint planning: Reference LX roadmap
- Sprint review: Update LX with demo notes
- Retrospective: Capture items in context/analysis

**Key Documents**:
- **Reads**: Daily Standups, LX Documents
- **Writes**: Retrospective notes, Process improvements
- **Updates**: Sprint metrics, Team health indicators

---

## Common Scenarios

### Scenario 1: New Feature Request

**Steps**:

1. **Product Manager** creates product requirements
   - Document business value, user impact
   - Create Jira Epic

2. **Engineering Lead** assesses:
   - Is ADR needed? → Create if yes
   - Create Design Review document
   - Identify 2-3 solution options

3. **Design Review Meeting** (PM + EM + Engineers):
   - Review solutions
   - Make decision
   - Estimate effort

4. **Epic Planning**:
   - Break into stories in Jira
   - Link to Design Review
   - Add to LX Document

5. **Implementation**:
   - Engineers work on stories
   - Daily standup updates
   - Weekly LX updates

6. **Completion**:
   - Measure success metrics
   - Capture lessons learned
   - Update context

**Documents Created**:
- Design Review ✅
- ADR ⚠️ (if needed)
- Jira Epic & Stories ✅
- LX Document updates ✅
- Daily Standup entries ✅

---

### Scenario 2: Critical Bug Found

**Steps**:

1. **Engineer** finds bug:
   - Create Jira story (type: Bug)
   - Mark as 🔴 Red if blocking

2. **Standup**:
   - Report bug and status
   - Estimate fix effort

3. **If blocking release**:
   - Escalate in L5 meeting
   - EM prioritizes immediately
   - Update LX Document (blocker section)

4. **Fix**:
   - Implement fix
   - Reference bug in commit/PR
   - Add regression test

5. **Post-Fix**:
   - Document root cause in context/analysis
   - Update LX Document (resolved)
   - Share lessons learned

**Documents Updated**:
- Daily Standup ✅
- LX Document (Blockers section) ✅
- Context/Analysis (root cause) ✅
- Jira Bug Story ✅

---

### Scenario 3: Architectural Decision Needed

**Steps**:

1. **Recognition**:
   - Team identifies architectural decision needed
   - Examples: Database choice, framework change, microservice split

2. **Prepare ADR**:
   - Use ADR template
   - Document context, constraints, options
   - Identify stakeholders

3. **Design Review** (if implementation details needed):
   - Explore technical approaches
   - Link to ADR

4. **Decision Meeting**:
   - Present ADR to stakeholders
   - Discuss trade-offs
   - Make decision

5. **Update ADR**:
   - Mark as "Accepted"
   - Document decision and rationale
   - Link to Jira Epic for implementation

6. **Communicate**:
   - Add to LX Document
   - Update README if major change
   - Share in L10/L20 if impacts multiple teams

**Documents Created**:
- ADR ✅
- Design Review ⚠️ (if implementation details needed)
- LX Document update ✅
- README update ⚠️ (if major)

---

### Scenario 4: Multi-Team Dependency

**Steps**:

1. **Identification**:
   - Team A needs feature from Team B
   - Captured in Design Review or L5 meeting

2. **Escalate to L10**:
   - Both teams in same L10
   - Discuss in "Remedial Items" section
   - Create action plan

3. **Coordinate via LX Document**:
   - Both teams reference same Epic
   - Track status in both teams' LX docs
   - Share weekly updates

4. **Track Dependency**:
   - Team A: "Waiting on Team B for [deliverable]"
   - Team B: "Blocking Team A - Priority: High"

5. **Resolution**:
   - Team B delivers
   - Team A unblocked
   - Both update LX documents

**Documents Used**:
- Both teams' LX Documents ✅
- Shared Jira Epic ✅
- L10 Meeting Notes ✅
- Design Reviews (if coordination needed) ✅

---

## Meeting Cadences

### L5 (Team Level)

**Frequency**: Daily or Weekly (varies by initiative)
**Duration**: Varies (typically 15-30 min)
**Participants**: Engineering Leads, Product Owners, Engineers

**Agenda**:
1. **Team Initiatives** (5 min)
   - Review current work (Green/Yellow/Red)
   - Upcoming priorities

2. **Remedial Items** (15-20 min)
   - Discuss 🟡 Yellow and 🔴 Red items
   - Create action plans
   - Assign owners

3. **Meeting Feedback** (2 min)
   - Blind rating 1-10
   - Quick improvement suggestions

**Artifacts**:
- Action items added to Jira
- Blockers escalated to L10 if needed
- Status updated in LX Document

---

### L10 (Product Level)

**Frequency**: Weekly
**Duration**: 90 minutes
**Participants**: EM, PM, Scrum Masters, Product Owners, Engineering Leads, Staff Engineers

**Agenda**:
1. **Opportunity Items** (10 min)
   - Retrospective items from L5 teams
   - Process improvement suggestions

2. **Team Initiatives** (30 min)
   - Each team reports status (Green/Yellow/Red)
   - Discuss 🟡 Yellow and 🔴 Red items only

3. **Remedial Items** (40 min)
   - 🔴 Red items from Team Initiatives
   - Cross-team dependencies
   - Create action plans with owners

4. **Meeting Feedback** (10 min)
   - Blind rating 1-10
   - Improvement collection

**Artifacts**:
- LX Document updated with L10 decisions
- Action plans tracked
- 🔴 Red items escalated to L20 if unresolved

---

### L20 (Portfolio Level)

**Frequency**: Weekly
**Duration**: 105 minutes
**Participants**: Engineering Director, Product Director, Principal Engineer, Senior Architect, EMs, PMs, Staff Engineers

**Agenda**:
1. **Important Upcoming** (10 min)
   - Deadlines, future dates, events

2. **Product Initiatives** (40 min)
   - Status from each L10
   - 🟡 Yellow and 🔴 Red items only
   - Portfolio-level view

3. **Remedial Items** (45 min)
   - 🔴 Red items from L10s
   - Strategic decisions
   - Resource allocation

4. **Meeting Feedback** (10 min)
   - Blind rating 1-10
   - Process improvements

**Artifacts**:
- Portfolio LX Document
- Strategic decisions documented (ADRs if architectural)
- Communication to teams on decisions

---

## Escalation Procedures

### When to Escalate

**Escalate from L5 to L10 when**:
- Blocker affects multiple teams
- Requires resources outside team's control
- Impacts product roadmap or timeline
- Needs product/business decision
- Technical decision with broad impact

**Escalate from L10 to L20 when**:
- Blocker affects multiple products
- Requires executive decision
- Strategic architectural change
- Significant resource allocation needed
- Portfolio-level priority conflict

### How to Escalate

1. **Mark item as 🔴 Red** in current level LX Document

2. **Document clearly**:
   - What is blocked
   - Why it's blocked
   - What is needed to unblock
   - Impact if not resolved
   - Proposed solution(s)

3. **Add to next level's "Remedial Items"**:
   - L5 → L10 Remedial Items
   - L10 → L20 Remedial Items

4. **Notify meeting facilitator** ahead of time

5. **Follow up**:
   - Decision made → Update all LX docs
   - Still blocked → Continue escalating
   - Resolved → Mark 🟢 Green and close

### Escalation SLA

- **L5 to L10**: Addressed within 1 week (next L10 meeting)
- **L10 to L20**: Addressed within 1 week (next L20 meeting)
- **Critical blockers**: Out-of-band meeting within 24-48 hours

---

## Process Improvements

### Continuous Improvement

**Feedback Collection**:
- Meeting ratings (1-10) captured at end of every L5/L10/L20
- Opportunity items from retrospectives
- Process issues logged in `improvements/`

**Review Cycle**:
- Monthly: Review process metrics and feedback
- Quarterly: Major process adjustments if needed
- Adapt meeting cadences based on team needs

**Metrics to Track**:
- Meeting effectiveness ratings
- Time from blocker identification to resolution
- ADR/Design Review turnaround time
- LX Document freshness
- Jira/Confluence sync accuracy

---

## Getting Started with LXI

### New Repository Setup

1. **Copy LXI structure**:
   ```bash
   mkdir -p {agents,commands,context,improvements,practices,principles,process,product,purpose,user}
   mkdir -p {agents/{perspectives,profiles,skills},commands/{skills,tools},context/{analysis,docs,projects},principles/{adrs,design-reviews},process/lx,product/progress}
   ```

2. **Copy templates**:
   - ADR template → `principles/adrs/adr-template.md`
   - Design Review template → `principles/design-reviews/design-review-template.md`
   - LX template → `process/lx/lx-weekly-template.md`
   - Standup template → `product/progress/standup-template.md`

3. **Customize**:
   - Update `README.md` with project context
   - Fill in `purpose/` with product vision
   - Add architecture principles to `principles/README.md`
   - Configure external integrations (Jira, Confluence)

4. **First Documents**:
   - Create first LX document for current week
   - Document existing architecture decisions as ADRs
   - Set up meeting cadences (L5/L10/L20)

---

## FAQ

**Q: Do I really need to document everything?**
A: Document decisions and significant work. Trivial changes can skip documentation but should still reference Jira stories in commits.

**Q: What if we don't use Jira?**
A: LXI can work with any project management tool. Adjust references to point to your tool (GitHub Issues, Linear, etc.).

**Q: How long should ADRs be?**
A: As short as possible while capturing context, decision, and consequences. Aim for 1-2 pages.

**Q: Can we modify the templates?**
A: Yes! Templates are starting points. Adapt to your team's needs while maintaining core structure (context, decision, consequences, references).

**Q: What if our team is just one person?**
A: Scale down meetings (skip L5 entirely, maybe) but still maintain documentation for future team members and stakeholders.

**Q: How do we handle legacy decisions?**
A: Capture them as ADRs with "Historical" status. Date them when the decision was actually made, note when documented.

---

_This process documentation follows the LXI framework. See [ARCHITECTURE.md](../ARCHITECTURE.md) for system overview._
