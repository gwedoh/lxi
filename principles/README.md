# Principles & Architecture

This directory contains architecture principles, decisions, and technical design documentation for the system.

---

## Overview

The `principles/` directory is where we document **how** and **why** we build our systems. It captures:

- **Architecture Decisions** (ADRs): Key architectural choices and their rationale
- **Design Reviews**: Technical implementation planning and solution evaluation
- **Architecture Principles**: Guidelines and best practices for system design

---

## Architecture Principles

### 1. Work from Files, Not Memories

**Principle**: All architectural context, decisions, and rationale must be documented in the repository.

**Why**:
- Team members change, memories fade
- New engineers need context to understand "why"
- Decisions made in meetings are lost without documentation

**How**:
- Create ADRs for architectural decisions
- Document design alternatives in Design Reviews
- Reference decisions in code comments
- Link PRs/MRs to ADRs and Design Reviews

**Example**:
```java
// Use PostgreSQL for time-series data (see ADR-0015)
// TimescaleDB extension provides efficient partitioning
```

---

### 2. Document Decisions, Not Just Outcomes

**Principle**: Capture the **context** and **alternatives considered**, not just the final decision.

**Why**:
- Future engineers need to understand trade-offs
- Context helps when re-evaluating decisions
- Alternatives prevent revisiting dismissed options

**How**:
- ADRs include "Options Considered" section
- Design Reviews compare 2-3 solution approaches
- Document assumptions and constraints
- Note what was ruled out and why

**Anti-pattern**:
```markdown
# Bad ADR
We will use Redis for caching.
```

**Good pattern**:
```markdown
# Good ADR
## Context
We need caching to reduce database load. Current latency is 200ms P95.

## Options Considered
1. Redis - In-memory, fast, limited by RAM
2. Memcached - Simpler, no persistence
3. Application-level cache - No network hop, harder to invalidate

## Decision
Redis, because we need persistence for cache warmup and TTL management.

## Consequences
- Need to provision Redis cluster
- Cache invalidation strategy required
- Adds dependency to infrastructure
```

---

### 3. Analysis Grows Stale - Date Everything

**Principle**: All architectural analysis and decisions MUST include dates. Documents older than 30 days should be reviewed for accuracy.

**Why**:
- Systems evolve, old analysis becomes misleading
- Technology landscape changes
- Team understanding improves over time

**How**:
- ADRs include `Date: YYYY-MM-DD` in frontmatter
- Design Reviews use filename format: `YYYY-MM-DD-title.md`
- Check freshness: `lxi check freshness`
- Update or supersede stale documents

**Freshness Guidelines**:
| Document Type | Stale After | Action |
|---------------|-------------|--------|
| ADRs | Never (historical record) | Supersede with new ADR if decision changes |
| Design Reviews | 30 days | Update with implementation learnings or mark as implemented |
| Architecture diagrams | 60 days | Regenerate from current state |

---

### 4. Favor Boring Technology

**Principle**: Choose well-established, proven technologies over cutting-edge or trendy options unless there's compelling justification.

**Why**:
- Boring tech has known failure modes
- Community support and documentation mature
- Easier to hire for
- Fewer surprises in production

**What is "boring"**:
- Battle-tested (5+ years in production use)
- Large community (Stack Overflow answers, GitHub stars)
- Clear upgrade path
- Known performance characteristics

**When to use non-boring tech**:
- Boring tech fundamentally cannot solve the problem
- Clear competitive advantage from new tech
- Team has deep expertise
- Risk is contained (can fail without cascading)

**Document in ADR**: If choosing non-boring tech, explicitly justify why boring alternatives don't work.

---

### 5. Make Reversible Decisions Quickly

**Principle**: Distinguish between **one-way doors** (hard to reverse) and **two-way doors** (easy to reverse). Move fast on two-way doors.

**One-way doors** (require ADR):
- Database technology choice
- API contracts with external consumers
- Data model/schema design
- Service boundaries in microservices
- Authentication/authorization architecture

**Two-way doors** (Design Review sufficient):
- Internal API design (within service)
- Library/framework choice (if not exposed externally)
- Caching strategy
- Logging/monitoring approach
- Internal tool selection

**Process**:
- One-way doors → Full ADR with stakeholder review
- Two-way doors → Design Review, move quickly

---

### 6. Design for Failure

**Principle**: Assume everything will fail. Design systems to degrade gracefully and recover automatically.

**Guidelines**:
- **Timeouts**: Every network call has a timeout
- **Retries**: Use exponential backoff with jitter
- **Circuit breakers**: Prevent cascading failures
- **Fallbacks**: Degrade functionality, don't fail entirely
- **Bulkheads**: Isolate failure domains

**Document in Design Reviews**:
- What happens when this component fails?
- How does the system degrade?
- What are the recovery mechanisms?
- What are the monitoring/alerting requirements?

---

### 7. Optimize for Change

**Principle**: Systems will change. Design for evolvability over premature optimization.

