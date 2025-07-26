# CLI Commands Quick Reference

> Essential Toolhouse CLI commands for rapid development

## 🚀 Installation & Setup

```bash
# Install CLI globally
npm install -g @toolhouseai/cli

# Verify installation
th --version

# Login to your account
th login

# Check authentication status
th whoami
```

## 📁 Agent Management

### Creating Agents
```bash
# Create new agent from template
th new my-agent.yaml

# Create with specific template
th new my-agent.yaml --template customer-support

# Create in specific directory
th new agents/support-bot.yaml
```

### Running Agents
```bash
# Run agent locally
th run my-agent.yaml

# Run with custom input
th run my-agent.yaml --input "Hello, world!"

# Run and save output
th run my-agent.yaml > output.txt

# Run with environment variables
CUSTOM_VAR=value th run my-agent.yaml
```

### Deploying Agents
```bash
# Deploy to production
th deploy my-agent.yaml

# Deploy as public agent
th deploy my-agent.yaml --public

# Deploy with custom name
th deploy my-agent.yaml --name "support-bot-v2"

# Deploy and get URL
th deploy my-agent.yaml --show-url
```

## 🔐 Secrets Management

```bash
# Add a secret
th secrets add API_KEY=your_secret_here

# Set multiple secrets
th secrets set OPENAI_KEY=sk-... GROQ_KEY=gsk-...

# List all secrets (names only)
th secrets list

# Remove a secret
th secrets remove API_KEY

# Update existing secret
th secrets set API_KEY=new_value
```

## 📊 Monitoring & Logs

```bash
# View recent runs
th runs list

# Get specific run details
th runs get <run-id>

# Follow live logs
th logs my-agent --follow

# Get logs for specific time period
th logs my-agent --since 1h

# Export logs to file
th logs my-agent --since 24h > agent-logs.txt
```

## 🔧 Agent Configuration

```bash
# Validate agent configuration
th validate my-agent.yaml

# Show agent info
th info my-agent.yaml

# List deployed agents
th agents list

# Get agent status
th agents status my-agent

# Delete deployed agent
th agents delete my-agent
```

## 🌐 MCP Server Management

```bash
# List available MCP servers
th mcp list

# Install MCP server
th mcp install weather-api

# Remove MCP server
th mcp remove weather-api

# Update MCP server
th mcp update weather-api
```

## 🔄 Environment Management

```bash
# Switch between environments
th env use production
th env use development

# List environments
th env list

# Create new environment
th env create staging

# Set environment variables
th env set ENVIRONMENT=production
```

## 📦 Project Management

```bash
# Initialize new project
th init my-project

# Generate project from template
th init my-project --template saas-app

# Install project dependencies
th install

# Run project build
th build

# Run project tests
th test
```

## 🔍 Debugging & Development

```bash
# Run in debug mode
th run my-agent.yaml --debug

# Dry run (validate without executing)
th run my-agent.yaml --dry-run

# Run with verbose output
th run my-agent.yaml --verbose

# Test agent with specific scenarios
th test my-agent.yaml --scenario error-handling
```

## 📈 Analytics & Performance

```bash
# Get agent performance metrics
th metrics my-agent

# Generate usage report
th report --agent my-agent --period 7d

# Export analytics data
th analytics export --format csv --period 30d
```

## 🔧 Configuration & Preferences

```bash
# Set global configuration
th config set default-model @openai/gpt-4o-mini

# Get configuration value
th config get default-model

# List all configuration
th config list

# Reset configuration to defaults
th config reset
```

## 🆘 Help & Documentation

```bash
# Get help for any command
th help
th help deploy
th help secrets add

# Open documentation in browser
th docs

# Check for updates
th update

# Report a bug
th bug-report
```

## 💡 Common Workflows

### Development Workflow
```bash
# 1. Create new agent
th new customer-bot.yaml

# 2. Test locally
th run customer-bot.yaml

# 3. Deploy for testing
th deploy customer-bot.yaml --public

# 4. Deploy to production
th deploy customer-bot.yaml --name customer-bot-prod
```

### CI/CD Pipeline
```bash
# Validate all agents
th validate agents/*.yaml

# Run tests
th test agents/*.yaml

# Deploy if tests pass
th deploy agents/production.yaml
```

### Debugging Failed Agent
```bash
# Get recent runs
th runs list --status failed

# Get detailed error info
th runs get <failed-run-id>

# Check agent logs
th logs my-agent --since 1h --level error

# Run locally with debug
th run my-agent.yaml --debug
```

## 🎯 Advanced Tips

### Performance Optimization
```bash
# Profile agent performance
th run my-agent.yaml --profile

# Test with concurrent requests
th load-test my-agent.yaml --requests 100 --concurrent 10
```

### Batch Operations
```bash
# Deploy multiple agents
th deploy agents/*.yaml

# Run multiple agents in parallel
th run agents/*.yaml --parallel

# Update all agents with new secrets
th secrets set NEW_API_KEY=value && th deploy agents/*.yaml
```

### Integration with Other Tools
```bash
# Use with git hooks
git add . && git commit -m "Update agent" && th deploy production.yaml

# Combine with curl for API testing
th deploy my-agent.yaml --show-url | xargs curl -X POST -d '{"message":"test"}'

# Use with jq for JSON processing
th runs get <run-id> --format json | jq '.response.message'
```

---

## 📚 Related Resources

- [Full CLI Documentation](https://docs.toolhouse.ai/cli)
- [Agent Configuration Reference](../reference/configuration.md)
- [Troubleshooting Guide](../reference/troubleshooting.md)
- [Best Practices](../07-production.md)

---

*💡 **Pro Tip**: Use `th help <command>` to get detailed help for any command, including examples and all available options.*