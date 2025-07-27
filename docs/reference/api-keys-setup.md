# 🔑 API Keys Setup Guide

> **Complete guide to setting up API keys for Toolhouse development** - Everything you need to get started

## 🚀 Quick Start (Essential Keys)

For most Toolhouse agents, you only need these two keys:

### 1. Toolhouse API Key (Required)
```bash
# Get your key from Toolhouse Dashboard
# 1. Visit: https://toolhouse.ai/dashboard/api-keys
# 2. Click \"Generate New Key\"
# 3. Copy the key (starts with \"th_\")

TOOLHOUSE_API_KEY=th_your_key_here
```

### 2. LLM Provider Key (Required)
```bash
# Most common: OpenAI (for GPT models)
# 1. Visit: https://platform.openai.com/api-keys
# 2. Click \"Create new secret key\"
# 3. Copy the key (starts with \"sk-\")

OPENAI_API_KEY=sk-your_openai_key_here
```

**That's it! These two keys will get you started with most agents.**

## 🎯 LLM Provider Keys

### OpenAI (Most Popular)
- **Where to get**: https://platform.openai.com/api-keys
- **Key format**: `sk-proj-...` or `sk-...`
- **Models**: `@openai/gpt-4o`, `@openai/gpt-4o-mini`, `@openai/o1-preview`
- **Pricing**: $0.15-$15 per 1M tokens (varies by model)
- **Setup**:
  ```bash
  # In your .env file
  OPENAI_API_KEY=sk-your_key_here
  ```

### Anthropic (Claude)
- **Where to get**: https://console.anthropic.com/
- **Key format**: `sk-ant-...`
- **Models**: `@anthropic/claude-sonnet-4`, `@anthropic/claude-haiku-3-5`
- **Pricing**: $3-$60 per 1M tokens (varies by model)
- **Setup**:
  ```bash
  ANTHROPIC_API_KEY=sk-ant-your_key_here
  ```

### Groq (High-Speed Inference)
- **Where to get**: https://console.groq.com/keys
- **Key format**: `gsk-...`
- **Models**: `@groq/llama-3.3-70b-versatile`, `@groq/mixtral-8x7b-32768`
- **Pricing**: Free tier available, very fast inference
- **Setup**:
  ```bash
  GROQ_API_KEY=gsk-your_key_here
  ```

### Google AI (Gemini)
- **Where to get**: https://aistudio.google.com/app/apikey
- **Key format**: Various formats
- **Models**: `@google/gemini-pro`, `@google/gemini-pro-vision`
- **Pricing**: Generous free tier
- **Setup**:
  ```bash
  GOOGLE_API_KEY=your_google_key_here
  ```

## 🛠️ Tool-Specific API Keys

### Communication Tools

#### Slack Integration
```bash
# For Slack bots and notifications
# 1. Create Slack app: https://api.slack.com/apps
# 2. Get Bot User OAuth Token

SLACK_BOT_TOKEN=xoxb-your_bot_token_here
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL
```

#### Email Services (SendGrid)
```bash
# For sending emails from agents
# 1. Sign up: https://sendgrid.com/
# 2. Create API key in dashboard

SENDGRID_API_KEY=SG.your_sendgrid_key_here
SENDGRID_FROM_EMAIL=noreply@yourdomain.com
```

### Data & Search Tools

#### Google Search
```bash
# For web search capabilities
# 1. Create project: https://console.developers.google.com/
# 2. Enable Custom Search API
# 3. Create search engine: https://cse.google.com/

GOOGLE_SEARCH_API_KEY=your_search_key_here
GOOGLE_SEARCH_ENGINE_ID=your_engine_id_here
```

#### Weather Data
```bash
# For weather information
# 1. Sign up: https://openweathermap.org/api
# 2. Get free API key

OPENWEATHER_API_KEY=your_weather_key_here
```

### Database Connections

#### PostgreSQL
```bash
# For database integration
DATABASE_URL=postgresql://username:password@localhost:5432/database_name
```

#### MongoDB
```bash
# For NoSQL database
MONGO_URL=mongodb://username:password@localhost:27017/database_name
```

### Cloud Storage

