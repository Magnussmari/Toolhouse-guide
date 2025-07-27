# 🎯 Toolhouse CLI Best Practices

> **Professional workflows and proven patterns** - Based on industry research and community feedback

## 🚀 Quick Reference

### Essential Daily Commands
```bash
# The Big Three - use these every day
th run agent.yaml          # Test locally (always do this first)
th validate agent.yaml     # Check syntax and configuration
th deploy agent.yaml       # Deploy to production

# Authentication & Status
th login                   # Authenticate once
th whoami                  # Check current user
th logout                  # Sign out

# Management & Monitoring
th agents list             # View deployed agents
th logs agent-name --follow # Live logs
th runs list              # Recent executions
```

## 🏗️ Project Structure Best Practices

### Recommended Directory Layout
```
your-project/
├── agents/                 # All .th files here
│   ├── production.yaml    # Production agent
│   ├── staging.yaml       # Staging/testing
│   └── development.yaml   # Local development
├── scripts/               # Automation scripts
│   ├── test-all.sh       # Test all agents
│   ├── deploy.sh          # Deployment script
│   └── validate.sh        # Validation script
├── tests/                 # Test scenarios
│   ├── scenarios.yaml    # Test cases
│   └── expected-outputs/  # Expected results
├── .env.example          # Environment template
├── .gitignore            # Git ignore (include .env)
└── README.md             # Project documentation
```

### File Naming Conventions
```bash
# Good naming patterns
customer-support.yaml      # Descriptive, kebab-case
data-analyzer-v2.yaml      # Version when needed
production-chatbot.yaml    # Environment prefix

# Avoid these patterns
untitled.yaml              # Too generic
test.yaml                  # Unclear purpose
my_agent.yaml              # Inconsistent casing
```

## 🔄 Development Workflow

### The Professional Development Loop

#### 1. Local Development First
```bash
# Always start local - saves time and money
th run agent.yaml --input \"test message\"

# Use specific test inputs
th run agent.yaml --input \"$(cat tests/test-input.txt)\"

# Validate before deploying
th validate agent.yaml
```

#### 2. Environment Progression
```bash
# Development → Staging → Production
th run development.yaml    # Local testing
th deploy staging.yaml     # Team testing
th deploy production.yaml  # Live deployment
```

#### 3. Version Control Integration
```bash
# Git workflow with validation
git add agents/
th validate agents/*.yaml  # Validate all before commit
git commit -m \"feat: improve customer support prompts\"
git push
```

## 🔐 Security & Secrets Best Practices

### Secret Management
```bash
# Store secrets securely in Toolhouse
th secrets add OPENAI_API_KEY=sk-...
th secrets add DATABASE_URL=postgresql://...
th secrets add SLACK_TOKEN=xoxb-...

# List secrets (names only, values hidden)
th secrets list

# Update secrets
th secrets set OPENAI_API_KEY=sk-new-key...

# Remove unused secrets
th secrets remove OLD_API_KEY
```

### Environment Variables in Agents
```yaml
# agent.yaml - Reference secrets securely
title: \"Secure Agent\"
prompt: |
  You are a helpful assistant.
  Database connection: ${DATABASE_URL}
  
vars:
  api_key: \"${OPENAI_API_KEY}\"
  environment: \"${ENVIRONMENT:production}\"
  debug: \"${DEBUG:false}\"
```

### .env File Management
```bash
# .env.example (commit this)
TOOLHOUSE_API_KEY=your_key_here
OPENAI_API_KEY=your_openai_key
ENVIRONMENT=development

# .env (never commit this)
TOOLHOUSE_API_KEY=th_abc123...
OPENAI_API_KEY=sk-proj-...
ENVIRONMENT=development

# .gitignore (always include)
.env
.env.local
.env.*.local
```

## 🧪 Testing Strategies

### Automated Testing Patterns
```bash
# Test script example
#!/bin/bash
# test-agent.sh

set -e

echo \"🧪 Testing agent configuration...\"

# Validate syntax
th validate agent.yaml

# Test scenarios
test_cases=(
  \"Hello, how can you help?\"
  \"What are your capabilities?\"
  \"Can you process data files?\"
)

for test_case in \"${test_cases[@]}\"; do
  echo \"Testing: $test_case\"
  result=$(th run agent.yaml --input \"$test_case\")
  
  # Check for error indicators
  if echo \"$result\" | grep -q \"error\\|Error\\|ERROR\"; then
    echo \"❌ Test failed: $test_case\"
    exit 1
  fi
  
  echo \"✅ Test passed\"
done

echo \"🎉 All tests passed!\"
```

