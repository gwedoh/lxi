# LXI System Architecture

## Overview

**LXI** (LX Interface) is a repository-centric workflow orchestration framework that makes the code repository the single source of truth for engineering teams.

**LXI** = **LX Interface**, where:
- **LX** is derived from the L10 meeting model (tiered meetings: L5, L10, L20)
- **X** denotes multiple chained levels working together (not just one level)
- **I** is this repository Interface that facilitates the multi-level process

It bridges technical implementation with product management by automating synchronization between code, documentation, and project management tools (Jira, Confluence, etc.).

## Core Philosophy

1. **Work from files, not memories** - All context lives in the repository
2. **Analysis grows stale** - Documentation must be dated and refreshed
3. **Takeaways cascade upward** - Insights from execution feed back into planning context
4. **Repository is truth** - The repo updates external systems, not vice versa

## System Components

### 1. Meeting Structure (L5/L10/L20)

LXI implements a tiered meeting structure inspired by EOS (Entrepreneurial Operating System):

```
┌─────────────────────────────────────────────────────┐
│                  L20 MEETING                        │
│              (Portfolio Level)                      │
│    Weekly - Leadership Alignment                    │
│    Duration: 105 minutes                            │
│    Participants: Directors, EMs, PMs, Staff Eng     │
└──────────────────┬──────────────────────────────────┘
                   │
        ┌──────────┴──────────┬──────────────┐
        │                     │              │
┌───────▼──────┐    ┌────────▼──────┐  ┌───▼────────┐
│ L10 MEETING  │    │ L10 MEETING   │  │ L10 MEETING│
│(Product 1)   │    │(Product 2)    │  │(Product 3) │
│              │    │               │  │            │
│Weekly - 90min│    │Weekly - 90min │  │Weekly-90min│
└──────┬───────┘    └───────┬───────┘  └─────┬──────┘
       │                    │                 │
   ┌───┴───┐            ┌───┴───┐        ┌───┴───┐
   ▼       ▼            ▼       ▼        ▼       ▼
┌────┐  ┌────┐      ┌────┐  ┌────┐   ┌────┐  ┌────┐
│ L5 │  │ L5 │      │ L5 │  │ L5 │   │ L5 │  │ L5 │
│Team│  │Team│      │Team│  │Team│   │Team│  │Team│
└────┘  └────┘      └────┘  └────┘   └────┘  └────┘
```

**L5 (Team Level)**
- **Purpose**: Tactical execution - discuss blockers, priorities, immediate tasks
- **Cadence**: Daily or Weekly (varies by initiative)
- **Duration**: Varies by need
- **Participants**: Engineering Leads, Product Owners, Scrum Masters, Engineers
- **Outcomes**: Clear next steps, blocker resolution, task alignment

**L10 (Product Level)**
- **Purpose**: Product-level coordination across teams, dependency management
- **Cadence**: Weekly
- **Duration**: 90 minutes
- **Participants**: Engineering Manager, Product Manager, Scrum Masters, Product Owners, Engineering Leads, Staff Engineers
- **Outcomes**: Product roadmap alignment, cross-team dependency resolution, escalated issues

**L20 (Portfolio Level)**
- **Purpose**: Leadership alignment across products, strategic decisions
- **Cadence**: Weekly
- **Duration**: 105 minutes
- **Participants**: Engineering Director, Product Director, Principal Engineer, Senior Architect, EMs, PMs, Staff Engineers
- **Outcomes**: Portfolio-wide alignment, strategic direction, resource allocation decisions

### 2. Documentation Artifacts

#### Architecture Decision Records (ADRs)
- **Location**: `principles/adrs/`
- **Purpose**: Document architectural decisions with business context and rationale
- **When to create**: Major architectural choices affecting system design, technology selection, or cross-cutting concerns
- **Impact on timeline**: Can indicate Low/Medium/High impact on roadmap
- **Links to**: Design Reviews, Jira Epics, LX Documents

#### Design Reviews
- **Location**: `principles/design-reviews/`
- **Purpose**: Technical implementation planning with solution comparison
- **When to create**: Before implementing significant features or changes
- **Structure**:
  - Requirements (Product Gathering)
  - Solutions Proposal (multiple options with pros/cons)
  - Decision (recommended approach)
  - Technical Implementation (breakdown, metrics, dependencies)
- **Impact Assessment**: Expected, Low, Medium, High, or None
- **Links to**: ADRs (references decisions), Jira Stories, LX Documents

#### LX Documents (Living Experience)
- **Location**: `process/lx/`
- **Purpose**: Weekly progress tracking document shared across team/product/portfolio
- **Cadence**: Updated weekly, archived for historical tracking
- **Structure**:
  - Epic Status (with Traffic Light: Green/Yellow/Red)
  - Last Week: Work completed
  - This Week: Planned work
  - Open Decisions: Questions needing input from product/business/leadership
  - Blockers: Items requiring escalation
