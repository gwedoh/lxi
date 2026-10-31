# Design Reviews

This directory contains technical design documentation for significant features and implementations.

---

## What is a Design Review?

A **Design Review** is a technical planning document that:

- Explores multiple implementation approaches
- Evaluates trade-offs and estimates effort
- Documents the chosen solution
- Provides implementation roadmap
- Defines success metrics

Design Reviews are **more detailed and implementation-focused** than ADRs.

---

## When to Create a Design Review

Create a Design Review when:

✅ Implementing a significant feature (>1 week effort)
✅ Multiple implementation approaches exist
✅ Cross-team coordination needed
✅ Solution needs technical validation before work begins
✅ Implementation details need to be shared/reviewed
✅ Breaking down complex work into tasks

**Examples**:
- User authentication system
- Real-time notification feature
- Data export functionality
- API v2 migration
- Database schema redesign
- Third-party service integration

---

## Design Review Template

Create a new Design Review:

```bash
lxi create design-review "Feature Name"
```

This creates: `YYYY-MM-DD-feature-name.md` with today's date.

**Template structure**:
- **Requirements**: Product needs, user stories, success criteria
- **Solutions Proposal**: 2-3 options with pros/cons and effort estimates
- **Decision**: Recommended approach and justification
- **Technical Implementation**: Components, APIs, data models, testing
- **Success Metrics**: How to measure success
- **Links**: Related ADRs, Jira epics, other docs

---

## Naming Convention

Design Reviews use **date-based naming**:

```
2024-10-15-user-authentication.md
2024-11-01-realtime-notifications.md
2024-11-15-data-export-feature.md
```

**Why date-based?**
- Chronological ordering
- Indicates when design was created
- Easy to identify stale documents
- No numbering conflicts

---

## Design Review Statuses

| Status | Meaning | When to Use |
|--------|---------|-------------|
| **Draft** | Work in progress | Initial creation, gathering feedback |
| **In Review** | Under discussion | Ready for team/stakeholder review |
| **Approved** | Ready to implement | Decision made, implementation can start |
| **Implemented** | Work completed | Feature shipped, document serves as reference |
| **Abandoned** | Not pursued | Deprioritized or superseded by other work |

---

## Writing a Good Design Review

### DO ✅

- **Explore 2-3 options**: Show you evaluated alternatives
- **Include diagrams**: Architecture, sequence, data flow
- **Estimate effort**: Story points or time for each option
- **Define success metrics**: How to measure if it works
- **Break down tasks**: High-level implementation plan
- **Identify dependencies**: What blocks this? What does this block?
- **Plan for testing**: Unit, integration, E2E strategy
- **Update post-implementation**: Capture what actually happened

### DON'T ❌

- **Don't present only one solution**: Why is a review needed?
- **Don't skip effort estimation**: Helps with prioritization
- **Don't ignore edge cases**: What could go wrong?
- **Don't forget rollout plan**: Phased? Feature flag? Big bang?
- **Don't leave testing undefined**: How will you validate?
- **Don't forget to update**: Document learnings after shipping

---

## Example Structure

```markdown
# Design Review: Real-Time Notification System

**Date**: 2024-11-01
**Status**: Approved
**Owner**: Engineering Team
**Reviewers**: Staff Eng, PM, QA Lead

---

## Requirements

### User Stories
- As a user, I want to receive notifications in real-time
- As a user, I want to see notification history
- As an admin, I want to broadcast system messages

### Success Criteria
- Notifications delivered within 2 seconds
- Support 10,000 concurrent users
- 99.9% delivery success rate

### Out of Scope
- Push notifications (mobile apps)
- Email notifications
- SMS notifications

---

## Solutions Proposal

### Option 1: WebSockets
**Description**: Direct WebSocket connection from client to server

**Pros**:
- Real-time, bidirectional communication
- Low latency (<100ms)
- Standard browser support

**Cons**:
- Sticky sessions required (complicates load balancing)
- Connection management overhead
- Difficult to scale horizontally

**Effort**: 8 story points (~2 weeks)

---

### Option 2: Server-Sent Events (SSE)
**Description**: HTTP-based event streaming from server to client

**Pros**:
- Simpler than WebSockets (one-way)
- Works through proxies/firewalls
- Automatic reconnection

**Cons**:
- One-way only (client can't push)
- Browser connection limits (6 per domain)
- Less flexible than WebSockets

**Effort**: 5 story points (~1 week)

---

### Option 3: Long Polling
**Description**: Client repeatedly polls server for new notifications

**Pros**:
- Simple to implement
- Works everywhere (no special server support)
- Easy to scale

**Cons**:
- Higher latency (1-5 seconds)
- More HTTP overhead
- Not true real-time

**Effort**: 3 story points (~3 days)

---

## Decision

**Chosen**: Option 2 (Server-Sent Events)

**Rationale**:
- Meets latency requirement (<2s)
- Simpler than WebSockets, easier to maintain
- One-way communication sufficient for notifications
- No sticky sessions needed
- Good balance of effort vs functionality

**Trade-offs accepted**:
- Not sub-second real-time (acceptable for notifications)
- One-way only (can use regular HTTP POST for user actions)

---

## Technical Implementation

### Components

1. **NotificationService** (Backend)
   - Listens to notification events from message queue
   - Maintains active SSE connections
   - Broadcasts notifications to connected clients

2. **NotificationController** (API)
   - Endpoint: `GET /api/notifications/stream`
   - Returns SSE stream
   - Authenticates user, establishes connection

3. **NotificationClient** (Frontend)
   - EventSource API for SSE connection
   - Auto-reconnection logic
   - UI toast/banner for notifications

### API Contract

```
GET /api/notifications/stream
Headers:
  Authorization: Bearer <token>