### Regression Testing
```yaml
# tests/scenarios.yaml
test_scenarios:
  - name: \"Basic greeting\"
    input: \"Hello, how are you?\"
    expected_keywords: [\"hello\", \"help\", \"assist\"]
    
  - name: \"Data processing\"
    input: \"Can you analyze this CSV data?\"
    expected_keywords: [\"csv\", \"analyze\", \"data\"]
    
  - name: \"Error handling\"
    input: \"Invalid request 123!@#\"
    should_not_contain: [\"error\", \"crash\", \"fail\"]
```

## 📊 Monitoring & Observability

### Log Management
```bash
# Real-time monitoring
th logs customer-support --follow

# Historical logs
th logs customer-support --since 24h
th logs customer-support --since \"2025-01-01\"

# Filter by level
th logs customer-support --level error
th logs customer-support --level debug

# Export logs for analysis
th logs customer-support --since 7d --format json > logs.json
```

### Performance Monitoring
```bash
# Check agent run history
th runs list --agent customer-support

# Get detailed run information
th runs get <run-id>

# Monitor for failures
th runs list --status failed --since 24h
```

### Cost Monitoring
```bash
# Track agent run usage
th usage --agent customer-support --period month

# Monitor credit consumption
th account status

# Set up alerts (if available)
th alerts create --threshold 80% --type credit-usage
```

## 🚀 Deployment Best Practices

### Pre-deployment Checklist
```bash
# 1. Validate configuration
th validate agent.yaml

# 2. Test locally
th run agent.yaml --input \"test scenario\"

# 3. Check authentication
th whoami

# 4. Verify secrets are set
th secrets list

# 5. Deploy
th deploy agent.yaml
```

### Deployment Strategies

#### Blue-Green Deployment
```bash
# Deploy new version alongside old
th deploy agent-v2.yaml --name agent-green

# Test new version
curl -X POST https://agents.toolhouse.ai/agent-green-id \\
  -d '{\"message\": \"test\"}'

# Switch traffic (update DNS/load balancer)
# Remove old version
th agents delete agent-blue
```

#### Rolling Deployment
```bash
# Gradual rollout script
#!/bin/bash
for region in us-west eu-west asia-east; do
  echo \"Deploying to $region...\"
  th deploy agent.yaml --region $region
  sleep 60  # Wait between regions
done
```

### Environment-Specific Deployment
```bash
# Development environment
th deploy agent.yaml --public=false --environment=dev

# Staging environment  
th deploy agent.yaml --public=false --environment=staging

# Production environment
th deploy agent.yaml --public=false --environment=production
```

## 🔧 Advanced Configuration

### Agent Configuration Patterns

#### Multi-Environment Agent
```yaml
# agent.yaml
title: \"${AGENT_NAME:Customer Support Agent}\"
prompt: |
  You are a ${ENVIRONMENT:production} customer support agent.
  
  Environment: ${ENVIRONMENT}
  Debug mode: ${DEBUG:false}
  
  ${ENVIRONMENT_SPECIFIC_INSTRUCTIONS}
  
model: \"${MODEL:@openai/gpt-4o-mini}\"
public: ${PUBLIC:false}
vars:
  environment: \"${ENVIRONMENT:production}\"
  api_endpoint: \"${API_ENDPOINT:https://api.example.com}\"
  timeout: \"${TIMEOUT:30}\"
```

#### Conditional Tool Loading
```yaml
# Only load certain tools in specific environments
bundles:
  - \"rag\"  # Always available
  - \"${DEBUG:false}\" == \"true\" ? \"debug-tools\" : \"\"
  - \"${ENVIRONMENT}\" == \"production\" ? \"monitoring\" : \"testing\"
```

### Advanced CLI Usage

#### Batch Operations
```bash
# Deploy multiple agents
for agent in agents/*.yaml; do
  echo \"Deploying $agent...\"
  th deploy \"$agent\"
done

# Validate all agents
th validate agents/*.yaml

# Update all agents with new secrets
th secrets set NEW_API_KEY=value
for agent in agents/*.yaml; do
  th deploy \"$agent\"  # Redeploy to pick up new secrets
done
```

#### Parallel Processing
```bash
# Test multiple agents in parallel
#!/bin/bash
test_agent() {
  local agent=$1
  echo \"Testing $agent...\"
  th run \"$agent\" --input \"test\" > \"results/${agent%.yaml}.log\" 2>&1
}

export -f test_agent
ls agents/*.yaml | xargs -n1 -P4 bash -c 'test_agent \"$@\"' _
```

## 🔍 Troubleshooting Guide

### Common Issues & Solutions

#### Authentication Problems
```bash
# Problem: \"Authentication failed\"
# Solution:
th logout
th login

# Problem: \"API key not found\"
# Check stored credentials:
cat ~/.toolhouse/config.json

# Regenerate API key in dashboard if needed
```

