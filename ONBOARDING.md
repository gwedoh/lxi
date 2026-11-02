# Engineer Onboarding Guide

**Welcome!** This guide helps you get up to speed on the codebase and how we work.

---

## Day 1: Understanding the System

### Step 1: Read the Basics (30 minutes)

**Start here:**
1. **[README.md](./README.md)** - What this project does
2. **[ARCHITECTURE.md](./ARCHITECTURE.md)** - How the system works
3. **[principles/README.md](./principles/README.md)** - Architecture principles

**Key concepts to understand:**
- 🟢🟡🔴 Traffic light system (Green/Yellow/Red status)
- L5/L10/L20 meetings (Team/Product/Portfolio levels)
- LXI framework (this repo structure)

---

### Step 1.5: **CRITICAL** - The Engineering → Business Impact Chain (15 minutes)

**⚠️ This is the most important thing you'll learn today ⚠️**

```
Your Code → Product Roadmap → Business Decisions → Customer Promises
```

**What this means for you**:
1. **Every PR you submit** affects business timelines
2. **Every delay or scope change** impacts customer commitments
3. **Hiding problems** breaks trust and causes cascade failures
4. **You are responsible** for keeping roadmaps accurate

**The Non-Negotiable Rule**:

Every PR must assess **Plan Impact**: `Expected | Low | Medium | High`

- **Expected**: On schedule, no updates needed ✅
- **Low/Medium/High**: MUST update product diagrams before merge 🚨
  - Update `product/roadmap.mmd` with new timeline
  - Update `product/outcomes.mmd` if OKRs affected
  - Update `product/epic-dependencies.mmd` if dependencies changed
  - Regenerate diagrams: `lxi sync all`
  - Notify PM/stakeholders

**PR cannot be approved until diagrams match reality.**

**Why this is critical**:
- PM commits delivery dates to customers based on roadmap
- Leadership allocates budget based on timelines
- Sales promises features based on delivery dates
- Other teams plan dependencies based on your dates
- **Inaccurate roadmaps = broken promises = lost trust = lost business**