Response:
  Content-Type: text/event-stream

  event: notification
  data: {"id":"123","type":"info","message":"New message","timestamp":"2024-11-01T10:00:00Z"}

  event: notification
  data: {"id":"124","type":"warning","message":"System maintenance","timestamp":"2024-11-01T10:05:00Z"}
```

### Data Model

```sql
CREATE TABLE notifications (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  type VARCHAR(20) NOT NULL, -- info, warning, error
  message TEXT NOT NULL,
  read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_unread
  ON notifications(user_id, read, created_at DESC);
```

### Dependencies

- **Message Queue** (Kafka/RabbitMQ) for event distribution
- **Redis** for tracking active SSE connections
- **ADR-0042** (Redis for caching) - reuse Redis cluster

### Testing Strategy

- **Unit Tests**: NotificationService, connection management
- **Integration Tests**: End-to-end notification delivery
- **Load Tests**: 10,000 concurrent connections
- **E2E Tests**: Browser-based notification reception

### Rollout Plan

1. **Week 1**: Backend implementation + unit tests
2. **Week 2**: Frontend integration + E2E tests
3. **Week 3**: Load testing + monitoring setup
4. **Week 4**: Phased rollout (10% → 50% → 100%)

---

## Success Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Delivery latency | <2 seconds | Time from event to client receipt |
| Success rate | >99.9% | Notifications sent vs delivered |
| Concurrent users | 10,000 | Max simultaneous SSE connections |
| Connection stability | <1% reconnect/hour | SSE reconnection rate |

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Browser connection limits | High | Use single SSE connection for all notifications |
| Server resource exhaustion | High | Implement connection pooling, rate limiting |
| Network interruptions | Medium | Auto-reconnect with exponential backoff |
| Stale connections | Medium | Server-side heartbeat, timeout after 5 min |

---

## Related Documents

- ADR-0042: Use Redis for Application Caching
- ADR-0089: Event-Driven Architecture
- Jira Epic: TEAM-200
- Product Spec: [Notifications Feature](https://link-to-spec)

---

## Post-Implementation Notes

_(Update after feature is shipped)_

**What went well**:
- SSE worked as expected, low complexity
- Load testing confirmed 10k concurrent connections

**What didn't go well**:
- Browser connection limits hit sooner than expected (safari)
- Required additional Redis tuning for connection tracking

**Lessons learned**:
- Test on all browsers early (Safari behaves differently)
- Monitor Redis memory usage closely with many connections

**Metrics achieved**:
- Latency: 1.2s average (better than 2s target)
- Success rate: 99.95%
- Concurrent users: Tested up to 15k successfully
```

---

## Design Review vs ADR

| Aspect | Design Review | ADR |
|--------|---------------|-----|
| **Focus** | Implementation details | Architectural decision |
| **Scope** | Single feature/component | System-wide or cross-cutting |
| **Detail Level** | High (APIs, data models, tasks) | Medium (options, trade-offs) |
| **Audience** | Engineering team | Broader stakeholders |
| **Timing** | Before implementation | When architectural choice needed |
| **Update Frequency** | Often (pre/post implementation) | Rarely (historical record) |

**Relationship**:
- ADRs inform Design Reviews (architectural constraints)
- Design Reviews may trigger ADRs (new architectural needs)
- Design Reviews reference relevant ADRs

---

## Review Process

1. **Author** creates Design Review in `Draft`
   ```bash
   lxi create design-review "Feature Name"
   ```

2. **Exploration**: Research options, create diagrams, estimate effort

3. **Share for Review**: Update status to `In Review`
   - Tag reviewers in PR
   - Schedule design review meeting
   - Async feedback via comments

4. **Discussion**: Design review meeting
   - Walk through options
   - Answer questions
   - Gather feedback

5. **Decision**: Choose approach, update document
   - Document decision and rationale
   - Update status to `Approved`

6. **Create Jira Epic/Stories**
   - Break down implementation
   - Link to Design Review

7. **Implementation**: Build the feature
   - Reference Design Review in code
   - Update status to `Implemented` when shipped

8. **Post-Implementation Update**
   - Add "Post-Implementation Notes"
   - Document learnings, actual metrics

---

## Maintenance

### Update After Implementation

Don't forget to update the Design Review after shipping:

```markdown
## Post-Implementation Notes

**Updated**: 2024-11-25

**What changed from original design**:
- Switched from SSE to WebSockets (browser issues)
- Added fallback to long polling for old browsers

**Actual effort**: 12 story points (vs 5 estimated)

**Metrics achieved**: [Paste actual metrics here]
```

### Archive Old Design Reviews

Move completed reviews older than 6 months:

```bash
mkdir -p principles/design-reviews/archive/2024
mv principles/design-reviews/2024-*.md principles/design-reviews/archive/2024/
```

### Check Freshness

```bash
lxi check freshness
```

Identifies Design Reviews over 30 days old that may need updating.

---

## Tools & Commands

### Create New Design Review

```bash
lxi create design-review "User Authentication"
```

### List All Design Reviews

```bash
ls -la principles/design-reviews/*.md
```

### Search Design Reviews

```bash
grep -r "authentication" principles/design-reviews/
```

### Validate Links

```bash
lxi validate
```

---

## Further Reading

- [principles/README.md](../README.md) - Architecture principles
- [process/README.md](../../process/README.md) - Workflows
- [Design Docs at Google](https://www.industrialempathy.com/posts/design-docs-at-google/) - Design doc best practices

---

_This directory follows the LXI framework. See [ARCHITECTURE.md](../../ARCHITECTURE.md) for system overview._
