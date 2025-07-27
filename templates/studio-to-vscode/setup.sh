#!/bin/bash

# Studio-to-VS Code Setup Script
# Creates a plug-and-play development environment for Toolhouse agents

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
AGENT_NAME=""
TEMPLATE="default"
PROJECT_DIR=""
USE_PYTHON="false"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Studio-to-VS Code Setup Script"
    echo "Creates a professional development environment for Toolhouse agents"
    echo ""
    echo "Usage: $0 <agent-name> [options]"
    echo ""
    echo "Arguments:"
    echo "  agent-name          Name for your agent project (required)"
    echo ""
    echo "Options:"
    echo "  --template TYPE     Use specific template (default: default)"
    echo "  --python           Include Python development setup with UV"
    echo "  --list-templates    Show available templates"
    echo "  --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 my-support-agent"
    echo "  $0 data-analyzer --template data-analyst --python"
    echo "  $0 --list-templates"
}

# Function to list available templates
list_templates() {
    echo "Available Templates:"
    echo ""
    echo "📞 customer-support  - Customer support agent with knowledge base"
    echo "📊 data-analyst      - Data analysis agent for CSV/JSON processing (--python recommended)"
    echo "🔍 code-reviewer     - Code review automation agent"
    echo "✍️  content-writer    - Content generation and marketing agent"
    echo "🔬 research-assistant - Web research and summarization agent (--python recommended)"
    echo "⚙️  default          - Basic agent template"
    echo ""
    echo "💡 Use --python flag for agents that need data processing or advanced tool integration"
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js first."
        exit 1
    fi
    
    # Check if npm is installed
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install npm first."
        exit 1
    fi
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_warning "Git is not installed. Version control will not be available."
    fi
    
    # Check if Toolhouse CLI is installed
    if ! command -v th &> /dev/null; then
        print_warning "Toolhouse CLI not found. Installing..."
        npm install -g @toolhouseai/cli
    fi
    
    # Check if UV is installed (if Python setup requested)
    if [[ "$USE_PYTHON" == "true" ]]; then
        if ! command -v uv &> /dev/null; then
            print_warning "UV not found. Installing UV (Python package manager)..."
            # Install UV using the official installer
            if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
                # Windows
                powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
            else
                # macOS/Linux
                curl -LsSf https://astral.sh/uv/install.sh | sh
                export PATH="$HOME/.cargo/bin:$PATH"
            fi
        fi
    fi
    
    print_success "Prerequisites check completed"
}

# Function to create project directory
create_project_directory() {
    PROJECT_DIR="${AGENT_NAME}-agent"
    
    if [[ -d "$PROJECT_DIR" ]]; then
        print_error "Directory '$PROJECT_DIR' already exists!"
        read -p "Do you want to overwrite it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Setup cancelled"
            exit 0
        fi
        rm -rf "$PROJECT_DIR"
    fi
    
    print_status "Creating project directory: $PROJECT_DIR"
    mkdir -p "$PROJECT_DIR"
    cd "$PROJECT_DIR"
}

# Function to create basic project structure
create_project_structure() {
    print_status "Creating project structure..."
    
    # Create directories
    mkdir -p .vscode scripts tests docs
    
    if [[ "$USE_PYTHON" == "true" ]]; then
        mkdir -p src tests
    fi
    
    # Create agent.yaml with template
    cat > agent.yaml << EOF
title: "${AGENT_NAME^} Agent"
prompt: |
  You are a helpful AI assistant named ${AGENT_NAME^}.
  
  Your role is to assist users with their requests in a friendly and professional manner.
  
  When responding:
  - Be clear and concise
  - Ask clarifying questions if needed
  - Provide step-by-step guidance when appropriate
  - Be helpful and supportive
  
  If you need to use external tools or data, explain what you're doing.

model: "@openai/gpt-4o-mini"
public: false
vars:
  environment: "development"
EOF
    
    print_success "Project structure created"
}

