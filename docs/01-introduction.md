# Introduction to Toolhouse.ai

## The Assembly Line for AI Agents

The landscape of artificial intelligence is undergoing a transformation reminiscent of the shift from handcrafted automobiles to mass production. For years, building capable AI agents has been a luxury—a complex, expensive, and time-consuming process accessible only to a small fraction of developers with specialized knowledge and significant resources. 

**Toolhouse.ai emerges as a direct response to this challenge**, positioning itself as the "assembly line for agents". Its stated mission is to democratize agent development, making it accessible to the 38 million developers who have been largely left behind by the current AI paradigm.

## What is Toolhouse?

At its core, Toolhouse is an agentic **Backend-as-a-Service (BaaS)**, a comprehensive cloud platform designed to build, run, and manage AI agents from ideation to production. It abstracts away the immense complexity of the underlying AI stack, allowing developers to focus on what their agents should *do*, not how the infrastructure should be built.

This approach is best understood through the analogy of **"npm for function calling"**. Just as npm (Node Package Manager) simplified the process of incorporating third-party code libraries into JavaScript projects, Toolhouse standardizes and radically simplifies the process of equipping Large Language Models (LLMs) with external tools and capabilities.

## Core Architecture

Toolhouse provides a universal mechanism for any LLM that supports function calling to interact with the real world through APIs, databases, web scrapers, and more, effectively shielding developers from the intricate and often inconsistent implementations across different model providers.

### Key Components

1. **The Toolhouse Cloud & MCP Servers**
   - User-facing **Tool Store** - marketplace of pre-built, production-ready tools
   - Technical foundation of **MCP (Multi-Cloud Platform) Servers**
   - Default MCP server with fundamental agentic capabilities (RAG, code execution, web search, memory)
   - Hosted on globally distributed, low-latency cloud infrastructure

2. **The Universal SDK**
   - **Three lines of code** integration for powerful tool-use capabilities
   - Compatible with all major LLMs (OpenAI, Anthropic, Groq)
   - Works with popular AI frameworks (LlamaIndex, Vercel AI)
   - Available in Python and TypeScript

3. **Agents as Code (.th files)**
   - Every agent defined by simple YAML configuration file
   - Version-controlled, peer-reviewed, CI/CD pipeline compatible
   - Complete transparency of agent configuration

4. **Agent Runs & Observability**
   - **Agent Run** = single instance of agent execution
   - Built-in analytics and observability tools
   - Inspect every step: LLM reasoning, tool calls, inputs, outputs

## The Toolhouse Ecosystem

| Component | Primary User | Core Function |
|-----------|--------------|---------------|
| **Agent Studio** | Vibe Coder, Prototyper | No-code agent creation via chat interface |
| **Toolhouse CLI** | Developer, AI Engineer | Command-line agent management and deployment |
| **Toolhouse SDK** | Developer, AI Engineer | Direct integration into existing applications |
| **Tool Store / MCP Servers** | All Users | Marketplace of pre-built agent capabilities |

## Why Toolhouse Matters

**Before Toolhouse:**
- Complex, expensive agent development
- Custom implementations for every LLM provider
- Fragmented tooling and inconsistent APIs
- Barriers to entry for most developers

**With Toolhouse:**
- Universal, standardized protocol
- "Three lines of code" integration
- Professional development workflows
- Accessible to 38 million developers

## Pricing Overview

| Plan | Price | Target User | Agent Runs/month |
|------|-------|-------------|------------------|
| **Sandbox** | $0 | Getting Started | 50 |
| **Pro** | $10 | Startups & Vibe Coders | 1,000 |
| **Business** | $850 | Later-Stage Companies | 100,000+ |
| **Enterprise** | Custom | Custom Needs | Custom |

### Key Pricing Insight
- **One credit = One agent run**
- **Unlimited MCP executions** within a single run
- Agent can call multiple tools without extra charges

## Getting Started Paths

1. **🎨 Vibe Coder Path**: Start with Agent Studio for natural language agent building
2. **💻 Developer Path**: Use CLI for professional, code-first development
3. **⚡ SDK Path**: Integrate directly into existing applications

## Next Steps

- [Getting Started Guide](02-getting-started.md) - Set up your account and build your first agent
- [Agent Studio Tutorial](03-agent-studio.md) - No-code agent creation
- [Developer Workflow](04-developer-workflow.md) - Professional development setup

---

*Ready to transform how you build AI agents? Let's dive in!*