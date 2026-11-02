# Quick Start Guide - Common Scenarios

Fast, practical guides for common LXI workflows.

---

## 🎯 Scenario 1: I'm assigned an epic and need to break it into stories

**Time**: 2-4 hours | **Persona**: Engineer or Engineering Lead

### Step 1: Understand the Epic (15 min)

```bash
# Check if epic has design review already
ls principles/design-reviews/ | grep -i [epic-keyword]

# Check Jira epic description
# Look for: Business value, scope, success criteria
```

### Step 2: Create Design Review (30 min)

```bash
# Create design review
lxi create design-review "Epic Name"

# Opens: principles/design-reviews/YYYY-MM-DD-epic-name.md
```

**Fill in these sections:**
1. **Section 1: Work Definition**
   - Problem statement (why are we doing this?)
   - Business value (what's the ROI?)
   - Scope (what's in/out?)

2. **Section 2: Solutions Proposal**
   - Option 1: [Approach A]
   - Option 2: [Approach B]
   - Comparison & recommendation

3. **Section 4: Technical Implementation**
   - **THIS IS WHERE YOU BREAK IT DOWN:**

   ```markdown
   ### Solution Breakdown

   1. **Database Schema Changes**
      - Owner: Backend Engineer
      - Duration: 2 days
      - Dependencies: None
      - Stories: TEAM-101, TEAM-102

   2. **API Endpoints**
      - Owner: Backend Engineer
      - Duration: 3 days
      - Dependencies: Database schema
      - Stories: TEAM-103, TEAM-104, TEAM-105

   3. **Frontend Components**
      - Owner: Frontend Engineer
      - Duration: 4 days
      - Dependencies: API endpoints
      - Stories: TEAM-106, TEAM-107

   4. **Testing & QA**
      - Owner: QA Engineer
      - Duration: 2 days
      - Dependencies: Frontend complete
      - Stories: TEAM-108, TEAM-109

   5. **Documentation**
      - Owner: Tech Writer
      - Duration: 1 day
      - Dependencies: Feature complete
      - Stories: TEAM-110
   ```

### Step 3: Create Jira Stories (45 min)

For each component in your breakdown:

**Story Template:**
```
Title: [Component Name] - [Specific Task]
Description:
  As a [user type]
  I want [functionality]
  So that [benefit]

Acceptance Criteria:
  - [ ] Criterion 1
  - [ ] Criterion 2
  - [ ] Tests passing
  - [ ] Code reviewed

Technical Details:
  See Design Review: [link to design review]
  Dependencies: [list dependent stories]

Estimated Effort: [Story points]
```

### Step 4: Link Everything

```markdown
# In your design review
## Related Documents
- Epic: TEAM-100
- Stories: TEAM-101, TEAM-102, TEAM-103, TEAM-104, TEAM-105

# In each Jira story
Design Review: [link to design review in repo]
```

### Step 5: Update LX Document (15 min)

```bash
# Update this week's LX doc
lxi update lx

# Add epic to Epic Status section:
```

```markdown
### Epic: [Name] - TEAM-100

**Status**: 🟢 Green
**Progress**: 0%
**Owner**: [Your Name]
**Target Date**: YYYY-MM-DD

**This Week**:
- Created design review
- Broke down into 10 stories
- Stories ready for sprint planning

**Next Week**:
- Begin implementation (TEAM-101, TEAM-102)
```

---

## 📝 Scenario 2: I need to submit a design review for approval

**Time**: 30-60 min | **Persona**: Engineer

### Step 1: Verify Design Review is Complete

**Checklist:**
- [ ] All sections filled in (especially Solutions Proposal)
- [ ] At least 2 solution options explored
- [ ] Recommendation made with rationale
- [ ] Technical implementation breakdown complete
- [ ] Success metrics defined
- [ ] Risks identified with mitigations

### Step 2: Validate Cross-References

```bash
# Check all links work
lxi validate

# Fix any broken links
```

### Step 3: Commit and Push

```bash
# Add design review
git add principles/design-reviews/YYYY-MM-DD-feature-name.md

# Commit
git commit -m "Design Review: Feature Name

Created design review for [TEAM-XXX].

Recommended approach: [Solution X]
Estimated effort: [Y weeks]

Requesting review from:
- Engineering Lead
- Product Manager
- [Other stakeholders]
"

# Push
git push
```

### Step 4: Request Review

**Create PR/MR:**
```markdown
## Design Review: [Feature Name]

**Jira**: TEAM-XXX
**Effort**: X weeks
**Recommended**: Solution Y

### Summary
[2-3 sentence summary of feature and recommended approach]

### Reviewers Needed
- [ ] @engineering-lead - Technical feasibility
- [ ] @product-manager - Business alignment
- [ ] @qa-lead - Testability
- [ ] @security (if needed) - Security review

### Next Steps After Approval
1. Create Jira stories
2. Update LX document
3. Begin implementation
```

**OR Schedule Design Review Meeting:**
```
Subject: Design Review: [Feature Name]

Attendees:
- Engineering Lead
- Product Manager
- QA Lead
- [Feature team members]

Duration: 60 minutes

Agenda:
1. Problem overview (5 min)
2. Solution options walkthrough (20 min)
3. Discussion & questions (25 min)
4. Decision & next steps (10 min)

Pre-read: principles/design-reviews/YYYY-MM-DD-feature-name.md
Please review before meeting!
```

### Step 5: After Approval

```bash
# Update design review status
vim principles/design-reviews/YYYY-MM-DD-feature-name.md
```

```markdown
## Section 3: Inform and Decide

**Status**: 🟢 Approved
**Chosen Solution**: Solution 2
**Decision Makers**:
- Jane Doe - Engineering Lead
- John Smith - Product Manager

**Date**: YYYY-MM-DD
```

```bash
# Commit approval
git add principles/design-reviews/
git commit -m "Design Review approved: Feature Name

Approved by EM and PM on YYYY-MM-DD.
Chosen solution: Solution 2

Next: Create stories and begin implementation
"
```

---

## 🔴 Scenario 3: I'm blocked and need help

**Time**: 10-20 min | **Persona**: Engineer

### Step 1: Document the Blocker (5 min)

**In today's standup:**

```bash
# Generate or update standup
lxi standup generate
vim product/progress/$(date +%Y-%m-%d)-standup.md
```

```markdown
### [Your Name]

**Yesterday** ✅:
- Started work on TEAM-XXX
- Discovered blocker (see below)

**Today** 🎯:
- Waiting on unblock
- Working on TEAM-YYY (different task) meanwhile

**Blockers** ⚠️:
- 🔴 **CRITICAL**: Need API key from Platform team for TEAM-XXX
  - Requested: 2024-10-25
  - Needed by: 2024-10-27
  - Blocking: Can't test integration without it
  - Owner: @platform-team
```

### Step 2: Escalate if Needed (5 min)

**If blocker is critical and >24 hours old:**

```bash
# Update LX document
vim process/lx/$(ls -t process/lx/*.md | head -1)
```

```markdown
## Blockers

### Blocker: Platform API Key

**Epic**: TEAM-100
**Issue**: Need production API key from Platform team
**Impact**: Blocking integration testing (TEAM-XXX)
**Blocked Since**: 2024-10-25
**Owner**: Platform Team (@john-doe)
**Action Required**: Provision API key
**Status**: 🔴 Escalated to L10
**Target Resolution**: 2024-10-27
```

### Step 3: Communicate (5 min)

**Slack message:**
```
🔴 BLOCKER - TEAM-XXX

Issue: Need production API key from Platform team
Impact: Can't complete integration testing
Blocked since: Monday (2 days)
Need by: Wednesday

@platform-team Can you help prioritize this?

Details: process/lx/YYYY-MM-DD-weekly.md#blockers
```

### Step 4: Work on Something Else

While blocked on TEAM-XXX:
- Pick up TEAM-YYY from backlog
- Help review someone's PR
- Update documentation
- Work on technical debt

**Update standup to show you're productive:**
```markdown
**Today** 🎯:
- 🔴 Still blocked on TEAM-XXX (waiting on API key)
- ✅ Working on TEAM-YYY meanwhile (bug fix)
- ✅ Reviewed 2 PRs (TEAM-AAA, TEAM-BBB)
```

---

## 📊 Scenario 4: Weekly status update (EM/Lead)

**Time**: 20-30 min | **Persona**: Engineering Manager or Lead

### Step 1: Collect Information (10 min)

```bash
# Review this week's standups
ls product/progress/$(date +%Y-%m)*-standup.md

# See what was accomplished
grep -A 3 "Yesterday" product/progress/$(date +%Y-%m)*-standup.md

# Check for blockers
grep -B 2 -A 5 "Blockers" product/progress/$(date +%Y-%m)*-standup.md
```

### Step 2: Update LX Document (15 min)

```bash
# Create or update this week's LX doc
lxi update lx

# Opens: process/lx/YYYY-MM-DD-weekly.md
```

**Update these sections:**

1. **Last Week** - Aggregate standup accomplishments
2. **This Week** - Team priorities
3. **Epic Status** - Update each epic's progress and traffic light
4. **Blockers** - Any critical issues
5. **Open Decisions** - Questions for product/business

### Step 3: Sync to External Systems (5 min)

```bash
# Sync to Confluence and Jira
lxi sync all

# Verify sync worked
# Check Confluence page updated
# Check Jira epic notes updated
```

---

## 🤝 Scenario 5: Product Manager wants to answer open decisions

**Time**: 15 min | **Persona**: Product Manager

### Step 1: Find Open Decisions

```bash
# Check latest LX document
grep -A 20 "## Open Decisions" process/lx/$(ls -t process/lx/*.md | head -1)
```

### Step 2: Add Answers to LX Document

**Option A: Direct Update (if you have repo access)**

```bash
# Edit LX document
vim process/lx/$(ls -t process/lx/*.md | head -1)
```

```markdown
## Open Decisions

### Decision 1: Mobile app platform choice

**Context**: TEAM-102 starting soon
**Question**: iOS-first or cross-platform?
**Options**:
  1. iOS-first (Swift) - faster to market
  2. React Native - code reuse

**Needed From**: Product team
**Urgency**: High
**Status**: ✅ **ANSWERED (2024-10-26)**

**Answer from Product (Lisa Park)**:
Go with iOS-first (Swift).

**Rationale**:
- 70% of our users are on iOS
- Need to move fast for Q4 launch
- Can add Android in Q1 2025

**Next Steps**:
- Team can begin iOS development
- Plan Android for Q1 2025 roadmap
```

```bash
# Commit answer
git add process/lx/
git commit -m "PM Answer: Mobile platform decision

Answered open decision re: mobile platform.
Decision: iOS-first approach

- Allows Q4 launch
- Android planned for Q1 2025
"
```

**Option B: Via Confluence (if no repo access)**

1. Open Confluence LX page
2. Find "Open Decisions" section
3. Add your answer
4. EM will sync back to repo:

```bash
# EM pulls answer from Confluence, updates repo
vim process/lx/YYYY-MM-DD-weekly.md
# Add PM's answer
git commit -m "Update: PM answered mobile platform decision"
```

---

## 🔍 Scenario 6: Find out why we made decision X

**Time**: 5-10 min | **Persona**: Any

### Quick Search

```bash
# Search ADRs for keyword
grep -r "keyword" principles/adrs/

# Search design reviews
grep -r "keyword" principles/design-reviews/

# List ADRs by title
ls principles/adrs/ | sort
```

### Find Specific Decision

```bash
# Example: Why did we choose PostgreSQL?
grep -r "PostgreSQL\|postgres" principles/adrs/

# Read the ADR
cat principles/adrs/0015-database-choice.md

# Check if it's been superseded
grep "Superseded" principles/adrs/0015-database-choice.md
```

### Understand Current Architecture

```bash
# List all current (not superseded) ADRs
for adr in principles/adrs/*.md; do
  if ! grep -q "Superseded" "$adr"; then
    echo "$adr - CURRENT"
  fi
done
```

---

## ⚡ Quick Reference Commands

```bash
# Create documents
lxi create adr "Decision"              # Architecture decision
lxi create design-review "Feature"     # Design review

# Track progress
lxi standup generate                   # Daily standup from Git
lxi update lx                          # Weekly LX doc

# Sync to external systems
lxi sync all                           # Sync Jira + Confluence

# Validate
lxi validate                           # Check broken links
lxi check freshness                    # Find stale docs

# Maintenance
lxi archive lx                         # Archive old LX docs
```

---

## ⚠️ Scenario 7: My PR has an impact on the roadmap

**Time**: 15-30 min | **Persona**: Engineer

### Context

You're submitting a PR and realize:
- Work took longer than estimated
- Scope expanded during implementation
- Found a blocker that delays the milestone

### Step 1: Assess the Impact (2 min)

**In your PR, use the Plan Impact section:**

```markdown
**Impact on Roadmap/Deliverables**:
- [ ] Expected
- [x] Medium - Notable impact requiring PM awareness

**Impact Details**:
Feature took 3 extra days due to unforeseen API complexity.
Epic TEAM-100 completion pushed from 2024-11-15 to 2024-11-22.
Still within sprint but affects quarterly milestone.
```

### Step 2: Update Product Diagrams (10 min)

**Required for Low/Medium/High impact:**

```bash
# Update roadmap with new dates
vim product/roadmap.mmd
```

```mermaid
# Find your epic and update end date
Epic User Dashboard : 2024-10-15, 2024-11-22  # Was 2024-11-15
```

```bash
# If OKR affected, update outcomes
vim product/outcomes.mmd

# Regenerate images
lxi sync all  # Or manually: mmdc -i product/roadmap.mmd -o product/roadmap.svg
```

### Step 3: Update LX Document (5 min)

```bash
# Update this week's LX doc
vim process/lx/$(ls -t process/lx/*.md | head -1)
```

**Add to "This Week" or "Blockers" section:**

```markdown
### Epic: User Dashboard - TEAM-100

**Status**: 🟡 Yellow
**Progress**: 80%
**Impact**: Medium

**This Week**:
- Completed TEAM-105 (Dashboard API integration)
- ⚠️ API complexity added 3 days to timeline
- New completion date: 2024-11-22 (was 2024-11-15)

**Next Week**:
- Complete final testing
- Deploy to production
```

### Step 4: Notify Stakeholders (5 min)

**Based on impact level:**

**Low Impact (1-2 days)**:
- Just note in LX document
- Discuss in next L5 standup

**Medium Impact (1 week or scope change)**:
- Tag PM in PR: "@product-manager FYI - timeline impact"
- Discuss in L5, may escalate to L10
- Update in weekly sync

**High Impact (>1 week or milestone at risk)**:
- Immediate Slack/email to PM
- Schedule emergency discussion
- Prepare for L10 escalation

**Example Slack message (Medium impact):**
```
🟡 Timeline Update - TEAM-100 User Dashboard

Impact: 3 day delay (Medium)
New Completion: Nov 22 (was Nov 15)
Reason: Unforeseen API integration complexity

Updated:
✅ Roadmap diagram
✅ This week's LX doc
✅ PR #123 with details

Still within sprint, but affects Q4 milestone by 1 week.
Let's discuss in tomorrow's L5.
```

### Step 5: PR Review Process

**Reviewer must verify:**

```markdown
PR Review Checklist:
- [x] Plan Impact assessed (Medium)
- [x] Product diagrams updated
- [x] LX Document updated
- [x] PM notified
- [x] Impact explanation clear
```

**PR should NOT be approved until:**
- Diagrams reflect new reality
- Stakeholders are aware
- LX document explains impact

### Why This Matters

**Without this process:**
- ❌ Business makes decisions on outdated roadmap
- ❌ PM learns about delays too late
- ❌ Stakeholders lose trust
- ❌ Cascade failures as dependencies shift

**With this process:**
- ✅ Roadmap always reflects reality
- ✅ Early visibility enables replanning
- ✅ Trust maintained through transparency
- ✅ Proactive problem solving

---

## 🆘 Get Help

| Need | Command | Doc |
|------|---------|-----|
| Command help | `lxi help` | [commands/README.md](./commands/README.md) |
| System overview | - | [ARCHITECTURE.md](./ARCHITECTURE.md) |
| Full example | - | [EXAMPLE.md](./EXAMPLE.md) |
| Onboarding | - | [ONBOARDING.md](./ONBOARDING.md) |
| Workflows | - | [process/README.md](./process/README.md) |
| Installation | - | [SETUP.md](./SETUP.md) |

---

_For detailed workflows, see [EXAMPLE.md](./EXAMPLE.md)_
