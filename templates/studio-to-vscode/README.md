# 🔄 Studio-to-VS Code Development Template

> **Seamless transition from Agent Studio to professional development** - Start with natural language, continue with code

## 🎯 What This Template Provides

This template enables a smooth workflow from Toolhouse Agent Studio (no-code) to VS Code (professional development), following industry best practices:

- **🎨 Start in Agent Studio**: Build and test your agent with natural language
- **📁 Export to structured project**: Get a complete, ready-to-code project structure
- **🔧 Continue in VS Code**: Professional development with CLI, Git, and deployment
- **🐍 Python integration**: Optional UV-powered Python setup for advanced agents
- **🚀 Deploy with confidence**: Production-ready setup from day one

## 🚀 Quick Start Workflow

### Phase 1: Agent Studio (5-10 minutes)

1. **Create in Agent Studio**
   ```
   Open: https://toolhouse.ai/studio
   
   Prompt: "Build a [YOUR_AGENT_TYPE] agent that [DESCRIPTION].
   
   The agent should:
   - [Feature 1]
   - [Feature 2] 
   - [Feature 3]
   
   Test it with: [TEST_QUESTION]"
   ```

2. **Test and Refine**
   - Run the agent with test questions
   - Refine the prompt until satisfied
   - Note the generated YAML configuration

3. **Export Configuration**
   - Copy the generated `.th` file content
   - Note any custom variables or settings

### Phase 2: VS Code Setup (2-3 minutes)

1. **Clone this template**
   ```bash
   git clone https://github.com/Magnussmari/ultimate-toolhouse-guide.git
   cd ultimate-toolhouse-guide/templates/studio-to-vscode
   ```

2. **Run the setup script**
   ```bash
   # Basic agent setup
   ./setup.sh "your-agent-name"
   
   # With Python integration (recommended for data/research agents)
   ./setup.sh "your-agent-name" --python
   ```

3. **Open in VS Code**
   ```bash
   cd your-agent-name-agent
   code .
   ```

### Phase 3: Professional Development (Ongoing)

1. **Replace template agent with your Agent Studio export**
2. **Use built-in development workflow**
3. **Deploy and iterate**

## 📁 Project Structure

### Basic Agent Structure
```
your-agent-project/
├── 📄 README.md                 # Project documentation
├── ⚙️ agent.yaml               # Your Toolhouse agent configuration
├── 🔧 .env.example             # Environment variables template
├── 📋 .vscode/
│   ├── settings.json           # VS Code project settings
│   ├── tasks.json              # Toolhouse CLI tasks
│   ├── launch.json             # Debugging configuration
│   └── extensions.json         # Recommended extensions
├── 🔄 scripts/
│   ├── dev.sh                  # Development workflow
│   ├── test.sh                 # Testing script
│   └── deploy.sh               # Deployment script
├── 🧪 tests/
│   ├── test-scenarios.yaml     # Test cases for your agent
│   └── run-tests.sh            # Test runner
└── 🔒 .gitignore               # Git ignore rules
```

### With Python Integration (--python flag)
```
your-agent-project/
├── 📄 README.md
├── ⚙️ agent.yaml               # Toolhouse agent config
├── 🐍 pyproject.toml           # UV Python project config
├── 🔒 uv.lock                  # Dependency lock file
├── 📁 src/
│   └── your_agent/
│       ├── __init__.py
│       └── main.py             # Custom Python logic
├── 🧪 tests/
│   ├── test_agent.py           # Python tests
│   └── test-scenarios.yaml     # Agent integration tests
├── 📋 .vscode/                 # Enhanced for Python
└── 🔄 scripts/                 # UV-aware scripts
```

## 🐍 Python Integration with UV

### Why UV?
UV is the next-generation Python package manager (10-100x faster than pip):
- **⚡ Blazing fast**: 10-100x faster than pip/poetry
- **🔧 All-in-one**: Replaces pip, venv, poetry, pyenv in one tool
- **🔒 Reliable**: Lock files ensure reproducible environments
- **🌐 Modern**: Built in Rust, follows latest Python standards

### When to Use Python Integration