- **Sync**: Updates Confluence weekly, feeds into Jira epic progress
- **Multi-repo**: When multiple microservices use LXI, they link through shared weekly LX document

#### Progress Tracking
- **Location**: `product/progress/`
- **Purpose**: Daily standup updates, sprint progress
- **Automation**: Pulls from Git commits, Jira, Confluence to generate composite view
- **Feeds into**: LX Documents (weekly rollup)

### 3. Information Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    REPOSITORY (Source of Truth)              │
│                                                              │
│  ┌──────────┐   ┌────────────┐   ┌──────────┐              │
│  │   ADRs   │──▶│   Design   │──▶│    LX    │──────────┐   │
│  │          │   │  Reviews   │   │ Document │          │   │
│  └──────────┘   └────────────┘   └──────────┘          │   │
│       │               │                 │               │   │
│       │               │                 │               │   │
│       └───────┬───────┴─────────────────┘               │   │
│               │                                         │   │
│      ┌────────▼─────────┐                              │   │
│      │  Progress Track  │                              │   │
│      │   (Daily)        │                              │   │
│      └────────┬─────────┘                              │   │
│               │                                         │   │
└───────────────┼─────────────────────────────────────────┼───┘
                │                                         │
                │ Syncs                                   │ Updates
                │                                         │
        ┌───────▼────────┐                        ┌──────▼──────┐
        │      Jira      │                        │  Confluence │
        │    (Epics,     │                        │ (LX Weekly  │
        │    Stories)    │                        │   Archive)  │
        └────────────────┘                        └─────────────┘
```

### 4. Traffic Light System

All work items (initiatives, epics, stories) use a traffic light system:

- **🟢 Green**: On track, no discussion needed
- **🟡 Yellow**: At risk or requiring attention
- **🔴 Red**: Blocked or critical (requires immediate resolution)

**Escalation Path**:
1. **L5 Level**: Yellow and Red items discussed in detail
2. **L10 Level**: Red items from L5 escalated, remedial action plans created
3. **L20 Level**: Red items from L10 escalated, strategic decisions made

### 5. Work Lifecycle

```
1. PLANNING
   ├─ New work identified (business need, technical debt, etc.)
   ├─ Decision: ADR needed? Design Review needed?
   └─ Epic created in Jira, linked to LX Document

2. DESIGN
   ├─ Architecture Decision Record (if architectural impact)
   ├─ Design Review (solution exploration with pros/cons)
   └─ Decision captured, Implementation plan in Design Review

3. EXECUTION
   ├─ Work begins, tracked in Progress (daily)
   ├─ Status updated: Green/Yellow/Red
   ├─ Blockers captured and escalated (L5 → L10 → L20)
   └─ Code commits, MR/PR process

4. DOCUMENTATION UPDATE
   ├─ Progress rolls up into LX Document weekly
   ├─ Takeaways from implementation cascade back into context
   ├─ Analysis updated (with dates) to reflect learnings
   └─ LX Document syncs to Confluence, Jira epics updated

5. RETROSPECTIVE
   ├─ Lessons learned captured in context/analysis
   ├─ Process improvements added to improvements/
   └─ Dated analysis ensures freshness
```

### 6. Multi-Repository Linking

When multiple microservices owned by a team use LXI, they coordinate through shared artifacts.

**Example Scenario**: User Service and Analytics Service both need to implement user event tracking.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          TEAM-123: User Event Tracking Epic              │
│                          (Shared Jira Epic across repos)                 │
└────────────────┬──────────────────────────────────────┬─────────────────┘
                 │                                      │
                 │                                      │
    ┌────────────▼─────────────┐         ┌─────────────▼────────────┐
    │  Repository A            │         │  Repository B            │
    │  (user-service)          │         │  (analytics-service)     │
    │                          │         │                          │
    │  📄 LX Doc (Week 10/28)  │         │  📄 LX Doc (Week 10/28)  │
    │  ├─ Epic TEAM-123: 🟡    │         │  ├─ Epic TEAM-123: 🟢    │
    │  ├─ Last Week:           │         │  ├─ Last Week:           │
    │  │  ✅ Event schema       │         │  │  ✅ Kafka consumer    │
    │  │     defined            │         │  │     implemented       │
    │  └─ Blocker:             │         │  └─ Waiting on:          │
    │     ⚠️ Need analytics     │         │     ✅ Got schema from   │
    │        team input         │◀────────┼───────user-service      │
    │                          │         │                          │
    │  📋 ADR-0042             │         │  📋 References           │
    │  "Event Schema Design"   │─────────▶│  ADR-0042 from Repo A  │
    │                          │         │                          │
    └──────────────┬───────────┘         └───────────┬──────────────┘
                   │                                 │
                   │                                 │
                   └────────────┬────────────────────┘
                                │
                                │ Both sync to
                                │
                   ┌────────────▼──────────────┐
                   │   Confluence             │
                   │                          │
                   │   📄 Weekly LX Report    │
                   │   Week of 2024-10-28     │
                   │                          │
                   │   Epic TEAM-123 Status:  │
                   │   ├─ User Service: 🟡    │
                   │   │   ⚠️ Waiting input    │
                   │   │                      │
                   │   └─ Analytics: 🟢       │
                   │       ✅ Consumer ready  │
                   │                          │
                   │   Action: Schedule sync  │
                   │           meeting        │
                   └──────────────────────────┘
```

