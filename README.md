# LXI - LX In-Sync

> **Keeping engineering and business automatically synchronized - so your roadmap always reflects reality.**

**LXI** = **LX In-Sync**, where:
- **LX** is derived from the L10 meeting model (tiered meetings: L5, L10, L20)
- **In-Sync** means engineering work and business planning stay automatically synchronized
- **I** completes "In-Sync" - the system that keeps multiple levels aligned

LXI bridges technical implementation with product management by automating synchronization between code, documentation, and project management tools (Jira, Confluence, etc.).

---

## 💡 The Value Proposition

**The Problem**: Engineering and product teams work in different tools, creating constant friction, duplicate work, and misalignment.

**The Solution**: LXI creates a **bidirectional sync** between where engineers work (Git repository) and where business works (Jira, Confluence).

### How It Works

```
┌─────────────────────────────────────────────────────────────────────┐
│                    Engineering stays in Git                         │
│                    Business stays in Jira/Confluence                │
│                    LXI keeps them automatically in sync             │
└─────────────────────────────────────────────────────────────────────┘

Engineers Work Here              LXI Sync              Business Works Here
─────────────────────            ─────────             ──────────────────

📁 Git Repository            ◄──────────────►         📊 Jira
├─ ADRs                      Automatic Sync          ├─ Epics
├─ Design Reviews            Bidirectional           ├─ Stories
├─ LX Weekly Docs                                    ├─ Progress Updates
├─ Daily Standups                                    └─ Status (🟢🟡🔴)
└─ Code + PRs
                                  ▼
                                                     📝 Confluence
Git commit                   Updates both           ├─ Weekly Reports
├─ References ADR-0015       directions             ├─ Architecture Docs
├─ Links to TEAM-123                                ├─ Design Decisions
└─ Status updates                                   └─ Team Progress


           Repository = Source of Truth
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
    Engineers     Product Mgrs   Leadership
    work in Git   read Jira      read Confluence
        │             │             │
        └─────────────┴─────────────┘
              All stay in sync
```

### The Result

✅ **Engineers** write code, commit changes, create ADRs/Design Reviews → **stays in Git**
✅ **Product Managers** check Jira epics, read status updates → **automatically updated from Git**
✅ **Leadership** reviews Confluence pages → **weekly LX docs auto-synced from repository**
✅ **Everyone** sees the same truth, no manual copying, no drift

**You work where you're productive. LXI handles the sync.**

---

## 🎯 What is LXI?

LXI is an **internal product manager** that:

- **Keeps teams aligned** by moving tracking and coordination into the repository itself
- **Maintains single source of truth** where the repository updates plans, documentation, and Jira
- **Reflects accurate progress** with automated updates on the top-level README and external systems
- **Links multiple microservices** through shared LX documents and Jira epics when more than one service uses LXI

---

## 🚀 Quick Start

### Installation

1. **Prerequisites**: Bash shell, Git
   ```bash
   # Optional: Install Mermaid CLI for diagram generation
   npm install -g @mermaid-js/mermaid-cli
   ```

2. **Setup**: See [SETUP.md](./SETUP.md) for detailed setup guide

3. **Create First Documents**:
   ```bash
   # Create your first ADR
   lxi create adr "Database Selection"

   # Create weekly LX document
   lxi update lx

   # Generate daily standup
   lxi standup generate
   ```

### Learn the System

1. **Understand the System**: Read [ARCHITECTURE.md](./ARCHITECTURE.md)
2. **See It In Action**: Review [EXAMPLE.md](./EXAMPLE.md) for end-to-end scenario
3. **Follow the Process**: Check [process/README.md](./process/README.md) for workflows
4. **Use the Templates**:
   - [ADR Template](./principles/adrs/adr-template.md)
   - [Design Review Template](./principles/design-reviews/design-review-template.md)
   - [LX Weekly Template](./process/lx/lx-weekly-template.md)
   - [Standup Template](./product/progress/standup-template.md)

---

## 📚 Core Documentation

| Document | Purpose |
|----------|---------|
| [ARCHITECTURE.md](./ARCHITECTURE.md) | System overview, components, and philosophy |
| [INTEGRATION.md](./INTEGRATION.md) | How documents cross-reference and sync |
| [EXAMPLE.md](./EXAMPLE.md) | End-to-end example walkthrough |
| [process/README.md](./process/README.md) | Workflows, decision trees, and procedures |
| [agents/README.md](./agents/README.md) | AI agent rules and capabilities |

---

## 🏗️ System Components

### 📋 Meeting Structure (L5/L10/L20)

LXI implements a tiered meeting structure:

- **L5 (Team)**: Daily/weekly tactical execution, blockers, and priorities
- **L10 (Product)**: Weekly cross-team coordination and product alignment
- **L20 (Portfolio)**: Weekly leadership alignment across products

### 📄 Documentation Artifacts