# Function to create Python project files (if requested)
create_python_project() {
    if [[ "$USE_PYTHON" != "true" ]]; then
        return
    fi
    
    print_status "Setting up Python project with UV..."
    
    # Initialize UV project
    uv init --name "${AGENT_NAME//-/_}" --no-readme
    
    # Create src directory structure
    mkdir -p "src/${AGENT_NAME//-/_}"
    
    # Move main.py to src directory and rename
    if [[ -f "main.py" ]]; then
        mv main.py "src/${AGENT_NAME//-/_}/__init__.py"
    fi
    
    # Create a proper main module
    cat > "src/${AGENT_NAME//-/_}/main.py" << EOF
"""${AGENT_NAME^} Agent - Main module."""

import sys
from pathlib import Path

# Add the project root to Python path for Toolhouse agent integration
project_root = Path(__file__).parent.parent.parent
sys.path.insert(0, str(project_root))


def main():
    """Main entry point for ${AGENT_NAME^} agent."""
    print(f"Hello from ${AGENT_NAME^} agent!")
    print("This Python module can be used alongside your Toolhouse agent.")
    
    # Example: Data processing, API calls, custom business logic
    # Your custom Python code goes here
    
    return "Agent completed successfully"


if __name__ == "__main__":
    main()
EOF
    
    # Update pyproject.toml for our use case
    cat > pyproject.toml << EOF
[project]
name = "${AGENT_NAME//-/_}"
version = "0.1.0"
description = "${AGENT_NAME^} agent with custom Python integration"
readme = "README.md"
requires-python = ">=3.9"
dependencies = [
    # Add your Python dependencies here
    # Example: "requests>=2.31.0",
    # Example: "pandas>=2.0.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "black>=23.0.0",
    "ruff>=0.1.0",
    "mypy>=1.0.0",
]
data = [
    "pandas>=2.0.0",
    "numpy>=1.24.0",
    "matplotlib>=3.7.0",
    "seaborn>=0.12.0",
]
web = [
    "requests>=2.31.0",
    "httpx>=0.25.0",
    "beautifulsoup4>=4.12.0",
]
ai = [
    "openai>=1.0.0",
    "anthropic>=0.7.0",
    "langchain>=0.1.0",
]

[project.scripts]
${AGENT_NAME//-/_} = "${AGENT_NAME//-/_}.main:main"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.uv]
dev-dependencies = [
    "pytest>=7.0.0",
    "black>=23.0.0",
    "ruff>=0.1.0",
    "mypy>=1.0.0",
]

[tool.black]
line-length = 88
target-version = ['py39']
include = '\.pyi?$'

[tool.ruff]
select = ["E", "F", "I", "N", "W"]
line-length = 88
target-version = "py39"

[tool.mypy]
python_version = "3.9"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
EOF
    
    # Create Python-specific test
    cat > "tests/test_${AGENT_NAME//-/_}.py" << EOF
"""Tests for ${AGENT_NAME^} agent."""

import pytest
from ${AGENT_NAME//-/_}.main import main


def test_main():
    """Test the main function."""
    result = main()
    assert result == "Agent completed successfully"


def test_agent_integration():
    """Test integration with Toolhouse agent."""
    # Add tests for your agent integration here
    pass
EOF
    
    print_success "Python project setup completed with UV"
}

# Function to create environment files
create_environment_files() {
    print_status "Creating environment configuration..."
    
    # Create .env.example
    cat > .env.example << EOF
# 🔑 Environment Variables for ${AGENT_NAME^} Agent
# Copy this file to .env and fill in your actual API keys
# Never commit .env to version control!

# =============================================================================
# TOOLHOUSE CONFIGURATION (Required)
# =============================================================================

# Your Toolhouse API key (required for CLI and SDK)
# Get this from: https://toolhouse.ai/dashboard/api-keys
TOOLHOUSE_API_KEY=your_toolhouse_api_key_here

# =============================================================================
# LLM PROVIDER API KEYS
# =============================================================================

# OpenAI API Key (most common)
# Get this from: https://platform.openai.com/api-keys
# Required for: @openai/gpt-4o, @openai/gpt-4o-mini, @openai/o1-preview, etc.
OPENAI_API_KEY=sk-your_openai_key_here

# Anthropic API Key
# Get this from: https://console.anthropic.com/
# Required for: @anthropic/claude-sonnet-4, @anthropic/claude-haiku-3-5, etc.
ANTHROPIC_API_KEY=sk-ant-your_anthropic_key_here

# Groq API Key (High-speed inference)
# Get this from: https://console.groq.com/keys
# Required for: @groq/llama-3.3-70b-versatile, @groq/mixtral-8x7b-32768, etc.
GROQ_API_KEY=gsk-your_groq_key_here

# =============================================================================
# AGENT CONFIGURATION
# =============================================================================

# Environment settings
ENVIRONMENT=development
DEBUG=true
LOG_LEVEL=info

# Default model configuration
DEFAULT_MODEL=@openai/gpt-4o-mini
MAX_TOKENS=4000
TEMPERATURE=0.7

# Agent behavior
MAX_RETRIES=3
TIMEOUT_SECONDS=30
EOF

if [[ "$USE_PYTHON" == "true" ]]; then
    cat >> .env.example << EOF

# =============================================================================
# PYTHON DEVELOPMENT
# =============================================================================

# Python environment
PYTHON_ENV=development
UV_CACHE_DIR=./.uv-cache

# Common Python service APIs (uncomment as needed)
# DATABASE_URL=postgresql://username:password@localhost:5432/database_name
# REDIS_URL=redis://localhost:6379
# SENDGRID_API_KEY=SG.your_sendgrid_key_here
EOF
fi

    cat >> .env.example << EOF

# =============================================================================
# QUICK SETUP GUIDE
# =============================================================================

# 1. Copy this file: cp .env.example .env
# 2. Get your Toolhouse API key: https://toolhouse.ai/dashboard/api-keys
# 3. Get your LLM provider key: https://platform.openai.com/api-keys
# 4. Fill in the keys above in your .env file
# 5. Test your setup: ./scripts/test.sh
EOF
    
    # Create .gitignore
    cat > .gitignore << EOF
# Environment variables
.env
.env.local
.env.*.local

# Dependencies
node_modules/
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
build/
dist/
*.egg-info/
.pytest_cache/

# UV Python package manager
.uv-cache/
.venv/
uv.lock
*.uv

# IDE
.vscode/settings.json
.idea/
*.swp
*.swo

# OS
.DS_Store
.DS_Store?
._*
Thumbs.db
ehthumbs.db

# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Toolhouse
.toolhouse/
api_keys.txt

# Testing
coverage/
.coverage
htmlcov/

# Temporary files
*.tmp
*.temp
.cache/
EOF
    
    print_success "Environment configuration created"
}

# Function to create VS Code configuration
create_vscode_config() {
    print_status "Creating VS Code configuration..."
    
    # Create VS Code settings
    cat > .vscode/settings.json << EOF
{
  "files.associations": {
    "*.th": "yaml",
    "agent.yaml": "yaml"
  },
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter"
  },
  "python.defaultInterpreterPath": "./.venv/bin/python",
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": ["tests"],
  "python.linting.enabled": true,
  "python.linting.ruffEnabled": true,
  "terminal.integrated.env.osx": {
    "TOOLHOUSE_API_KEY": "\${env:TOOLHOUSE_API_KEY}"
  },
  "terminal.integrated.env.linux": {
    "TOOLHOUSE_API_KEY": "\${env:TOOLHOUSE_API_KEY}"
  },
  "terminal.integrated.env.windows": {
    "TOOLHOUSE_API_KEY": "\${env:TOOLHOUSE_API_KEY}"
  }
}
EOF
    
    # Create VS Code tasks
    cat > .vscode/tasks.json << EOF
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Test Agent",
      "type": "shell",
      "command": "./scripts/test.sh",
      "group": {
        "kind": "test",
        "isDefault": true
      },
      "presentation": {
        "reveal": "always",
        "panel": "new"
      },
      "problemMatcher": []
    },
    {
      "label": "Deploy Agent",
      "type": "shell",
      "command": "./scripts/deploy.sh",
      "group": "build",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      },
      "problemMatcher": []
    },
    {
      "label": "Python: Install Dependencies",
      "type": "shell",
      "command": "uv sync",
      "group": "build",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      },
      "problemMatcher": [],
      "detail": "Install Python dependencies using UV"
    },
    {
      "label": "Python: Run Tests",
      "type": "shell",
      "command": "uv run pytest",
      "group": "test",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      },
      "problemMatcher": [],
      "detail": "Run Python tests using pytest"
    },
    {
      "label": "Python: Format Code",
      "type": "shell",
      "command": "uv run black src/ tests/",
      "group": "build",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      },
      "problemMatcher": [],
      "detail": "Format Python code using Black"
    },
    {
      "label": "Watch Mode",
      "type": "shell",
      "command": "./scripts/dev.sh",
      "group": "build",
      "isBackground": true,
      "presentation": {
        "reveal": "always",
        "panel": "dedicated"
      },
      "problemMatcher": []
    },
    {
      "label": "View Logs",
      "type": "shell",
      "command": "th logs --follow",
      "group": "none",
      "presentation": {
        "reveal": "always",
        "panel": "dedicated"
      },
      "problemMatcher": []
    }
  ]
}
EOF
    
    # Create VS Code launch configuration
    cat > .vscode/launch.json << EOF
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Agent (CLI)",
      "type": "node",
      "request": "launch",
      "program": "\${workspaceFolder}/node_modules/.bin/th",
      "args": ["run", "agent.yaml", "--debug"],
      "console": "integratedTerminal",
      "env": {
        "DEBUG": "true"
      }
    },
    {
      "name": "Python: Current File",
      "type": "python",
      "request": "launch",
      "program": "\${file}",
      "console": "integratedTerminal",
      "justMyCode": true
    },
    {
      "name": "Python: Debug Tests",
      "type": "python",
      "request": "launch",
      "module": "pytest",
      "args": ["-v", "tests/"],
      "console": "integratedTerminal",
      "justMyCode": false
    }
  ]
}
EOF
    
    # Create VS Code extensions recommendations
    cat > .vscode/extensions.json << EOF
{
  "recommendations": [
    "redhat.vscode-yaml",
    "ms-python.python",
    "ms-python.vscode-pylance",
    "ms-python.black-formatter",
    "charliermarsh.ruff",
    "esbenp.prettier-vscode",
    "eamodio.gitlens",
    "usernamehw.errorlens",
    "humao.rest-client",
    "ms-python.debugpy"
  ]
}
EOF
    
    print_success "VS Code configuration created"
}