#### AWS S3
```bash
# For file storage and processing
# 1. Create AWS account: https://aws.amazon.com/
# 2. Create IAM user with S3 permissions
# 3. Generate access keys

AWS_ACCESS_KEY_ID=your_access_key_here
AWS_SECRET_ACCESS_KEY=your_secret_key_here
AWS_REGION=us-west-2
AWS_S3_BUCKET=your_bucket_name
```

## 📋 Setup Process

### Step 1: Copy Environment Template
```bash
# In your project directory
cp .env.example .env
```

### Step 2: Add Required Keys
```bash
# Edit .env file and add at minimum:
# - TOOLHOUSE_API_KEY
# - OPENAI_API_KEY (or your preferred LLM provider)
```

### Step 3: Secure Your Keys
```bash
# Set proper permissions
chmod 600 .env

# Verify .env is in .gitignore
echo \".env\" >> .gitignore
```

### Step 4: Test Your Setup
```bash
# Verify authentication
th whoami

# Test your agent
./scripts/test.sh
```

## 🔒 Security Best Practices

### Environment-Specific Keys
```bash
# Use different keys for each environment

# Development
OPENAI_API_KEY=sk-dev-your_dev_key_here

# Staging
OPENAI_API_KEY=sk-staging-your_staging_key_here

# Production
OPENAI_API_KEY=sk-prod-your_production_key_here
```

### Toolhouse Secret Management
```bash
# Store sensitive keys in Toolhouse (recommended for production)
th secrets add OPENAI_API_KEY=sk-your_key_here
th secrets add DATABASE_PASSWORD=your_secure_password

# Reference in agent.yaml
vars:
  api_key: \"${OPENAI_API_KEY}\"
  db_password: \"${DATABASE_PASSWORD}\"
```

### Key Rotation
```bash
# Regularly rotate API keys
# 1. Generate new key
# 2. Update .env file
# 3. Test agent
# 4. Deactivate old key
# 5. Deploy to production
```

## 🚨 Common Issues & Solutions

### Authentication Errors
```bash
# Problem: \"Invalid API key\"
# Solutions:
# 1. Check key format (OpenAI keys start with 'sk-')
# 2. Verify key is active in provider dashboard
# 3. Check for extra spaces or characters
# 4. Ensure key has required permissions
```

### Environment Loading Issues
```bash
# Problem: Environment variables not loading
# Solutions:
# 1. Check .env file exists
# 2. Verify file permissions (chmod 600 .env)
# 3. Check .env is in project root
# 4. Restart VS Code if using integrated terminal
```

### Rate Limiting
```bash
# Problem: \"Rate limit exceeded\"
# Solutions:
# 1. Check your API usage in provider dashboard
# 2. Implement exponential backoff
# 3. Consider upgrading to higher tier
# 4. Use multiple API keys with load balancing
```

## 💰 Cost Management

### Free Tiers Available
- **Groq**: Generous free tier with fast inference
- **Google AI**: Free Gemini usage
- **Toolhouse**: 50 agent runs/month on free plan
- **OpenWeather**: 1000 calls/day free
- **SendGrid**: 100 emails/day free

### Cost Monitoring
```bash
# Monitor usage
th account status
th usage --period month

# Set up billing alerts in provider dashboards
# Implement usage tracking in your agents
```

## 📚 Quick Reference Links

### API Key Dashboards
- [Toolhouse Dashboard](https://toolhouse.ai/dashboard/api-keys)
- [OpenAI API Keys](https://platform.openai.com/api-keys)
- [Anthropic Console](https://console.anthropic.com/)
- [Groq Console](https://console.groq.com/keys)
- [Google AI Studio](https://aistudio.google.com/app/apikey)

### Documentation
- [Toolhouse Docs](https://docs.toolhouse.ai/)
- [OpenAI API Docs](https://platform.openai.com/docs)
- [Anthropic API Docs](https://docs.anthropic.com/)
- [Slack API Docs](https://api.slack.com/)
- [AWS API Docs](https://docs.aws.amazon.com/)

---

**🔑 Remember: Start with just Toolhouse + OpenAI keys, then add others as needed for specific features!**"