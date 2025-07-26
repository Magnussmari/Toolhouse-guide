# Customer Support Agent

> A RAG-powered customer support agent that searches a knowledge base before responding to user queries.

## 🎯 What This Example Demonstrates

- **RAG (Retrieval-Augmented Generation)**: Search knowledge base for accurate answers
- **Tool Chaining**: Search first, then respond based on findings
- **Professional Prompting**: Clear instructions and fallback behavior
- **Easy Deployment**: One-click deployment to production API

## 🚀 Quick Start

### Option 1: Use Agent Studio (No Code)

1. Open [Agent Studio](https://toolhouse.ai/studio)
2. Paste this prompt:

```
Build a customer support agent for \"TechCorp Software\".

The agent should:
- Always search the knowledge base first using search_knowledge_base
- Provide helpful, accurate answers based on the search results
- If no relevant information is found, politely say so and offer to escalate
- Be professional but friendly in tone
- Ask clarifying questions when the user's request is unclear

Knowledge base contains:
- Product documentation
- Troubleshooting guides  
- Billing and account information
- Feature explanations

Test it with: \"How do I reset my password?\"
```

3. Click **\"Run\"** to test
4. Click **\"Deploy\"** when satisfied

### Option 2: Use CLI (Developer)

1. Clone this repository:
```bash
git clone https://github.com/Magnussmari/ultimate-toolhouse-guide.git
cd ultimate-toolhouse-guide/examples/customer-support
```

2. Deploy the agent:
```bash
th deploy customer-support-agent.yaml
```

3. Get your API endpoint and start using it!

## 📁 Files in This Example

```
customer-support/
├── README.md                  # This file
├── customer-support-agent.yaml    # Agent configuration
├── test-client.py            # Example client code
├── test-requests.http        # HTTP request examples
└── knowledge-base/           # Sample knowledge base files
    ├── password-reset.md
    ├── billing-faq.md
    └── troubleshooting.md
```

## 🔧 Agent Configuration

```yaml
title: \"TechCorp Customer Support Agent\"
prompt: |
  You are a helpful customer support agent for TechCorp Software. Your goal is to provide accurate, helpful responses to user questions.
  
  ALWAYS follow this process:
  1. First, use the search_knowledge_base tool to find relevant information
  2. If you find relevant information, provide a helpful answer based on the search results
  3. If no relevant information is found, politely explain this and offer to escalate to a human agent
  4. Be professional, friendly, and empathetic
  5. Ask clarifying questions if the user's request is unclear
  
  Knowledge base contains:
  - Product documentation and feature guides
  - Troubleshooting and technical support
  - Billing and account management
  - Company policies and procedures
  
  If a user seems frustrated, acknowledge their feelings and focus on solving their problem quickly.

model: \"@openai/gpt-4o-mini\"
public: false
bundles:
  - \"rag\"  # Enables search_knowledge_base tool
```

## 🧪 Testing Your Agent

### Test with Python

```python
import requests
import os

# Your deployed agent endpoint
AGENT_URL = \"https://api.toolhouse.ai/v1/agents/your-agent-id/runs\"

# Test questions
test_questions = [
    \"How do I reset my password?\",
    \"What's your refund policy?\",
    \"My app is crashing on startup, what should I do?\",
    \"How much does the Pro plan cost?\"
]

headers = {
    \"Authorization\": f\"Bearer {os.environ['TOOLHOUSE_API_KEY']}\",
    \"Content-Type\": \"application/json\"
}

for question in test_questions:
    response = requests.post(
        AGENT_URL,
        headers=headers,
        json={\"message\": question}
    )
    
    print(f\"Q: {question}\")
    print(f\"A: {response.json()['message']}\")
    print(\"-\" * 50)
```

### Test with curl

```bash
curl -X POST \"https://api.toolhouse.ai/v1/agents/your-agent-id/runs\" \\
  -H \"Authorization: Bearer $TOOLHOUSE_API_KEY\" \\
  -H \"Content-Type: application/json\" \\
  -d '{\"message\": \"How do I reset my password?\"}'
```

## 📚 Knowledge Base Setup

To populate the knowledge base with your own content:

1. **Upload Documents**: Use the Toolhouse dashboard to upload your documentation
2. **Connect to Agent**: Link your knowledge base to the agent in the configuration
3. **Test Search**: Verify the agent can find and use your content

### Sample Knowledge Base Structure

```markdown
# Password Reset Guide

## Self-Service Reset

1. Go to the login page
2. Click \"Forgot Password\"
3. Enter your email address
4. Check your email for reset instructions
5. Follow the link and create a new password

## Still Having Issues?

If you don't receive the email:
- Check your spam folder
- Verify the email address is correct
- Contact support at support@techcorp.com

## Security Tips

- Use a strong, unique password
- Enable two-factor authentication
- Don't share your password
```

## 🎨 Customization Ideas

### Enhance the Agent

1. **Multi-language Support**: Add language detection and response in user's language
2. **Sentiment Analysis**: Detect frustrated users and escalate automatically
3. **Integration**: Connect to your CRM or ticketing system
4. **Analytics**: Track common questions to improve documentation

### Advanced Prompting

```yaml
prompt: |
  You are Alex, a senior customer support specialist at TechCorp with 5 years of experience.
  
  Your personality:
  - Patient and empathetic
  - Technically knowledgeable but explains things simply
  - Proactive in suggesting solutions
  - Knows when to escalate complex issues
  
  Response format:
  - Start with a brief acknowledgment of the user's issue
  - Provide step-by-step solutions when applicable
  - End with a question to ensure the user is satisfied
  
  Example response style:
  \"I understand you're having trouble with password reset. Let me walk you through the process step by step...\"
```

## 🔄 Continuous Improvement

### Monitor Performance

1. **Analytics Dashboard**: Track response times and user satisfaction
2. **Knowledge Gaps**: Identify questions the agent can't answer
3. **User Feedback**: Collect ratings on agent responses

### Update Process

1. **Weekly Reviews**: Analyze common questions and gaps
2. **Knowledge Base Updates**: Add new documentation as needed
3. **Prompt Refinement**: Improve agent responses based on feedback
4. **A/B Testing**: Test different approaches with different user groups

## 🚀 Deployment Options

### Development
```bash
# Test locally
th run customer-support-agent.yaml

# Quick deploy for testing
th deploy customer-support-agent.yaml --public
```

### Production
```bash
# Deploy as private agent
th deploy customer-support-agent.yaml --private

# Set up monitoring
th logs customer-support-agent --follow
```

## 🎯 Next Steps

1. **Deploy this example** and test with your own questions
2. **Customize the prompt** for your specific business
3. **Upload your knowledge base** content
4. **Integrate into your website** or support system
5. **Monitor and improve** based on real usage

## 🔗 Related Examples

- [**Code Assistant**](../code-assistant/) - Interactive programming helper
- [**Job Search Agent**](../job-search/) - Automated job monitoring
- [**Market Research**](../market-research/) - Web scraping and analysis

---

**💡 Pro Tip**: Start simple with basic Q&A, then gradually add more sophisticated features like sentiment analysis and CRM integration as you learn what your users need most.