# Pull Request

## Description

<!-- Provide a brief description of the changes in this PR -->

## Plan Impact

**Impact on Roadmap/Deliverables**: <!-- Select ONE and delete the others -->
- [ ] **Expected** - This change is planned and on schedule
- [ ] **Low** - Minor deviation from plan (within tolerance, no stakeholder communication needed)
- [ ] **Medium** - Notable impact requiring PM awareness and potential timeline adjustment
- [ ] **High** - Significant change requiring replanning and stakeholder communication

**Impact Details**:
<!-- Explain how this PR impacts current roadmap, timeline, or deliverables -->
<!-- Examples:
- Expected: "Completing TEAM-123 as planned in this week's LX document"
- Low: "Bug fix added 1 day to sprint, still on track for milestone"
- Medium: "Feature scope expanded, pushing epic completion by 1 week"
- High: "Critical blocker found, requires architectural change and 2-sprint delay"
-->

---

### 🚨 Required if Impact is Low/Medium/High

If this PR has **Low**, **Medium**, or **High** impact, you **MUST** update product diagrams to reflect reality:

- [ ] Updated `product/roadmap.mmd` with new timeline
- [ ] Updated `product/outcomes.mmd` with revised OKR progress
- [ ] Updated `product/epic-dependencies.mmd` if dependencies changed
- [ ] Regenerated diagram images (run `mmdc` or `lxi sync all`)
- [ ] Updated this week's LX document with impact explanation
- [ ] Notified PM/stakeholders of impact

**Why?** Product diagrams are the source of truth for stakeholders. If reality changes, diagrams must change.

---

## Related Documents

<!-- Link all related LXI documents -->

**Design Review**: <!-- Link to design review that planned this work -->
- [ ] [Design Review Name](link to principles/design-reviews/YYYY-MM-DD-name.md)

**ADR** (if applicable): <!-- Link to architecture decision record -->
- [ ] [ADR-NNNN](link to principles/adrs/NNNN-name.md)

**Jira**:
- [ ] Epic: [TEAM-XXX](link)
- [ ] Story: [TEAM-YYY](link)

**LX Document**:
- [ ] Week: [YYYY-MM-DD](link to process/lx/YYYY-MM-DD-weekly.md)

---

## Changes Made

<!-- Detailed list of changes -->

-
-
-

---

## Testing

<!-- How was this tested? -->

**Test Plan**:
- [ ] Unit tests added/updated
- [ ] Integration tests passing
- [ ] Manual testing completed
- [ ] Regression testing done

**Test Coverage**:
- Before: <!-- X% -->
- After: <!-- Y% -->

**Test Evidence**:
<!-- Screenshots, test output, or links to test results -->

---

## Deployment Notes

**Database Migrations**: <!-- Yes/No, if yes describe -->

**Configuration Changes**: <!-- Any new env vars, config files, etc. -->

**Rollback Plan**: <!-- How to rollback if this causes issues -->

**Deployment Order**: <!-- Any specific order needed for multi-service deployments -->

---

## Checklist

### Code Quality
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] No unnecessary console logs or debug code
- [ ] No secrets or credentials in code

### Documentation
- [ ] Code comments updated
- [ ] README updated (if public API changed)
- [ ] Design Review updated (if implementation diverged)
- [ ] ADR created/updated (if architectural change)

### References
- [ ] Commit messages reference Jira story (e.g., "TEAM-123: Description")
- [ ] PR references Design Review and/or ADR
- [ ] Code comments reference ADR decisions (if applicable)

### LXI Sync
- [ ] Daily standup updated with this work
- [ ] LX Document updated (if noteworthy progress)
- [ ] **Product diagrams updated** (if Impact is Low/Medium/High)

### Security
- [ ] No sensitive data exposed
- [ ] Input validation added
- [ ] Security implications considered
- [ ] Dependencies checked for vulnerabilities

---

## Reviewer Notes

<!-- Any specific areas you want reviewers to focus on? -->

---

## Screenshots / Videos

<!-- If UI changes, provide before/after screenshots or demo videos -->

---

## Breaking Changes

<!-- Does this PR introduce breaking changes? If yes, describe migration path -->

- [ ] No breaking changes
- [ ] Breaking changes (describe below)

<!-- If breaking changes:
**What breaks**:
**Migration path**:
**Affected users/systems**:
-->

---

## Additional Context

<!-- Any other context, links, or information reviewers should know -->

---

_This PR template follows the LXI framework. See [process/README.md](../process/README.md) for workflows._
