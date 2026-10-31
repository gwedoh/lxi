# LXI Setup Guide

This guide walks you through setting up LXI in your repository.

---

## Prerequisites

### Required

1. **Java 17+** (for Gradle build system)
   ```bash
   java -version
   ```

2. **Node.js and npm** (for Mermaid diagram generation)
   ```bash
   node --version
   npm --version
   ```

3. **Git** (for commit tracking)
   ```bash
   git --version
   ```

### Optional (for full functionality)

4. **Jira Access** - API token for Jira sync
5. **Confluence Access** - API token for Confluence sync
6. **Slack/Teams Webhook** - For notifications

---

## Installation

### 1. Install Mermaid CLI

```bash
npm install -g @mermaid-js/mermaid-cli
```

Verify:
```bash
mmdc --version
```

### 2. Initialize Gradle Wrapper

```bash
cd /path/to/lxi
gradle wrapper --gradle-version 8.5
```

This creates:
- `gradlew` (Unix/Mac wrapper script)
- `gradlew.bat` (Windows wrapper script)
- `gradle/wrapper/` (wrapper JAR and properties)

### 3. Configure User Settings

Create `user/settings.yml`:

```yaml
user:
  name: Your Name
  email: you@company.com
  timezone: America/New_York

diagrams:
  format: svg  # svg or png
  theme: neutral  # neutral, dark, forest, default
  background: transparent

jira:
  url: https://your-company.atlassian.net
  email: you@company.com
  api_token: your_jira_api_token
  project_key: TEAM

confluence:
  url: https://your-company.atlassian.net/wiki
  email: you@company.com
  api_token: your_confluence_api_token
  space_key: TEAM
  parent_page_id: 123456  # LX documents will be created as children

git:
  default_branch: main
  commit_message_format: "[{jira_key}] {message}"

notifications:
  slack:
    enabled: false
    webhook_url: https://hooks.slack.com/services/YOUR/WEBHOOK/URL

  teams:
    enabled: false
    webhook_url: https://outlook.office.com/webhook/YOUR/WEBHOOK/URL
```

**Security Note**: Add `user/settings.yml` to `.gitignore` (it already is in the template).

---

## Quick Start

### 1. Generate Diagrams

```bash
./gradlew generateDiagrams
```

This converts all `.mmd` files in `product/` to SVG.

### 2. Create Your First LX Document

```bash
./gradlew updateLx
```

Follow the interactive prompts to create this week's LX document.

### 3. Generate Roadmap

```bash
./gradlew generateRoadmap
```

Creates `product/roadmap.mmd` and `product/roadmap.svg` from:
- LX Documents
- `product/goals.yml`
- Jira epic data (if configured)

### 4. Validate Setup

```bash
./gradlew validateReferences
./gradlew checkFreshness
```

---

## Daily Workflow

### Morning (Engineers)

```bash
# Update standup
./gradlew standupGenerate

# (Optional) Edit the generated standup if needed
# File: product/progress/YYYY-MM-DD-standup.md
```

### End of Day (Engineers)

```bash
# Commit work with proper references
git add .
git commit -m "[TEAM-123] Implement user analytics SDK

References:
- Design Review: principles/design-reviews/2024-10-15-user-analytics.md
- ADR-0015: Analytics data architecture
"
```

### Monday (Product Manager / Engineering Manager)

```bash
# Generate or update weekly LX document
./gradlew updateLx

# Generate roadmap and outcomes
./gradlew generateRoadmap generateOutcomes

# Sync everything to external systems
./gradlew syncAll
```

---

## Available Gradle Tasks

### Diagram Generation

```bash
./gradlew generateDiagrams      # Convert all .mmd to .svg
./gradlew generateRoadmap       # Generate roadmap from LX docs
./gradlew generateOutcomes      # Generate outcomes dashboard
```

### Document Creation

```bash
./gradlew createAdr             # Interactive ADR creation
./gradlew createDesignReview    # Interactive Design Review creation
./gradlew updateLx              # Update/create weekly LX document
./gradlew standupGenerate       # Auto-generate daily standup
```

### Validation

```bash
./gradlew validateReferences    # Check all cross-references
./gradlew checkFreshness        # Find stale documents (>30 days)
```

### Sync

```bash
./gradlew syncJira              # Sync to Jira
./gradlew syncConfluence        # Sync to Confluence
./gradlew syncAll               # Generate all diagrams and sync
```

### List All Tasks

```bash
./gradlew tasks --group lxi
```

---

## Integration Setup

### Jira Integration

1. **Create API Token**:
   - Go to https://id.atlassian.com/manage-profile/security/api-tokens
   - Click "Create API token"
   - Copy token to `user/settings.yml`

2. **Test Connection**:
   ```bash
   ./gradlew syncJira --dry-run
   ```

3. **Configure Epic Mapping**:
   In your LX documents, reference Jira epics:
   ```markdown
   ### Epic: User Analytics - [TEAM-100](https://jira.../TEAM-100)
   ```

### Confluence Integration

1. **Create API Token** (same as Jira if using Atlassian Cloud)