# Function to create scripts
create_scripts() {
    print_status "Creating development scripts..."
    
    # Create test script
    cat > scripts/test.sh << 'EOF'
#!/bin/bash

# Test script for Toolhouse agent

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🧪 Testing Toolhouse Agent${NC}"
echo ""

# Check for .env file
if [ ! -f .env ]; then
    echo -e "${RED}❌ Error: .env file not found${NC}"
    echo "Please copy .env.example to .env and fill in your API keys"
    exit 1
fi

# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

# Validate required env vars
if [ -z "$TOOLHOUSE_API_KEY" ]; then
    echo -e "${RED}❌ Error: TOOLHOUSE_API_KEY not set${NC}"
    exit 1
fi

# Run Python tests if available
if [ -f "pyproject.toml" ]; then
    echo -e "${YELLOW}Running Python tests...${NC}"
    uv run pytest -v || true
    echo ""
fi

# Test the agent
echo -e "${YELLOW}Testing agent with CLI...${NC}"
th run agent.yaml --input "Hello, can you help me test that you're working correctly?"

echo ""
echo -e "${GREEN}✅ Agent test completed!${NC}"
EOF
    
    # Create deploy script
    cat > scripts/deploy.sh << 'EOF'
#!/bin/bash

# Deploy script for Toolhouse agent

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}🚀 Deploying Toolhouse Agent${NC}"
echo ""

