# Architecture Decision Records (ADRs)

This directory contains Architecture Decision Records documenting significant architectural decisions made for this system.

---

## What is an ADR?

An **Architecture Decision Record** (ADR) captures an architectural decision along with its context and consequences. It answers:

- **What** decision was made?
- **Why** was this decision necessary?
- **What alternatives** were considered?
- **What are the consequences** (positive and negative)?

---

## When to Create an ADR

Create an ADR for decisions that:

✅ Affect system structure or architecture
✅ Involve technology or framework choices
✅ Impact multiple teams or services
✅ Are difficult or expensive to reverse (one-way doors)
✅ Have long-term implications
✅ Introduce new patterns or practices

**Examples**:
- Database technology selection (PostgreSQL vs MongoDB)
- Architectural pattern adoption (microservices vs monolith)
- Authentication/authorization strategy
- API versioning approach
- Event-driven vs synchronous communication
- Infrastructure choices (AWS vs GCP, Kubernetes vs serverless)

---

## ADR Template

Use the template to create new ADRs:

```bash
lxi create adr "Your Decision Title"
```

This will create a new file: `XXXX-your-decision-title.md` with the next sequential number.

**Template structure**:
- **Title**: Short, descriptive (e.g., "Use PostgreSQL for Primary Datastore")
- **Date**: When the decision was made
- **Status**: Proposed, Accepted, Deprecated, Superseded
- **Context**: Background, constraints, problem statement
- **Options Considered**: 2-3 alternatives with pros/cons
- **Decision**: What was chosen and why
- **Consequences**: Positive and negative outcomes, risks

---

## ADR Statuses

| Status | Meaning | When to Use |
|--------|---------|-------------|
| **Proposed** | Under discussion | Initial creation, pending approval |
| **Accepted** | Decision finalized | After stakeholder approval, ready to implement |
| **Deprecated** | No longer recommended | Still in use but discouraged for new work |
| **Superseded** | Replaced by newer ADR | Architecture evolved, new ADR created |

---

## Numbering Scheme

ADRs use sequential 4-digit numbering:

```
0001-first-decision.md
0002-second-decision.md
0003-third-decision.md
...
```

**Why sequential?**
- Provides chronological order
- Easy to reference in code: "see ADR-0023"
- No naming conflicts

---

## Writing a Good ADR

### DO ✅

- **Keep it concise**: 1-2 pages is ideal
- **Write for future engineers**: Assume they lack context
- **Document alternatives**: Show what was considered and why rejected
- **Explain trade-offs**: Be honest about consequences
- **Date the decision**: Context changes over time
- **Link related docs**: Design Reviews, Jira epics, other ADRs
- **Update status**: Move from Proposed → Accepted when finalized

### DON'T ❌

- **Don't skip context**: Future you won't remember
- **Don't only show one option**: Why wasn't a decision obvious?
- **Don't assume knowledge**: Explain acronyms, technologies
- **Don't write a novel**: Be thorough but concise
- **Don't delete old ADRs**: Supersede them instead
- **Don't leave in limbo**: Close the loop (Accepted or Rejected)

---

## Example: Good vs Bad ADR

### ❌ Bad ADR

```markdown
# ADR-0042: Use Redis

We will use Redis for caching.

Status: Accepted
```

**Problems**:
- No context (why do we need caching?)
- No alternatives considered
- No consequences documented
- No date

---

### ✅ Good ADR

```markdown
# ADR-0042: Use Redis for Application Caching

**Date**: 2024-10-15
**Status**: Accepted

## Context and Problem Statement

Our API response times have degraded to 200ms P95 due to repeated database queries for frequently accessed data. We need a caching layer to improve performance.

**Constraints**:
- Must reduce latency to <50ms P95
- Budget: $500/month
- Team familiar with Redis and Memcached

## Options Considered

### Option 1: Redis
**Pros**:
- Persistence for cache warmup after restart
- Rich data structures (lists, sets, sorted sets)
- TTL support built-in
- Strong community and documentation

**Cons**:
- Higher memory usage than Memcached
- More complex to configure
- Slightly higher cost

### Option 2: Memcached
**Pros**:
- Simpler, less overhead
- Lower memory footprint
- Faster for simple key-value operations

**Cons**:
- No persistence (cold start problem)
- Limited data structures
- Less flexible TTL management

### Option 3: Application-level cache (in-memory)
**Pros**:
- No network latency
- No additional infrastructure cost
- Simpler deployment

**Cons**:
- Limited to single instance memory
- Invalidation complexity across instances
- Data not shared across services

## Decision

**Chosen**: Redis

**Rationale**:
- Persistence is critical for cache warmup during deployments
- Rich data structures support future use cases (leaderboards, rate limiting)
- Team already has Redis expertise
- TTL management simplifies cache invalidation strategy

## Consequences

### Positive
- Estimated latency reduction to 30ms P95
- Cache survives restarts (no cold start)
- Enables future features (pub/sub, sorted sets)

### Negative
- Additional infrastructure to maintain
- Redis cluster costs ~$400/month
- Requires cache invalidation strategy

### Risks
- Cache stampede during invalidation (mitigation: use Redis locks)
- Memory limits (mitigation: set eviction policy)
- Single point of failure (mitigation: Redis Sentinel for HA)

## Related Documents

- Design Review: [Caching Strategy](../../principles/design-reviews/2024-10-10-caching.md)
- Jira Epic: TEAM-100 (Performance Improvements)
- Implementation: Planned for Sprint 23
```