- **ADRs** ([principles/adrs/](./principles/adrs/)): Architecture decisions with business context
- **Design Reviews** ([principles/design-reviews/](./principles/design-reviews/)): Technical implementation planning
- **LX Documents** ([process/lx/](./process/lx/)): Weekly progress tracking (Last Week/This Week)
- **Progress** ([product/progress/](./product/progress/)): Daily standup updates

### 📊 Product Visualizations

Auto-generated diagrams for stakeholder communication:

- **Roadmap** ([product/roadmap.svg](./product/)): Gantt-style timeline of epics
- **Outcomes** ([product/outcomes.svg](./product/)): OKR progress dashboard
- **Dependencies** ([product/epic-dependencies.svg](./product/)): Cross-team dependency graph
- **Capacity** ([product/](./product/)): Team allocation pie charts

See [product/README.md](./product/README.md) for visualization details.

### 🔗 External Integrations

- **Jira**: Epics and stories synced from repository
- **Confluence**: LX documents and architecture decisions published weekly
- **Git**: Commits and PRs reference ADRs and Design Reviews
- **Mermaid**: Diagrams auto-generated and embedded in external systems

---

## 🎨 Core Philosophy

### The Fundamental Flow

```
Engineering Work → Product Roadmap → Business Decisions → User Timelines
     ↓                    ↓                  ↓                  ↓
  Every commit      Must reflect in      Based on accurate    Customers rely
  Every PR          product diagrams     roadmap data         on commitments
  Every change      Every impact         Every decision       Every promise
```

**This is non-negotiable**: When engineering reality changes, product reality must change immediately. Business users and customers make critical decisions based on your roadmap. Hiding delays or scope changes breaks trust and cascades into failed commitments.

### Core Principles

1. **Work from files, not memories** - All context lives in the repository
2. **Engineering changes trigger business updates** - Every PR with impact updates product diagrams
3. **Analysis grows stale** - Documentation must be dated and refreshed
4. **Takeaways cascade upward** - Insights from execution feed back into planning context
5. **Repository is truth** - The repo updates external systems, not vice versa
6. **Test before code** - Tests define expected behavior, agents write tests first

---

## 📁 Directory Structure

```
lxi/
├─ agents/              # AI agent configurations
│  ├─ perspectives/     # Engineer, PM, QA, User perspectives
│  ├─ profiles/         # Voice and behavior settings
│  └─ skills/           # Reusable agent capabilities
│
├─ commands/            # Repeatable instruction sets
│  ├─ skills/           # Complex repeatable tasks
│  └─ tools/            # Small maintenance scripts
│
├─ context/             # Knowledge and analysis
│  ├─ analysis/         # Dated technical analysis
│  ├─ docs/             # Evergreen documentation
│  └─ projects/         # Historical project breakdowns
│
├─ improvements/        # Process improvement backlog
│
├─ practices/           # Team methodologies (Scrum, Kanban, etc.)
│
├─ principles/          # Architecture and decisions
│  ├─ adrs/             # Architecture Decision Records
│  └─ design-reviews/   # Technical design documents
│
├─ process/             # Workflows and procedures
│  └─ lx/               # Weekly LX documents
│
├─ product/             # Product management
│  └─ progress/         # Daily standup tracking
│
├─ purpose/             # Product vision and goals
│
└─ user/                # User configurations
```

---

## 🔄 Work Lifecycle

```
1. PLANNING
   ├─ Business need identified
   ├─ ADR created (if architectural impact)
   └─ Design Review created

2. DESIGN
   ├─ Design Review meeting held
   ├─ Solution selected
   └─ Jira Epic/Stories created

3. EXECUTION
   ├─ Daily work tracked in standups
   ├─ Code written, PRs created
   └─ Status: 🟢 🟡 🔴

4. TRACKING
   ├─ Daily: Standup → Jira sync
   ├─ Weekly: LX Document → Confluence sync
   └─ Progress visible to all

5. COMPLETION
   ├─ Work merged and deployed
   ├─ Lessons captured
   └─ Takeaways cascaded to context
```

---

## 🚦 Traffic Light System

All work uses consistent status indicators:

- 🟢 **Green**: On track, no issues
- 🟡 **Yellow**: At risk, needs attention
- 🔴 **Red**: Blocked, requires escalation

**Escalation**: 🔴 Red at L5 → L10 → L20 as needed

---

## 🤖 AI Agent Integration

LXI includes AI agent capabilities:

**Core Rules**:
- Work from files, not memories
- Flag stale analysis (>30 days)
- Maintain cross-references
- Sync external systems

**LXI Commands**:
```bash
lxi create adr [topic]              # Create new ADR
lxi create design-review [feature]  # Create Design Review
lxi update lx [week]                # Update weekly LX document
lxi standup generate [date]         # Auto-generate standup from Git
lxi sync jira                       # Sync repository to Jira
lxi sync confluence                 # Sync LX docs to Confluence
lxi sync all                        # Sync to all external systems
lxi validate                        # Check cross-reference integrity
lxi check freshness [days]          # Find stale documents
lxi archive lx [date]               # Archive old LX documents
```