#### Deployment Failures
```bash
# Problem: \"Invalid configuration\"
# Debug steps:
th validate agent.yaml  # Check syntax
yamlint agent.yaml      # Advanced YAML validation

# Problem: \"Secrets not found\"
# Check secrets:
th secrets list
th secrets add MISSING_KEY=value
```

#### Performance Issues
```bash
# Problem: \"Agent runs slowly\"
# Check model and optimize:
# - Use faster models for simple tasks
# - Optimize prompts for brevity
# - Reduce tool calls in prompt

# Monitor performance:
th logs agent-name --since 1h | grep \"execution_time\"
```

### Debug Mode
```bash
# Enable verbose output
export TH_DEBUG=true
th run agent.yaml

# Capture full request/response
th run agent.yaml --debug --output debug.log
```

## 📚 Integration Patterns

### CI/CD Integration

#### GitHub Actions
```yaml
# .github/workflows/deploy-agent.yml
name: Deploy Toolhouse Agent
on:
  push:
    branches: [main]
    paths: ['agents/**']

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          
      - name: Install Toolhouse CLI
        run: npm install -g @toolhouseai/cli
        
      - name: Validate Agents
        run: |
          for agent in agents/*.yaml; do
            th validate \"$agent\"
          done
          
      - name: Deploy to Staging
        if: github.ref == 'refs/heads/develop'
        run: th deploy agents/staging.yaml
        env:
          TOOLHOUSE_API_KEY: ${{ secrets.TOOLHOUSE_API_KEY_STAGING }}
          
      - name: Deploy to Production
        if: github.ref == 'refs/heads/main'
        run: th deploy agents/production.yaml
        env:
          TOOLHOUSE_API_KEY: ${{ secrets.TOOLHOUSE_API_KEY_PROD }}
```

#### Docker Integration
```dockerfile
# Dockerfile
FROM node:18-alpine

RUN npm install -g @toolhouseai/cli

WORKDIR /app
COPY agents/ ./agents/
COPY scripts/ ./scripts/

CMD [\"./scripts/deploy.sh\"]
```

### VS Code Integration

#### Workspace Settings
```json
// .vscode/settings.json
{
  \"yaml.schemas\": {
    \"https://raw.githubusercontent.com/toolhouseai/schema/main/agent.json\": \"agents/*.yaml\"
  },
  \"files.associations\": {
    \"*.th\": \"yaml\"
  },
  \"editor.formatOnSave\": true,
  \"yaml.format.enable\": true
}
```

#### Tasks Configuration
```json
// .vscode/tasks.json
{
  \"version\": \"2.0.0\",
  \"tasks\": [
    {
      \"label\": \"Test All Agents\",
      \"type\": \"shell\",
      \"command\": \"./scripts/test-all.sh\",
      \"group\": \"test\",
      \"presentation\": {
        \"echo\": true,
        \"reveal\": \"always\"
      }
    },
    {
      \"label\": \"Deploy Production\",
      \"type\": \"shell\",
      \"command\": \"th deploy agents/production.yaml\",
      \"group\": \"build\"
    }
  ]
}
```

## 🎯 Performance Optimization

### Model Selection Strategy
```yaml
# Choose models based on use case

# For simple tasks (fast + cheap)
model: \"@openai/gpt-4o-mini\"

# For complex reasoning (slower + expensive)
model: \"@openai/o1-preview\"

# For speed (with Groq)
model: \"@groq/llama-3.3-70b-versatile\"

# For latest features
model: \"@anthropic/claude-sonnet-4-20250514\"
```

### Prompt Optimization
```yaml
# Inefficient prompt (verbose, multiple tool calls)
prompt: |
  You are a helpful assistant. Please be very detailed in your responses.
  Always search the knowledge base first, then search the web if needed,
  then check the database, then format the response nicely...

# Optimized prompt (concise, clear)
prompt: |
  You are a customer support agent. Priority order:
  1. Search knowledge base
  2. If no answer found, state clearly
  3. Offer to escalate to human
```

### Resource Management
```bash
# Monitor resource usage
th account usage --detailed

# Optimize for cost
# - Use smaller models for simple tasks
# - Cache results when possible
# - Minimize tool calls per run

# Scale based on demand
th agents scale customer-support --instances 3  # If available
```

---

## 🏆 Summary: The Golden Rules

1. **🧪 Always test locally first** - `th run` before `th deploy`
2. **🔐 Keep secrets secure** - Use `th secrets`, never hardcode
3. **📝 Validate before deploy** - `th validate` catches errors early
4. **🔄 Use version control** - Git + proper commit messages
5. **📊 Monitor in production** - Use `th logs` and `th runs`
6. **🎯 Optimize for your use case** - Right model + concise prompts
7. **🚀 Automate repetitive tasks** - Scripts + CI/CD integration
8. **📚 Document your setup** - Future you will thank you

**Following these practices will make you a Toolhouse CLI power user and help you build reliable, maintainable AI agents!**"