---

## Referencing ADRs

### In Code

```java
/**
 * Redis-backed cache for user profiles.
 *
 * See ADR-0042: Use Redis for Application Caching
 * - TTL: 1 hour
 * - Eviction: LRU
 */
public class UserProfileCache {
    // ...
}
```

### In Design Reviews

```markdown
## Architecture Decisions

This design follows ADR-0042 (Redis for caching) and introduces
a new caching layer for user profile data.
```

### In Pull Requests

```markdown
Implements caching layer per ADR-0042.

Related:
- ADR-0042: Use Redis for Application Caching
- Jira: TEAM-100
```

---

## Superseding ADRs

When architecture evolves, **don't delete** old ADRs. Create a new one and mark the old one as superseded.

### Example: Superseding an ADR

**Old ADR** (`0015-use-rest-apis.md`):
```markdown
# ADR-0015: Use REST APIs for Inter-Service Communication

**Date**: 2023-05-20
**Status**: Superseded by ADR-0089

[Original content...]

---

## Update: 2024-10-15

This ADR has been superseded by ADR-0089 which adopts event-driven
architecture for better decoupling and scalability.
```

**New ADR** (`0089-adopt-event-driven-architecture.md`):
```markdown
# ADR-0089: Adopt Event-Driven Architecture

**Date**: 2024-10-15
**Status**: Accepted

## Context

Our microservices have become tightly coupled via synchronous REST calls,
leading to cascading failures and increased latency.

**Supersedes**: ADR-0015 (REST APIs)

[Rest of ADR...]
```

---

## Review Process

1. **Author** creates ADR in `Proposed` status
   ```bash
   lxi create adr "Your Decision"
   ```

2. **Draft** and share with stakeholders
   - Engineering Manager
   - Staff Engineer / Architect
   - Product Manager (for business impact)
   - Security/Compliance (if applicable)

3. **Discussion** via:
   - Comments in the ADR file
   - Design review meeting
   - Async on Slack/Teams

4. **Decision** at appropriate level:
   - Team-level: Engineering Lead decides
   - Product-level: L10 meeting decides
   - Portfolio-level: L20 meeting decides

5. **Update status** to `Accepted`
   - Commit and push to repository
   - Link to implementation (Design Review, Jira Epic)

6. **Implementation** begins
   - Reference ADR in code
   - Track progress in LX documents

7. **Post-implementation** review (optional)
   - Add "Update" section with learnings
   - Document unexpected consequences

---

## Maintenance

### Check for Stale References

```bash
lxi validate
```

Ensures all links to other documents are valid.

### Archive (Don't Delete)

Never delete ADRs. They are historical records. If no longer relevant:

1. Mark status as `Superseded` or `Deprecated`
2. Link to replacement ADR (if applicable)
3. Keep the file in place

---

## Tools & Commands

### Create New ADR

```bash
lxi create adr "Database Selection"
```

### List All ADRs

```bash
ls -la principles/adrs/*.md
```

### Search ADRs

```bash
grep -r "PostgreSQL" principles/adrs/
```

### Validate ADR Links

```bash
lxi validate
```

---

## Further Reading

- [ADR GitHub Organization](https://adr.github.io/) - ADR best practices and tools
- [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions) - Michael Nygard's original article
- [principles/README.md](../README.md) - Architecture principles and guidelines

---

_This directory follows the LXI framework. See [ARCHITECTURE.md](../../ARCHITECTURE.md) for system overview._
