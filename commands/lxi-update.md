# lxi update

Update or generate documentation from repository state.

## Usage

```bash
lxi update <type> [options]
```

## Commands

### lxi update lx

Generate or update the weekly LX (Living Experience) document.

**Usage:**
```bash
lxi update lx [YYYY-MM-DD]
```

**Arguments:**
- `YYYY-MM-DD` (optional): The Monday date of the week to update. If not provided, uses current week's Monday.

**Examples:**
```bash
lxi update lx              # Update for current week
lxi update lx 2024-10-28   # Update for specific week
```

**What it does:**
1. Checks if LX document exists for the specified week
2. If not exists: Creates from template `process/lx/lx-template.md`
3. If exists: Updates with current information
4. Prompts to fill in:
   - Epic statuses (🟢🟡🔴)
   - Last week's accomplishments
   - This week's planned work
   - Open decisions
   - Blockers

**Output:**
- Creates/updates: `process/lx/YYYY-MM-DD-weekly.md`

**Related:**
- Template: `process/lx/lx-template.md`
- Skill: `agents/skills/update-lx.sh`
- Sync to Confluence: `lxi sync confluence`

---

## See Also

- [lxi create](lxi-create.md) - Create new documents
- [lxi sync](lxi-sync.md) - Sync to external systems
- [Architecture](../ARCHITECTURE.md#lx-documents-living-experience) - LX Document structure