Use `--python` flag for agents that need:
- **📊 Data processing**: CSV/JSON analysis, pandas operations
- **🔬 Research tasks**: Web scraping, API integrations
- **🧮 Custom algorithms**: Complex business logic, calculations
- **🔌 Advanced integrations**: Database connections, file processing

### Python Development Workflow

```bash
# Setup with Python
./setup.sh "data-analyzer" --python
cd data-analyzer-agent

# Install Python dependencies
uv add pandas requests matplotlib

# Add development dependencies
uv add --dev pytest black ruff mypy

# Run your Python code
uv run python src/data_analyzer/main.py

# Test everything (Python + Agent)
./scripts/test.sh

# Deploy agent with Python integration
./scripts/deploy.sh
```

## 🛠️ VS Code Integration Features

### Built-in Tasks (Ctrl+Shift+P → "Tasks")

| Task | Shortcut | Description |
|------|----------|-------------|
| **Test Agent** | `Ctrl+Shift+T` | Run your agent locally with test scenarios |
| **Deploy Agent** | `Ctrl+Shift+D` | Deploy to Toolhouse cloud |
| **Python: Install Deps** | - | Install Python dependencies with UV |
| **Python: Run Tests** | - | Run Python tests with pytest |
| **Python: Format Code** | - | Format Python code with Black |
| **Watch Mode** | `Ctrl+Shift+W` | Auto-reload on file changes |
| **View Logs** | `Ctrl+Shift+L` | Stream agent execution logs |

### Recommended Extensions (Auto-installed)

#### For All Projects:
- **YAML Support**: Syntax highlighting and validation for `.th` files
- **Toolhouse CLI**: Integration with th commands
- **GitLens**: Enhanced Git integration
- **Error Lens**: Inline error highlighting
- **REST Client**: Test your deployed agent API

#### For Python Projects:
- **Python**: Official Python extension
- **Pylance**: Fast Python language server
- **Black Formatter**: Code formatting
- **Ruff**: Fast Python linting
- **Python Test Explorer**: Test discovery and running

## 🔄 Development Workflows

### Agent-Only Workflow
```bash
# 1. Edit agent.yaml in VS Code
# 2. Test locally
./scripts/test.sh

# 3. Deploy when ready
./scripts/deploy.sh
```

### Python + Agent Workflow
```bash
# 1. Develop Python logic
vim src/your_agent/main.py

# 2. Test Python code
uv run pytest

# 3. Test agent integration
./scripts/test.sh

# 4. Format and lint
uv run black src/
uv run ruff check src/

# 5. Deploy everything
./scripts/deploy.sh
```

### Development Mode (Auto-reload)
```bash
# Watch for changes and auto-test
./scripts/dev.sh

# In another terminal, make changes to:
# - agent.yaml (agent config)
# - src/ (Python code)
# - tests/ (test scenarios)
```

## 📋 Pre-configured Templates

### Available Agent Templates

| Template | Use Case | Python? | Agent Studio Prompt |
|----------|----------|---------|---------------------|
| **customer-support** | Help desk automation | Optional | "Build a customer support agent with knowledge base search..." |
| **data-analyst** | CSV/JSON analysis | ✅ Recommended | "Build a data analysis agent that can process uploaded files..." |
| **research-assistant** | Web research | ✅ Recommended | "Build a research agent that can search and summarize topics..." |
| **code-reviewer** | Code review automation | Optional | "Build a code review agent that analyzes pull requests..." |
| **content-writer** | Content generation | Optional | "Build a content writing agent for blog posts and marketing..." |

### Using Templates

```bash
# Use specific template
./setup.sh "my-agent" --template customer-support

# Use template with Python
./setup.sh "my-agent" --template data-analyst --python

# List available templates
./setup.sh --list-templates
```

## 🐍 UV Package Manager Guide

### Essential UV Commands

```bash
# Project management
uv init my-project              # Create new Python project
uv add requests pandas          # Add dependencies
uv add --dev pytest black       # Add dev dependencies
uv remove old-package           # Remove dependencies

# Environment management
uv venv                          # Create virtual environment
uv sync                          # Install all dependencies
uv run python script.py         # Run Python in project env
uv run pytest                   # Run commands in project env

# Python version management
uv python install 3.12          # Install Python 3.12
uv python pin 3.11              # Pin project to Python 3.11
uv python list                   # List installed Python versions

# Lock file management
uv lock                          # Update uv.lock file
uv export --format requirements.txt > requirements.txt
```

