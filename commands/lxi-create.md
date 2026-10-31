# lxi create

Create new documentation artifacts from templates.

## Usage

```bash
lxi create <type> [name]
```

## Commands

### lxi create adr

Create a new Architecture Decision Record (ADR).

**Usage:**
```bash
lxi create adr [topic]
```

**Arguments:**
- `topic` (optional): The topic/title of the ADR. If not provided, will prompt interactively.

**Examples:**
```bash
lxi create adr "Database Selection"
lxi create adr "Event Streaming Architecture"
lxi create adr  # Interactive mode
```

**What it does:**
1. Finds the next sequential ADR number (e.g., 0001, 0002, ...)
2. Creates a new ADR file from template: `principles/adrs/XXXX-topic.md`
3. Sets status to "Proposed"
4. Sets date to today
5. Prompts for next steps to fill in the ADR

**Related:**
- Template: `principles/adrs/adr-template.md`
- Skill: `agents/skills/create-adr.sh`

---

### lxi create design-review

Create a new Design Review document.

**Usage:**
```bash
lxi create design-review [feature]
```

**Arguments:**
- `feature` (optional): The feature/initiative name. If not provided, will prompt interactively.

**Examples:**
```bash
lxi create design-review "User Authentication"
lxi create design-review "Real-time Notifications"
lxi create design-review  # Interactive mode
```

**What it does:**
1. Creates a new Design Review file with today's date: `principles/design-reviews/YYYY-MM-DD-feature.md`
2. Sets status to "Draft"
3. Prompts for next steps to fill in requirements and solutions

**Related:**
- Template: `principles/design-reviews/design-review-template.md`
- Skill: `agents/skills/create-design-review.sh`

---

## See Also

- [lxi update](lxi-update.md) - Update existing documents
- [Architecture](../ARCHITECTURE.md) - System overview
- [ADR Guide](../principles/adrs/README.md) - ADR best practices