See [commands/README.md](./commands/README.md) for complete command reference.

---

## 📖 Example Use Cases

### Scenario 1: New Feature
```bash
# 1. Create Design Review exploring options
lxi create design-review "User Authentication"

# 2. Make architectural decision (ADR if needed)
lxi create adr "Authentication Strategy"

# 3. Track progress in daily standups
lxi standup generate

# 4. Update weekly LX document
lxi update lx

# 5. Sync to external systems
lxi sync all
```

### Scenario 2: Critical Bug
1. Report in daily standup (🔴 Red)
   ```bash
   lxi standup generate  # Add blocker manually
   ```
2. Add to LX Document blockers
   ```bash
   lxi update lx  # Flag blocker as Red
   ```
3. Escalate if needed (L5 → L10)
4. Fix and document root cause
5. Update context with lessons

### Scenario 3: Multi-Team Dependency
1. Identify in Design Review
2. Escalate to L10 meeting
3. Track in both teams' LX documents
   ```bash
   lxi update lx  # Both teams update
   ```
4. Coordinate via shared Jira Epic
5. Resolve and update status
   ```bash
   lxi sync all  # Sync resolution to Jira/Confluence
   ```

---

## 🎓 Getting Started

### For New Teams

1. **Copy Structure**: Use directory layout above
2. **Customize Templates**: Adapt to your team's needs
3. **Set Up Integrations**: Configure Jira, Confluence sync (optional)
   ```bash
   mkdir -p .lxi
   # Create .lxi/jira.yml and .lxi/confluence.yml
   ```
4. **Create First Documents**:
   ```bash
   lxi update lx                    # Weekly LX document
   lxi create adr "Initial Setup"   # Document existing decisions
   lxi standup generate             # Daily progress
   ```

### For Existing Repositories

1. **Review [ARCHITECTURE.md](./ARCHITECTURE.md)**: Understand the system
2. **Walk Through [EXAMPLE.md](./EXAMPLE.md)**: See it in action
3. **Adapt Templates**: Modify for your context
4. **Start Small**: Begin with LX documents and standup tracking
5. **Expand**: Add ADRs and Design Reviews as architectural decisions arise

---

## 📊 Success Criteria

LXI is working well when:

✅ Top-level README always reflects current state
✅ Stakeholders get status from repository alone
✅ ADRs and Design Reviews referenced in code
✅ LX Documents sync with Jira/Confluence weekly
✅ Blockers surface and escalate quickly
✅ Analysis is fresh (dated within 30 days)
✅ Multi-repo teams share coherent LX documents
✅ AI agents navigate and update autonomously

---

## 🤝 Contributing

LXI is an open framework. Customize for your team's needs!

**Process Improvements**: Add to `improvements/`
**New Templates**: Contribute to `principles/` or `process/`
**Agent Skills**: Extend `agents/skills/`

---

## 📄 License

[Add your license here]

---

## 🙏 Acknowledgments

Inspired by:
- **EOS (Entrepreneurial Operating System)**: L5/L10/L20 meeting structure
- **Architecture Decision Records (ADRs)**: Documenting architectural decisions
- **Design Reviews**: Technical planning and decision-making
- **Agile/Scrum**: Daily standups and sprint tracking

---

## 🛠️ Command Line Interface

LXI provides a complete CLI for managing documentation and workflows:

```bash
# Document Creation
lxi create adr "Database Selection"
lxi create design-review "User Authentication"

# Progress Tracking
lxi standup generate              # Daily standup from Git commits
lxi update lx                     # Weekly LX document

# External System Sync
lxi sync jira                     # Sync to Jira
lxi sync confluence               # Sync to Confluence
lxi sync all                      # Sync everywhere

# Quality & Maintenance
lxi validate                      # Check broken links
lxi check freshness               # Find stale documents
lxi archive lx                    # Archive old LX docs
```

See [commands/README.md](./commands/README.md) for complete command reference.

---

## 🔌 Optional Integrations

### Jira Sync

```bash
# Configure Jira
cat > .lxi/jira.yml <<EOF
url: https://your-domain.atlassian.net
email: your-email@example.com
api_token: your-api-token
EOF

# Sync repository to Jira
lxi sync jira
```

### Confluence Sync

```bash
# Configure Confluence
cat > .lxi/confluence.yml <<EOF
url: https://your-domain.atlassian.net/wiki
email: your-email@example.com
api_token: your-api-token
space: TEAM
parent_page_id: 123456
EOF

# Sync LX documents to Confluence
lxi sync confluence
```

### Diagram Generation

```bash
# Install Mermaid CLI
npm install -g @mermaid-js/mermaid-cli

# Diagrams in product/*.mmd auto-sync with:
lxi sync all
```

---

_Last Updated: 2024-10-27_
_System Status: 🟢 All templates and commands ready for use_

    