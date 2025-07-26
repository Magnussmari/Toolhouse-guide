# Getting Started with Toolhouse

Welcome! This guide will have you building your first AI agent in under 10 minutes. No matter your technical background, there's a path for you.

## 🎯 Choose Your Path

### Path 1: 🎨 Vibe Coder (No Code Required)
**Best for**: Product managers, designers, business users, or anyone who wants to build agents through conversation.

**Time**: 5-10 minutes  
**What you'll build**: A customer support agent with knowledge base

### Path 2: 💻 Developer (Code-First)
**Best for**: Software engineers, AI engineers, or developers who want full control.

**Time**: 15-30 minutes  
**What you'll build**: A deployable agent with CLI workflow

### Path 3: ⚡ SDK Integration (Existing Apps)
**Best for**: Adding agent capabilities to existing applications.

**Time**: 10-20 minutes  
**What you'll build**: Agent integration in your current codebase

---

## 🎨 Path 1: Vibe Coder Quick Start

### Step 1: Create Your Account
1. Visit [toolhouse.ai/signup](https://toolhouse.ai/signup)
2. Sign up with email or GitHub
3. Complete the onboarding flow

### Step 2: Open Agent Studio
1. Click **\"Create Agent\"** from the dashboard
2. Select **\"Agent Studio\"** 
3. You'll see a chat interface - this is where the magic happens!

### Step 3: Build Your First Agent
Type this prompt in the chat:

```
Build a customer support agent for an online bookstore called \"BookHaven\". 

The agent should:
- Be friendly and professional
- Search our knowledge base first for answers
- If no answer is found, offer to connect the customer with a human
- Be helpful with order status, returns, and book recommendations

Test it with a question about return policies.
```

### Step 4: Watch the Magic
- The Agent Studio will generate a complete agent configuration
- You'll see the YAML file update in real-time
- The agent will automatically test itself!

### Step 5: Deploy Your Agent
1. Click **\"Deploy\"** when you're happy with the results
2. Get your unique API endpoint
3. Test it by sending a POST request or using the built-in tester

**🎉 Congratulations!** You just built and deployed your first AI agent without writing a single line of code.

---

## 💻 Path 2: Developer Quick Start

### Step 1: Prerequisites
- Node.js 16+ installed
- Text editor (VS Code recommended)
- Terminal/command line access

### Step 2: Install CLI
```bash
# Install globally via npm
npm install -g @toolhouseai/cli

# Verify installation
th --version
```

### Step 3: Authenticate
```bash
# Login via browser
th login

# Your API key will be automatically stored
```

### Step 4: Create Your First Agent
```bash
# Create a new agent file
th new my-first-agent.yaml

# This creates a template - let's customize it
```

Edit the generated file:
```yaml
title: \"Code Review Assistant\"
prompt: |
  You are an expert code reviewer. When given code, you should:
  1. Analyze it for bugs, security issues, and best practices
  2. Use the code_interpreter tool to test the code if needed
  3. Provide specific, actionable feedback
  4. Suggest improvements with examples
  
  Be thorough but constructive in your feedback.
model: \"@openai/gpt-4o-mini\"
public: true
```

### Step 5: Test Locally
```bash
# Run your agent locally
th run my-first-agent.yaml

# You'll see the agent execute and provide output
```

### Step 6: Deploy to Production
```bash
# Deploy to Toolhouse cloud
th deploy my-first-agent.yaml

# Get your API endpoint for integration
```

**🚀 Success!** You now have a production-ready agent API endpoint.

---

## ⚡ Path 3: SDK Integration Quick Start

### Step 1: Install SDK
```bash
# Python
pip install toolhouse

# Or JavaScript/TypeScript
npm install @toolhouseai/sdk
```

### Step 2: Get API Key
1. Visit [toolhouse.ai/dashboard](https://toolhouse.ai/dashboard)
2. Go to **\"API Keys\"** section
3. Click **\"Generate New Key\"**
4. Copy and save securely

### Step 3: Your First Integration (Python)
```python
import os
from openai import OpenAI
from toolhouse import Toolhouse

# Initialize clients
openai_client = OpenAI(api_key=os.environ.get(\"OPENAI_API_KEY\"))
th = Toolhouse(api_key=os.environ.get(\"TOOLHOUSE_API_KEY\"), provider=\"openai\")

# Your conversation
messages = [{\"role\": \"user\", \"content\": \"Write and run Python code to calculate the fibonacci sequence up to 100\"}]

# First LLM call - get tool request
response = openai_client.chat.completions.create(
    model=\"gpt-4o-mini\",
    messages=messages,
    tools=th.get_tools()  # Make Toolhouse tools available
)

# Execute the requested tool
tool_outputs = th.run_tools(response)
if tool_outputs:
    messages += tool_outputs

# Final LLM call with results
final_response = openai_client.chat.completions.create(
    model=\"gpt-4o-mini\",
    messages=messages
)

print(final_response.choices[0].message.content)
```

### Step 4: Environment Setup
Create a `.env` file:
```bash
OPENAI_API_KEY=your_openai_key_here
TOOLHOUSE_API_KEY=your_toolhouse_key_here
```

**⚡ Done!** You've successfully integrated Toolhouse into your application.

---

## 🔑 Essential Concepts

### Agent Runs
- **1 Agent Run = 1 Credit** from your plan
- Unlimited tool executions within a single run
- Each run gets a unique ID for tracking

### Tool Ecosystem
- **Built-in Tools**: Code execution, web search, RAG, memory
- **MCP Servers**: Extend with custom capabilities
- **Tool Store**: Browse community-contributed tools

### Development Workflow
1. **Build**: Create agents via Studio or CLI
2. **Test**: Run locally or in Studio
3. **Deploy**: One-click deployment to production
4. **Monitor**: Built-in observability and analytics

## 🆘 Need Help?

### Common Issues

**\"Command not found: th\"**
```bash
# Make sure Node.js is installed and npm is in PATH
npm install -g @toolhouseai/cli
```

**\"Authentication failed\"**
```bash
# Clear existing auth and retry
rm ~/.toolhouse/auth.json
th login
```

**\"Agent run failed\"**
- Check your API key is valid
- Verify you have credits remaining in your plan
- Review agent logs in the dashboard

### Getting Support
- 📚 [Full Documentation](https://docs.toolhouse.ai/)
- 💬 [Discord Community](https://discord.gg/toolhouse)
- 🐛 [Report Issues](https://github.com/toolhouseai/toolhouse/issues)
- 📧 [Email Support](mailto:support@toolhouse.ai)

## 🎯 Next Steps

Now that you have your first agent running, explore:

1. **[Agent Studio Deep Dive](03-agent-studio.md)** - Master no-code agent building
2. **[Advanced CLI Workflows](04-developer-workflow.md)** - Professional development practices
3. **[SDK Patterns](05-sdk-integration.md)** - Advanced integration techniques
4. **[Production Deployment](07-production.md)** - Scale to enterprise

---

**🎉 Welcome to the Toolhouse community!** You're now equipped to build AI agents that can interact with the real world. The sky's the limit!