### Dependency Groups

```toml
# pyproject.toml
[project]
dependencies = [
    "requests",  # Production dependencies
]

[project.optional-dependencies]
dev = ["pytest", "black", "ruff"]    # Development tools
data = ["pandas", "numpy", "matplotlib"]  # Data science
web = ["fastapi", "uvicorn", "httpx"]      # Web development
ai = ["openai", "anthropic", "langchain"]  # AI/ML tools
```

```bash
# Install specific groups
uv sync --extra dev              # Install dev dependencies
uv sync --extra data             # Install data science tools
uv sync --extra dev --extra ai   # Install multiple groups
```

### Migration from pip/poetry

```bash
# From requirements.txt
uv add -r requirements.txt

# From poetry (copy dependencies from pyproject.toml)
# UV uses the same pyproject.toml format!

# From conda environment.yml
# Extract package names and add with uv add
```

## 🔧 Advanced Configuration

### Custom Python Setup

```toml
# pyproject.toml
[tool.uv]
dev-dependencies = [
    "pytest>=7.0.0",
    "black>=23.0.0",
    "ruff>=0.1.0",
]

[tool.black]
line-length = 88
target-version = ['py39']

[tool.ruff]
select = ["E", "F", "I", "N", "W"]
line-length = 88

[tool.pytest.ini_options]
pythonpath = ["src"]
testpaths = ["tests"]
```

### VS Code Python Settings

```json
// .vscode/settings.json
{
  "python.defaultInterpreterPath": "./.venv/bin/python",
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": ["tests"],
  "python.formatting.provider": "black",
  "python.linting.ruffEnabled": true,
  "python.linting.enabled": true
}
```

## 🚨 Troubleshooting

### Common UV Issues

```bash
# UV not found after installation
source ~/.bashrc  # or restart terminal
export PATH="$HOME/.cargo/bin:$PATH"

# Permission denied (macOS/Linux)
sudo chown -R $USER ~/.local/share/uv

# Python version not found
uv python install 3.12  # Install specific version
uv python list           # Check available versions

# Dependencies not installing
uv sync --reinstall      # Force reinstall
uv cache clean           # Clear UV cache
```

### VS Code Python Issues

```bash
# Python interpreter not detected
# Ctrl+Shift+P → "Python: Select Interpreter"
# Choose: ./venv/bin/python

# Tests not running
# Ctrl+Shift+P → "Python: Configure Tests"
# Select: pytest, tests/ directory

# Imports not working
# Check python.pythonPath in VS Code settings
# Ensure src/ is in PYTHONPATH
```

## 🎓 Learning Path

### For Beginners
1. Start with basic setup (no Python): `./setup.sh "my-agent"`
2. Learn agent.yaml configuration
3. Add Python when needed: `./setup.sh "my-agent" --python`
4. Gradually explore UV commands

### For Python Developers
1. Use Python setup: `./setup.sh "my-agent" --python`
2. Migrate from pip/poetry to UV
3. Integrate existing Python code
4. Set up CI/CD with UV

### For Teams
1. Standardize on UV for all Python projects
2. Use dependency groups for different roles
3. Commit uv.lock files for reproducibility
4. Set up shared development workflows

## 🔗 Related Resources

- [Agent Studio Guide](../../docs/03-agent-studio.md)
- [CLI Developer Guide](../../docs/04-developer-workflow.md)
- [VS Code Copilot with MCP](https://code.visualstudio.com/docs/copilot/overview)
- [UV Official Documentation](https://docs.astral.sh/uv/)
- [Python Project Standards (PEP 621)](https://peps.python.org/pep-0621/)
- [Toolhouse Best Practices](../../docs/reference/best-practices.md)

---

**🎯 This template bridges the gap between no-code Agent Studio and professional development, with optional Python integration powered by UV - the fastest Python package manager!**