**Guidelines**:
- **Loose coupling**: Services/modules depend on interfaces, not implementations
- **High cohesion**: Related functionality grouped together
- **Encapsulation**: Hide implementation details
- **Versioning**: APIs versioned from day one
- **Feature flags**: New behavior toggleable

**Code example**:
```java
// Bad: Tight coupling
public class OrderService {
    private MySQLDatabase db = new MySQLDatabase();
    public void saveOrder(Order order) {
        db.execute("INSERT INTO orders...");
    }
}

// Good: Loose coupling via interface
public class OrderService {
    private final OrderRepository repository;

    public OrderService(OrderRepository repository) {
        this.repository = repository;
    }

    public void saveOrder(Order order) {
        repository.save(order);
    }
}
```

---

### 8. Security by Default

**Principle**: Security is not a feature to add later. It's a fundamental design constraint.

**Guidelines**:
- **Authentication**: Required by default, opt-out needs justification
- **Authorization**: Principle of least privilege
- **Encryption**: TLS for transport, encryption at rest for sensitive data
- **Input validation**: Validate all external input
- **Secrets management**: Never commit secrets, use vault/secrets manager

**ADR Requirement**: Any decision that weakens security posture requires explicit ADR with risk assessment.

---

## ADRs vs Design Reviews

### When to Create an ADR

**ADR (Architecture Decision Record)** captures **architectural decisions** that affect system structure, technology choices, or cross-cutting concerns.

**Create an ADR when**:
- Choosing database technology
- Selecting architectural pattern (microservices, monolith, etc.)
- Deciding on authentication/authorization approach
- Making technology/framework choices that affect multiple teams
- Introducing new infrastructure components
- Changing API contracts or data models
- Making decisions with long-term impact (hard to reverse)

**ADR Structure**:
```markdown
# ADR-XXXX: [Title]

Date: YYYY-MM-DD
Status: Proposed | Accepted | Deprecated | Superseded

## Context and Problem Statement
What is the issue we're facing? What constraints exist?

## Options Considered
1. Option A - pros/cons
2. Option B - pros/cons
3. Option C - pros/cons

## Decision
Which option did we choose and why?

## Consequences
Positive: What we gain
Negative: What we lose or must manage
Risks: What could go wrong
```

**Examples**:
- ADR-0001: Choose PostgreSQL over MongoDB for primary datastore
- ADR-0015: Use TimescaleDB for time-series analytics data
- ADR-0023: Adopt event-driven architecture for cross-service communication

---

### When to Create a Design Review

**Design Review** documents **technical implementation** planning. It's more detailed and engineering-centric than an ADR.

**Create a Design Review when**:
- Implementing a significant feature (>1 week of work)
- Multiple implementation approaches exist
- Cross-team coordination needed
- Solution needs technical validation
- Implementation details need to be shared/reviewed

**Design Review Structure**:
```markdown
# Design Review: [Feature Name]

Date: YYYY-MM-DD
Status: Draft | In Review | Approved | Implemented

## Requirements (Product Gathering)
What are we building? Why? For whom?

## Solutions Proposal
### Option 1: [Name]
- Description
- Pros
- Cons
- Effort estimate

### Option 2: [Name]
- Description
- Pros
- Cons
- Effort estimate

## Decision
Recommended approach and justification

## Technical Implementation
- Components to build/modify
- API contracts
- Data models
- Dependencies
- Testing strategy
- Rollout plan

## Success Metrics
How do we know it works?

## Links
- Related ADRs
- Jira Epic
- Design docs
```

**Examples**:
- Design Review: User Authentication Flow (2024-10-15)
- Design Review: Real-time Notification System (2024-11-01)
- Design Review: Data Export Feature (2024-11-20)

---

### Relationship Between ADRs and Design Reviews

```
┌─────────────────────────────────────────────┐
│         ADR (Architecture Decision)         │
│                                             │
│  "We will use event-driven architecture"   │
│  - Technology: Kafka                        │
│  - Pattern: Event sourcing                  │
│  - Why: Decoupling, scalability             │
└──────────────────┬──────────────────────────┘
                   │
                   │ References
                   │
         ┌─────────┴──────────┐
         │                    │
┌────────▼────────┐  ┌────────▼────────┐
│ Design Review 1 │  │ Design Review 2 │
│                 │  │                 │
│ User Events     │  │ Order Events    │
│ - Schema        │  │ - Schema        │
│ - Producers     │  │ - Consumers     │
│ - Consumers     │  │ - Retry logic   │
└─────────────────┘  └─────────────────┘
```

**Guidelines**:
1. **ADR first** if architectural decision needed
2. **Design Review** references ADR for implementation
3. **Design Review** can trigger new ADR if architecture impact discovered
4. **Not all Design Reviews need ADRs** (implementation-only decisions)
5. **All ADRs should link to** implementing Design Reviews or Jira Epics

---

## Best Practices

### Writing Good ADRs

**DO**:
✅ Keep it concise (1-2 pages)
✅ Write for future engineers who lack context
✅ Document alternatives considered
✅ Explain trade-offs explicitly
✅ Link to related ADRs
✅ Update status when superseded
✅ Date the decision