2. **Find Parent Page ID**:
   - Navigate to your team's Confluence space
   - Find the page where LX docs should live
   - Page ID is in the URL: `.../pages/123456/Page+Title`

3. **Test Connection**:
   ```bash
   ./gradlew syncConfluence --dry-run
   ```

### Git Integration

Already works! LXI reads:
- Commit history
- Branch names
- PR/MR data (if using GitHub/GitLab CLI tools)

---

## Customization

### Custom Diagrams

1. Create `.mmd` file in `product/`:
   ```bash
   cat > product/custom-flow.mmd <<EOF
   graph TD
       A[Start] --> B{Decision}
       B -->|Yes| C[Action]
       B -->|No| D[End]
   EOF
   ```

2. Generate:
   ```bash
   ./gradlew generateDiagrams
   ```

3. Embed in docs:
   ```markdown
   ![Custom Flow](./product/custom-flow.svg)
   ```

### Custom Gradle Tasks

Edit `build.gradle` to add your own tasks:

```groovy
task myCustomTask(type: JavaExec) {
    description = 'My custom LXI automation'
    group = 'lxi'

    classpath = sourceSets.main.runtimeClasspath
    mainClass = 'com.lxi.custom.MyTask'
}
```

---

## Troubleshooting

### Issue: `mmdc: command not found`

**Solution**: Install Mermaid CLI
```bash
npm install -g @mermaid-js/mermaid-cli
```

### Issue: Gradle tasks not found

**Solution**: Regenerate wrapper
```bash
gradle wrapper --gradle-version 8.5
./gradlew tasks
```

### Issue: Jira sync fails with 401

**Solution**: Check API token
- Verify token in `user/settings.yml`
- Ensure email matches Jira account
- Token should have write access to projects

### Issue: Diagrams not generating

**Solution**: Check Mermaid syntax
```bash
# Validate syntax
mmdc -i product/roadmap.mmd -o /tmp/test.svg

# If it works, problem is in Gradle task
./gradlew generateDiagrams --info
```

### Issue: Cross-references broken

**Solution**: Validate and fix
```bash
./gradlew validateReferences

# Output will show broken links and suggest fixes
```

---

## CI/CD Integration

### GitHub Actions

Create `.github/workflows/lxi-sync.yml`:

```yaml
name: LXI Sync

on:
  schedule:
    - cron: '0 9 * * 1'  # Every Monday at 9am
  workflow_dispatch:  # Manual trigger

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Set up Java
        uses: actions/setup-java@v3
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: Set up Node
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install Mermaid CLI
        run: npm install -g @mermaid-js/mermaid-cli

      - name: Generate and Sync
        env:
          JIRA_API_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
          CONFLUENCE_API_TOKEN: ${{ secrets.CONFLUENCE_API_TOKEN }}
        run: |
          # Create settings from secrets
          cat > user/settings.yml <<EOF
          jira:
            url: ${{ secrets.JIRA_URL }}
            email: ${{ secrets.JIRA_EMAIL }}
            api_token: $JIRA_API_TOKEN
          confluence:
            url: ${{ secrets.CONFLUENCE_URL }}
            email: ${{ secrets.CONFLUENCE_EMAIL }}
            api_token: $CONFLUENCE_API_TOKEN
          EOF

          # Run sync
          ./gradlew syncAll
```

### GitLab CI

Create `.gitlab-ci.yml`:

```yaml
lxi-sync:
  image: gradle:8.5-jdk17
  before_script:
    - apt-get update && apt-get install -y nodejs npm
    - npm install -g @mermaid-js/mermaid-cli
  script:
    - ./gradlew syncAll
  only:
    - schedules  # Run on scheduled pipelines
  artifacts:
    paths:
      - product/*.svg
```

---

## Best Practices

### 1. Weekly Sync Cadence

Run `./gradlew syncAll` every Monday morning to:
- Generate fresh diagrams
- Update Confluence
- Sync Jira epic progress

### 2. Automated Standup Generation

Add to your shell profile (`.zshrc` or `.bashrc`):

```bash
alias standup='cd /path/to/lxi && ./gradlew standupGenerate'
```

### 3. Pre-Commit Hook

Create `.git/hooks/pre-commit`:

```bash
#!/bin/bash
# Validate references before commit
./gradlew validateReferences --quiet

if [ $? -ne 0 ]; then
    echo "❌ Cross-reference validation failed"
    echo "Fix broken links before committing"
    exit 1
fi
```

Make executable:
```bash
chmod +x .git/hooks/pre-commit
```

---

## Next Steps

1. ✅ Install prerequisites
2. ✅ Configure `user/settings.yml`
3. ✅ Generate first diagrams
4. ✅ Create first LX document
5. ✅ Set up Jira/Confluence sync
6. ✅ Configure CI/CD automation
7. 📖 Read [ARCHITECTURE.md](./ARCHITECTURE.md) for system details
8. 📖 Review [EXAMPLE.md](./EXAMPLE.md) for end-to-end scenario

---

## Support

- **Documentation**: See [README.md](./README.md)
- **Issues**: Open in GitHub Issues
- **Questions**: Check [process/README.md](./process/README.md) for workflows

---

_LXI Setup Guide - Version 1.0.0_