# Check for .env file
if [ ! -f .env ]; then
    echo -e "${RED}❌ Error: .env file not found${NC}"
    exit 1
fi

# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

# Validate required env vars
if [ -z "$TOOLHOUSE_API_KEY" ]; then
    echo -e "${RED}❌ Error: TOOLHOUSE_API_KEY not set${NC}"
    exit 1
fi

# Run tests first
echo -e "${YELLOW}Running tests before deployment...${NC}"
./scripts/test.sh

# Deploy the agent
echo ""
echo -e "${YELLOW}Deploying agent...${NC}"
th deploy agent.yaml

echo ""
echo -e "${GREEN}✅ Agent deployed successfully!${NC}"
echo ""
echo "Your agent is now available at:"
echo "https://app.toolhouse.ai/agents"
EOF
    
    # Create development script
    cat > scripts/dev.sh << 'EOF'
#!/bin/bash

# Development script with watch mode

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}👁️  Starting development mode${NC}"
echo ""

# Check for .env file
if [ ! -f .env ]; then
    echo -e "${RED}❌ Error: .env file not found${NC}"
    exit 1
fi

# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

# Function to run tests
run_tests() {
    clear
    echo -e "${BLUE}[$(date '+%H:%M:%S')] Running tests...${NC}"
    ./scripts/test.sh
}