**Action items right now**:
1. Read [Principle #9: Engineering Reality Drives Business Reality](./principles/README.md#9-engineering-reality-drives-business-reality)
2. Review [.github/PULL_REQUEST_TEMPLATE.md](./.github/PULL_REQUEST_TEMPLATE.md) - Plan Impact section
3. Look at `product/roadmap.mmd` to see how dates are tracked
4. Understand: **Your code changes business reality. Act accordingly.**

---

### Step 2: Explore Existing Decisions (30 minutes)

**Where to look:**

```bash
# See all architecture decisions
ls -la principles/adrs/

# See all design reviews
ls -la principles/design-reviews/

# See recent progress
ls -la process/lx/ | tail -5
```

**What to read:**
- Pick 2-3 recent ADRs to understand key architectural decisions
- Read 1-2 design reviews to see how features were planned
- Skim the latest LX document to understand current work

**Pro tip**: Use `lxi validate` to ensure all cross-references work, then follow the links!

---

### Step 3: Understand Current Work (20 minutes)

**Check the latest LX document:**

```bash
# Find most recent LX doc
ls -t process/lx/*.md | head -1

# Read it
cat $(ls -t process/lx/*.md | head -1)
```

**What to look for:**
- **Epic Status**: What epics are active? (🟢🟡🔴)
- **This Week**: What's being worked on right now?
- **Blockers**: Any issues the team is facing?
- **Open Decisions**: Questions that need answers?

---

## Day 2-3: Getting Your Hands Dirty

### Set Up Your Environment

```bash
# Make lxi command available globally
cd /path/to/this/repo
sudo ln -s "$(pwd)/bin/lxi" /usr/local/bin/lxi

# Verify
lxi version
lxi help
```

---

### Understand the Codebase Structure

**Ask these questions:**

1. **What are the main components?**
   ```bash
   # Look at directory structure
   tree -L 2 -d src/  # or wherever code lives

   # Look for architecture diagrams
   find . -name "*.mmd" -o -name "*architecture*"
   ```

2. **What are the key dependencies?**
   ```bash
   # Check package.json / build.gradle / requirements.txt
   cat package.json | jq '.dependencies'
   ```

3. **What ADRs exist for this codebase?**
   ```bash
   # List all ADRs
   ls principles/adrs/*.md | grep -v template

   # Read README for guidance
   cat principles/adrs/README.md
   ```

4. **What recent design decisions were made?**
   ```bash
   # List design reviews (newest first)
   ls -t principles/design-reviews/*.md | head -5
   ```

---

### Your First Contribution

#### Scenario: You're assigned a small bug fix

**Step 1: Understand the work**
```bash
# Check if there's a design review
ls principles/design-reviews/ | grep -i [bug-topic]

# Check related ADRs
grep -r "keyword" principles/adrs/
```

**Step 2: Make your changes**
```bash
# Work on the code
# ...

# Reference the Jira ticket in commits
git commit -m "[TEAM-XXX] Fix bug in authentication

Fixes issue where users couldn't log in after password reset.

Related:
- Design Review: principles/design-reviews/2024-10-15-auth.md
- ADR: principles/adrs/0023-auth-strategy.md
"
```

**Step 3: Update daily standup**
```bash
# Generate today's standup
lxi standup generate

# Edit to add your work
vim product/progress/$(date +%Y-%m-%d)-standup.md

# Commit
git add product/progress/
git commit -m "Daily standup $(date +%Y-%m-%d)"
```

---

#### Scenario: You're assigned a larger feature

**Step 1: Check if design review exists**
```bash
# Search for design review
ls principles/design-reviews/ | grep -i [feature-name]
```

**If design review doesn't exist:**
```bash
# Create one
lxi create design-review "Feature Name"

# Fill it out following the template
vim principles/design-reviews/$(date +%Y-%m-%d)-feature-name.md
```

**Step 2: Break down the work**
- Use the "Solution Breakdown" section of the design review
- Create stories in Jira based on breakdown
- Link stories to the design review

**Step 3: Track progress**
- Update daily standups
- LX document will roll up your progress weekly

---

## Week 2: Contributing to Process

### Participate in Meetings

**L5 (Team Standup)**:
- **When**: Daily or weekly (check team calendar)
- **Your role**: Share yesterday/today/blockers
- **Preparation**: Update your standup doc before meeting

**Design Reviews**:
- **When**: As needed (you'll be invited)
- **Your role**: Provide technical feedback
- **Preparation**: Read the design review doc before meeting

---

### When to Create Documents

**Create an ADR when:**
- ✅ You're making an architectural decision (database, framework, pattern)
- ✅ Decision affects multiple teams or services
- ✅ Decision is hard to reverse (one-way door)

```bash
lxi create adr "Decision Title"
```

**Create a Design Review when:**
- ✅ You're implementing a significant feature (>1 week)
- ✅ Multiple approaches exist
- ✅ You need team input on implementation

```bash
lxi create design-review "Feature Name"
```

**Update LX document when:**
- ❌ Don't update directly (EM or Lead does this)
- ✅ But DO provide input via daily standups
- ✅ Your work will roll up automatically

---

## Common Questions

### "How do I find out why we chose X technology?"

```bash
# Search ADRs
grep -r "X technology" principles/adrs/

# Or look at ADR titles
ls principles/adrs/ | grep -i "technology-name"
```

### "What's the status of Epic TEAM-XXX?"

```bash
# Check latest LX document
grep -A 10 "TEAM-XXX" process/lx/$(ls -t process/lx/*.md | head -1)
```

### "Who should I ask about Y component?"

```bash
# Check recent commits
git log --format="%an" -- path/to/component | sort | uniq -c | sort -rn | head -5

# Check design reviews
grep -r "Y component" principles/design-reviews/
```

### "What work is blocked right now?"

```bash
# Check latest LX document blockers
grep -A 20 "## Blockers" process/lx/$(ls -t process/lx/*.md | head -1)
```

### "How do I know if my work needs an ADR?"

**Use this decision tree:**

```
Is this an ARCHITECTURAL decision?
├─ YES → Create ADR
│   Examples:
│   - Choosing database technology
│   - Selecting framework
│   - Defining API patterns
│   - Authentication strategy
│
└─ NO → Design Review probably sufficient
    Examples:
    - Feature implementation
    - UI changes
    - Bug fixes
    - Internal refactoring
```

---

## Resources

### Documentation
- [ARCHITECTURE.md](./ARCHITECTURE.md) - System design
- [EXAMPLE.md](./EXAMPLE.md) - End-to-end workflow example
- [process/README.md](./process/README.md) - Workflows and decision trees
- [principles/README.md](./principles/README.md) - Architecture principles

### Commands
```bash
lxi help                          # Show all commands
lxi create adr "Topic"            # Create ADR
lxi create design-review "Name"   # Create design review
lxi standup generate              # Generate standup
lxi validate                      # Check cross-references
lxi check freshness               # Find stale docs
```

### Where to Find Information

| I need to... | Look here |
|--------------|-----------|
| Understand architecture | `principles/adrs/` |
| See how features were designed | `principles/design-reviews/` |
| Check current work status | `process/lx/` (latest file) |
| See daily progress | `product/progress/` |
| Understand processes | `process/README.md` |
| Learn the framework | `ARCHITECTURE.md` |

---

## Your First Week Checklist

- [ ] Read README, ARCHITECTURE, principles/README
- [ ] Read 2-3 recent ADRs
- [ ] Read latest LX document
- [ ] Set up `lxi` command
- [ ] Make first commit with proper references
- [ ] Update daily standup at least once
- [ ] Ask questions! (Team is here to help)

---

## Next Steps

After your first week:
1. **Contribute to design reviews** - Provide technical feedback
2. **Create your first design review** - For your next feature
3. **Propose an ADR** - If you identify an architectural decision needed
4. **Help update documentation** - Found something unclear? Fix it!

---

## Tips for Success

**DO**:
- ✅ Read existing ADRs and Design Reviews before asking questions
- ✅ Reference Jira tickets in commits and PRs
- ✅ Update your standup daily (even if work is in progress)
- ✅ Ask for clarification if a decision is unclear
- ✅ Link your work to existing design reviews and ADRs

**DON'T**:
- ❌ Make architectural decisions without an ADR
- ❌ Skip reading the design review before implementing
- ❌ Leave broken cross-references (run `lxi validate`)
- ❌ Work in isolation - use standups to communicate

---

## Getting Help

**During onboarding:**
- **Your buddy**: [Assigned by manager]
- **Engineering Lead**: [Name]
- **Engineering Manager**: [Name]

**For different questions:**
- **Architecture questions**: Ask in #architecture Slack channel or review ADRs
- **Process questions**: Ask your EM or check process/README.md
- **Technical questions**: Ask in daily standup or team Slack
- **Tooling questions**: Check SETUP.md or commands/README.md

---

_Welcome to the team! We're excited to have you here._