**DON'T**:
❌ Just state the decision without context
❌ Assume everyone knows the background
❌ Skip documenting alternatives
❌ Write a novel (be concise)
❌ Leave it in "Proposed" status forever
❌ Delete old ADRs (supersede instead)

---

### Writing Good Design Reviews

**DO**:
✅ Explore 2-3 solution options
✅ Include concrete examples/diagrams
✅ Document success metrics
✅ Break down implementation into tasks
✅ Identify dependencies and blockers
✅ Update after implementation with learnings
✅ Link to related ADRs and Jira

**DON'T**:
❌ Present only one solution (why review?)
❌ Skip effort estimation
❌ Leave testing strategy undefined
❌ Forget to update after implementation
❌ Write pseudocode (high-level only)

---

### Review Process

#### ADR Review Process

1. **Author** creates ADR in `Proposed` status
2. **Stakeholders** review (EM, PM, Staff Eng, Architect)
3. **Discussion** in design review meeting or async comments
4. **Decision** made by appropriate level (L10 or L20)
5. **Status** updated to `Accepted`
6. **Implementation** begins with reference to ADR
7. **Learnings** captured in ADR "Update" section if needed

**Approval Required From**:
- Engineering Manager (team impact)
- Staff Engineer / Architect (technical soundness)
- Product Manager (business alignment)
- Security/Compliance (if applicable)

---

#### Design Review Process

1. **Author** creates Design Review in `Draft` status
2. **Engineering team** reviews technical approach
3. **Discussion** in design review meeting
4. **PM/PO** validates requirements alignment
5. **Status** updated to `Approved`
6. **Epic/Stories** created in Jira
7. **Implementation** begins
8. **Post-implementation** update with learnings

**Approval Required From**:
- Engineering Lead (technical feasibility)
- Product Owner (requirements met)
- QA Lead (testability)

---

### Linking Documentation

**In Code**:
```java
/**
 * Implements event-driven user notifications.
 *
 * See:
 * - ADR-0023: Event-driven architecture
 * - Design Review: User Notification System (2024-10-15)
 * - Jira Epic: TEAM-100
 */
public class NotificationService {
    // ...
}
```

**In PRs/MRs**:
```markdown
## Description
Implements user notification system per design review.

## References
- Design Review: [User Notifications](../principles/design-reviews/2024-10-15-user-notifications.md)
- ADR: [ADR-0023 Event Architecture](../principles/adrs/0023-event-architecture.md)
- Jira: TEAM-100
```

**In ADRs**:
```markdown
## Related Documents
- Supersedes: ADR-0010 (Synchronous API calls)
- Implemented by: Design Review 2024-10-15
- Jira Epic: TEAM-100
```

---

## Templates

### Create New ADR
```bash
lxi create adr "Database Selection"
```

This creates: `principles/adrs/XXXX-database-selection.md` from template

### Create New Design Review
```bash
lxi create design-review "User Authentication"
```

This creates: `principles/design-reviews/YYYY-MM-DD-user-authentication.md` from template

---

## Directory Structure

```
principles/
├─ README.md (this file)
│
├─ adrs/
│  ├─ adr-template.md
│  ├─ 0001-database-choice.md
│  ├─ 0002-microservices-architecture.md
│  └─ ...
│
└─ design-reviews/
   ├─ design-review-template.md
   ├─ 2024-10-15-user-auth.md
   ├─ 2024-11-01-realtime-notifications.md
   └─ ...
```

---

## Maintenance

### Check for Stale Documents
```bash
lxi check freshness
```

### Validate Cross-References
```bash
lxi validate
```

### Archive Old Design Reviews
Design Reviews older than 6 months can be archived:
```bash
mkdir -p principles/design-reviews/archive/YYYY
mv principles/design-reviews/YYYY-*.md principles/design-reviews/archive/YYYY/
```

---

## Common Questions

**Q: Do I need an ADR for every decision?**
A: No. Only for architectural decisions with long-term impact. Use the decision tree in [process/README.md](../process/README.md).

**Q: Can I update an ADR after it's accepted?**
A: Yes, add an "Update" section with date. If decision changes significantly, create new ADR and mark old one as "Superseded".

**Q: Should I delete old ADRs when architecture changes?**
A: Never delete. Mark as "Superseded" and link to new ADR. Historical record is valuable.

**Q: What if the Design Review was wrong?**
A: Update it with "Post-Implementation Notes" section. Capture learnings for next time.

**Q: Do Design Reviews need approval?**
A: Yes, from Engineering Lead and Product Owner minimum. Complex changes may need additional stakeholders.

**Q: How long should an ADR review take?**
A: Aim for 3-5 days. Longer for major decisions affecting multiple teams.

---

## Related Documentation

- [ARCHITECTURE.md](../ARCHITECTURE.md) - System architecture overview
- [process/README.md](../process/README.md) - Workflows and decision trees
- [commands/README.md](../commands/README.md) - LXI command reference

---

_Last Updated: 2024-10-27_