# Initial test run
run_tests

echo ""
echo -e "${YELLOW}Watching for changes...${NC}"
echo "Press Ctrl+C to stop"

# Watch for changes
if command -v fswatch &> /dev/null; then
    # macOS with fswatch
    fswatch -o agent.yaml src/ tests/ | while read f; do run_tests; done
elif command -v inotifywait &> /dev/null; then
    # Linux with inotify-tools
    while true; do
        inotifywait -r -e modify,create,delete agent.yaml src/ tests/
        run_tests
    done
else
    echo -e "${YELLOW}⚠️  File watching not available. Install fswatch (macOS) or inotify-tools (Linux)${NC}"
    echo "Running in manual mode - press Enter to re-run tests"
    while true; do
        read
        run_tests
    done
fi
EOF
    
    # Make scripts executable
    chmod +x scripts/*.sh
    
    print_success "Development scripts created"
}

# Function to create README
create_readme() {
    print_status "Creating project README..."
    
    cat > README.md << EOF
# ${AGENT_NAME^} Agent

A Toolhouse agent created with the Studio-to-VS Code workflow.

## 🚀 Quick Start

### Prerequisites

- Node.js and npm installed
- Toolhouse CLI: \`npm install -g @toolhouseai/cli\`
EOF

if [[ "$USE_PYTHON" == "true" ]]; then
    cat >> README.md << EOF
- UV Python package manager: \`curl -LsSf https://astral.sh/uv/install.sh | sh\`
EOF
fi

    cat >> README.md << EOF

### Setup

1. **Configure environment variables**
   \`\`\`bash
   cp .env.example .env
   # Edit .env and add your API keys
   \`\`\`

2. **Install dependencies**
EOF

if [[ "$USE_PYTHON" == "true" ]]; then
    cat >> README.md << EOF
   \`\`\`bash
   # Install Python dependencies
   uv sync
   \`\`\`
EOF
fi

    cat >> README.md << EOF

3. **Test the agent**
   \`\`\`bash
   ./scripts/test.sh
   \`\`\`

## 🛠️ Development

### VS Code Integration

This project includes full VS Code integration:

- **Tasks**: Use Ctrl+Shift+P → "Tasks: Run Task"
  - Test Agent
  - Deploy Agent
  - Watch Mode
  - View Logs
EOF

if [[ "$USE_PYTHON" == "true" ]]; then
    cat >> README.md << EOF
  - Python: Install Dependencies
  - Python: Run Tests
  - Python: Format Code
EOF
fi

    cat >> README.md << EOF

### Available Scripts

- \`./scripts/test.sh\` - Test the agent locally
- \`./scripts/deploy.sh\` - Deploy to Toolhouse cloud
- \`./scripts/dev.sh\` - Development mode with auto-reload

### Project Structure

\`\`\`
.
├── agent.yaml          # Agent configuration
├── .env.example        # Environment template
├── .vscode/            # VS Code configuration
├── scripts/            # Development scripts
EOF

if [[ "$USE_PYTHON" == "true" ]]; then
    cat >> README.md << EOF
├── src/                # Python source code
├── tests/              # Test files
├── pyproject.toml      # Python project config
EOF
fi

    cat >> README.md << EOF
└── README.md           # This file
\`\`\`

## 📝 Agent Configuration

Edit \`agent.yaml\` to customize your agent:

- \`title\`: Agent name displayed in the UI
- \`prompt\`: System prompt defining agent behavior
- \`model\`: LLM model to use (e.g., @openai/gpt-4o-mini)
- \`tools\`: External tools the agent can use
- \`vars\`: Custom variables for your agent

## 🚀 Deployment

Deploy your agent to Toolhouse cloud:

\`\`\`bash
./scripts/deploy.sh
\`\`\`

Your agent will be available at: https://app.toolhouse.ai/agents

## 📚 Resources

- [Toolhouse Documentation](https://docs.toolhouse.ai)
- [Agent Studio](https://toolhouse.ai/studio)
- [API Reference](https://docs.toolhouse.ai/api-reference)
EOF

if [[ "$USE_PYTHON" == "true" ]]; then
    cat >> README.md << EOF
- [UV Documentation](https://docs.astral.sh/uv/)
EOF
fi

    cat >> README.md << EOF

## 📄 License

This project is created with Toolhouse.
EOF
    
    print_success "README created"
}

# Function to create template-specific configurations
apply_template() {
    case "$TEMPLATE" in
        "customer-support")
            cat > agent.yaml << EOF
title: "${AGENT_NAME^} Customer Support Agent"
prompt: |
  You are a professional customer support agent for ${AGENT_NAME^}.
  
  Your responsibilities:
  - Respond to customer inquiries promptly and professionally
  - Provide accurate information about products and services
  - Help resolve customer issues and complaints
  - Escalate complex issues when necessary
  - Maintain a friendly and helpful tone
  
  Guidelines:
  - Always greet customers warmly
  - Listen carefully to understand their needs
  - Provide clear, step-by-step solutions
  - Follow up to ensure satisfaction
  - Document important interactions

model: "@openai/gpt-4o-mini"
public: false
tools:
  - name: "search_knowledge_base"
    description: "Search internal documentation and FAQs"
  - name: "create_ticket"
    description: "Create support ticket for follow-up"
  - name: "check_order_status"
    description: "Check customer order status"
vars:
  environment: "development"
  support_email: "support@example.com"
  business_hours: "9AM-5PM EST"
EOF
            ;;
            
        "data-analyst")
            cat > agent.yaml << EOF
title: "${AGENT_NAME^} Data Analysis Agent"
prompt: |
  You are an expert data analyst specializing in processing and analyzing various data formats.
  
  Your capabilities:
  - Analyze CSV, JSON, Excel, and other data files
  - Generate insights and visualizations
  - Perform statistical analysis
  - Create summary reports
  - Identify trends and patterns
  
  When analyzing data:
  - First understand the data structure
  - Check for data quality issues
  - Provide clear insights with supporting evidence
  - Suggest visualizations when appropriate
  - Summarize key findings

model: "@openai/gpt-4o"
public: false
tools:
  - name: "pandas_operations"
    description: "Perform data manipulation with pandas"
  - name: "create_visualization"
    description: "Generate charts and graphs"
  - name: "statistical_analysis"
    description: "Run statistical tests"
vars:
  environment: "development"
  max_file_size: "50MB"
  supported_formats: ["csv", "json", "xlsx", "parquet"]
EOF
            ;;
            
        "code-reviewer")
            cat > agent.yaml << EOF
title: "${AGENT_NAME^} Code Review Agent"
prompt: |
  You are an experienced code reviewer focused on improving code quality.
  
  Your review process includes:
  - Code style and formatting
  - Best practices and design patterns
  - Security vulnerabilities
  - Performance optimizations
  - Test coverage
  - Documentation completeness
  
  Provide feedback that is:
  - Constructive and specific
  - Backed by examples
  - Prioritized by severity
  - Educational when possible
  
  Support multiple languages and frameworks.

model: "@anthropic/claude-3-sonnet-20240229"
public: false
tools:
  - name: "analyze_code"
    description: "Perform static code analysis"
  - name: "check_security"
    description: "Scan for security issues"
  - name: "suggest_improvements"
    description: "Provide code improvement suggestions"
vars:
  environment: "development"
  languages: ["python", "javascript", "typescript", "java", "go"]
  severity_levels: ["critical", "major", "minor", "info"]
EOF
            ;;
            
        "content-writer")
            cat > agent.yaml << EOF
title: "${AGENT_NAME^} Content Writing Agent"
prompt: |
  You are a skilled content writer capable of creating engaging content for various purposes.
  
  Your expertise includes:
  - Blog posts and articles
  - Marketing copy
  - Social media content
  - Technical documentation
  - Email campaigns
  - SEO optimization
  
  Writing guidelines:
  - Match the requested tone and style
  - Use clear, engaging language
  - Include relevant keywords naturally
  - Structure content for readability
  - Fact-check all claims
  - Follow brand guidelines

model: "@openai/gpt-4o"
public: false
tools:
  - name: "research_topic"
    description: "Research topics for accurate content"
  - name: "check_seo"
    description: "Analyze SEO optimization"
  - name: "generate_images"
    description: "Create image prompts for content"
vars:
  environment: "development"
  content_types: ["blog", "social", "email", "landing_page"]
  tone_options: ["professional", "casual", "technical", "persuasive"]
EOF
            ;;
            
        "research-assistant")
            cat > agent.yaml << EOF
title: "${AGENT_NAME^} Research Assistant"
prompt: |
  You are a thorough research assistant skilled at gathering and synthesizing information.
  
  Your research process:
  - Identify credible sources
  - Gather comprehensive information
  - Verify facts and cross-reference
  - Synthesize findings clearly
  - Provide citations and sources
  - Highlight key insights
  
  Research guidelines:
  - Prioritize authoritative sources
  - Note any conflicting information
  - Distinguish facts from opinions
  - Provide balanced perspectives
  - Summarize complex topics clearly

model: "@anthropic/claude-3-opus-20240229"
public: false
tools:
  - name: "web_search"
    description: "Search the web for information"
  - name: "academic_search"
    description: "Search academic papers and journals"
  - name: "fact_check"
    description: "Verify claims and statistics"
  - name: "summarize_document"
    description: "Create summaries of long documents"
vars:
  environment: "development"
  max_sources: 10
  citation_format: "APA"
EOF
            ;;
    esac
    
    print_success "Applied $TEMPLATE template"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --template)
            TEMPLATE="$2"
            shift 2
            ;;
        --python)
            USE_PYTHON="true"
            shift
            ;;
        --list-templates)
            list_templates
            exit 0
            ;;
        --help|-h)
            show_usage
            exit 0
            ;;
        -*)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
        *)
            if [[ -z "$AGENT_NAME" ]]; then
                AGENT_NAME="$1"
            else
                print_error "Unexpected argument: $1"
                show_usage
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate agent name
if [[ -z "$AGENT_NAME" ]]; then
    print_error "Agent name is required"
    show_usage
    exit 1
fi

# Validate agent name format
if [[ ! "$AGENT_NAME" =~ ^[a-zA-Z][a-zA-Z0-9-]*$ ]]; then
    print_error "Agent name must start with a letter and contain only letters, numbers, and hyphens"
    exit 1
fi

# Main execution
print_status "Setting up Toolhouse agent: $AGENT_NAME"
print_status "Template: $TEMPLATE"
if [[ "$USE_PYTHON" == "true" ]]; then
    print_status "Python setup: Enabled (using UV)"
else
    print_status "Python setup: Disabled"
fi
echo ""

check_prerequisites
create_project_directory
create_project_structure
create_python_project
create_environment_files
create_vscode_config
create_scripts
create_readme

# Apply template if not default
if [[ "$TEMPLATE" != "default" ]]; then
    apply_template
fi

# Final success message
echo ""
print_success "🎉 Project setup complete!"
echo ""
echo "Next steps:"
echo "1. cd $PROJECT_DIR"
echo "2. Copy .env.example to .env and add your API keys"
echo "3. Open in VS Code: code ."
echo "4. Test your agent: ./scripts/test.sh"
echo "5. Deploy when ready: ./scripts/deploy.sh"
echo ""
echo "Happy coding! 🚀"