**How It Works**:

1. **Shared Epic (TEAM-123)**: Both repos reference the same Jira epic
   - User Service tracks: "Implement event publishing"
   - Analytics Service tracks: "Implement event consumption"

2. **Cross-Reference LX Docs**: Each repo's weekly LX doc mentions the other
   ```markdown
   # user-service/process/lx/2024-10-28-weekly.md

   ### TEAM-123: User Event Tracking
   Status: 🟡 Yellow
   Blocker: Need schema approval from analytics-service team
   See: analytics-service repo for consumer implementation
   ```

3. **Shared ADRs**: Architecture decisions reference each other
   ```markdown
   # user-service ADR-0042
   Related: See analytics-service ADR-0015 for consumer implementation
   ```

4. **Unified Confluence View**: Both LX docs sync to same Confluence page
   - Product managers see complete picture
   - L10 meetings have full context
   - Dependencies visible across teams

**Key Linking Mechanisms**:

| Mechanism | How It Works | Example |
|-----------|--------------|---------|
| **Shared Jira Epic** | Same epic ID referenced in both repos' LX docs | TEAM-123 in both repos |
| **LX Cross-References** | Repos explicitly mention each other in weekly docs | "Waiting on analytics-service schema review" |
| **ADR Links** | ADRs link to decisions in other repos | "See user-service ADR-0042 for event schema" |
| **Confluence Sync** | Both repos sync to same Confluence page or space | Combined weekly report shows both teams |
| **Shared Design Review** | Cross-repo design review document (can live in either repo) | Joint meeting with both teams |

**When to Use Multi-Repo Linking**:
- ✅ Multiple microservices need coordinated changes
- ✅ Shared architecture decisions affect multiple repos
- ✅ Teams need visibility into each other's progress
- ✅ Dependencies exist between services

### 7. Context Management

```
context/
├─ analysis/        # Technical analysis (dated, grows stale)
│  └─ 2024-10-15-performance-bottleneck.md
├─ docs/           # Evergreen documentation
│  └─ api-conventions.md
└─ projects/       # Historical project breakdowns
   └─ 2024-q3-migration/
```

**Rules**:
- Analysis files must include dates in filename
- Stale analysis (>30 days without update) flagged for review
- Takeaways from completed projects cascade into context/docs

### 8. AI Agent Integration

LXI includes AI agent configurations to automate common tasks:

**Agent Profiles** (`agents/profiles/`):
- Voice and tone settings
- Context awareness rules

**Agent Perspectives** (`agents/perspectives/`):
- Engineer view
- QA view
- Product Manager view
- User view

**Agent Skills** (`agents/skills/`):
- `standup-update`: Pull work from GitLab/Jira/Confluence, generate composite standup
- `update-lx`: Generate weekly LX document from progress tracking
- `create-adr`: Interactive ADR creation with template
- `sync-external`: Sync repository state to Jira/Confluence

### 9. Key Principles from Reference Materials

From **Microservice Architecture Principles**:
- **High Cohesion, Low Coupling**: Each component (ADR, Design Review, LX Doc) serves a singular purpose
- **Business Capabilities**: Documentation organized around business domains
- **Decentralization**: Each repository maintains its own truth
- **Independent Scalability**: LXI scales from single developer to multi-team portfolios

From **LX Meeting Structure**:
- **Meaningful Meetings**: Purpose-driven with clear outcomes
- **Feedback Loops**: Meeting ratings (1-10) for continuous improvement
- **Escalation Paths**: Structured yellow/red item escalation prevents repeated discussions
- **Asynchronous First**: Replace meetings with documentation where possible

## Success Criteria

LXI is working well when:

1. ✅ The top-level README always reflects current state
2. ✅ External stakeholders can get project status from repository alone
3. ✅ ADRs and Design Reviews are referenced in code and documentation
4. ✅ LX Documents accurately sync with Jira/Confluence weekly
5. ✅ Blockers surface quickly and escalate appropriately
6. ✅ Analysis is fresh (dated within 30 days)
7. ✅ Multi-repo teams share coherent LX documents
8. ✅ AI agents can navigate and update the system autonomously
