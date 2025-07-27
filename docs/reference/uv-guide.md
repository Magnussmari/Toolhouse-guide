# 🐍 UV Python Package Manager Guide

> **The fastest Python package manager for Toolhouse development** - 10-100x faster than pip, built in Rust

## 🚀 What is UV?

UV is a modern, high-performance Python package manager and project manager written in Rust. It's designed to replace pip, venv, poetry, pyenv, and other Python tools with a single, blazing-fast solution.

### Why UV for Toolhouse Agents?

- **⚡ Speed**: 10-100x faster than pip/poetry
- **🔧 All-in-one**: Replaces multiple tools (pip, venv, poetry, pyenv)
- **🔒 Reliable**: Lock files ensure reproducible environments
- **🌐 Standards compliant**: Uses pyproject.toml and modern Python standards
- **🛠️ Perfect for agents**: Ideal for data processing, API integrations, custom logic

## 📦 Installation

### Quick Install (Recommended)

```bash
# macOS/Linux - Official installer
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows - PowerShell
powershell -ExecutionPolicy ByPass -c \"irm https://astral.sh/uv/install.ps1 | iex\"

# Alternative: Install with pip (if you have Python)
pip install uv

# Alternative: Install with pipx
pipx install uv
```

### Verify Installation

```bash
uv --version
# Should output: uv 0.8.3 or newer
```

## 🚀 Quick Start

### Create a New Python Project

```bash
# Create new project
uv init my-agent
cd my-agent

# Project structure created:
# ├── .python-version
# ├── main.py
# ├── pyproject.toml
# └── README.md
```

### Add Dependencies

```bash
# Add production dependencies
uv add requests pandas

# Add development dependencies
uv add --dev pytest black ruff

# Add optional dependency groups
uv add --optional ai openai anthropic
```

### Run Your Code

```bash
# Run Python script
uv run python main.py

# Run commands in project environment
uv run pytest
uv run black .
uv run ruff check

# Install and run tools temporarily
uvx black .  # Run black without installing globally
```

## 📋 Essential Commands

### Project Management

```bash
# Create new project
uv init my-project              # Full project with structure
uv init --bare my-project       # Minimal project (just pyproject.toml)
uv init --app my-app            # Application with CLI entry point
uv init --lib my-package        # Library package

# Add to existing directory
cd existing-project
uv init --name my-project       # Initialize in current directory
```

### Dependency Management

```bash
# Add dependencies
uv add package-name              # Latest version
uv add \"package>=1.0,<2.0\"      # Version constraints
uv add package --dev            # Development dependency
uv add package --optional ai    # Optional dependency group
uv add git+https://github.com/owner/repo.git  # Git dependency

# Remove dependencies
uv remove package-name
uv remove package-name --dev

# Upgrade dependencies
uv add package-name --upgrade   # Upgrade specific package
uv lock --upgrade               # Upgrade all packages
```

### Environment Management

```bash
# Create virtual environment
uv venv                         # Create .venv in current directory
uv venv --python 3.12          # Specific Python version
uv venv my-env                  # Custom environment name

# Synchronize environment
uv sync                         # Install all dependencies
uv sync --dev                   # Include dev dependencies
uv sync --extra ai              # Include optional groups
uv sync --frozen                # Use exact versions from lock file

# Run commands in environment
uv run python script.py         # Run Python
uv run pytest                   # Run any command
uv run --env-file .env python script.py  # With environment file
```

### Python Version Management

```bash
# Install Python versions
uv python install 3.12          # Install Python 3.12
uv python install 3.11 3.12     # Install multiple versions
uv python install pypy@3.10     # Install PyPy

# List Python versions
uv python list                   # Available versions
uv python list --installed       # Installed versions

# Set Python version for project
uv python pin 3.12              # Pin to specific version
echo \"3.12\" > .python-version    # Alternative method
```

### Lock Files and Reproducibility

```bash
# Generate/update lock file
uv lock                          # Create/update uv.lock
uv lock --upgrade                # Upgrade all dependencies

# Export to other formats
uv export --format requirements.txt > requirements.txt
uv export --format requirements.txt --extra dev > dev-requirements.txt

# Import from other formats
uv add -r requirements.txt       # Add from requirements.txt
```

## 🛠️ Toolhouse Integration Patterns

### Agent + Python Hybrid

```bash
# Setup for Toolhouse agent with Python processing
uv init data-processor
cd data-processor

# Add Toolhouse-friendly dependencies
uv add pandas numpy requests httpx
uv add --dev pytest black ruff mypy

# Create agent integration
touch agent.yaml  # Your Toolhouse agent config
mkdir src/data_processor
```

### Project Structure for Agents

```
my-agent/
├── agent.yaml                  # Toolhouse agent configuration
├── pyproject.toml              # UV Python project
├── uv.lock                     # Dependency lock file
├── .python-version             # Python version
├── src/
│   └── my_agent/
│       ├── __init__.py
│       ├── main.py             # Main Python logic
│       ├── data_processor.py   # Data processing
│       └── api_client.py       # API integrations
├── tests/
│   ├── test_main.py           # Python tests
│   └── test_agent.py          # Agent integration tests
└── scripts/
    ├── test.sh                # Combined testing
    └── deploy.sh              # Deployment
```

### Common Agent Patterns

#### Data Processing Agent

```bash
# Setup
uv add pandas numpy matplotlib seaborn
uv add --dev jupyter notebook

# pyproject.toml
[project.optional-dependencies]
data = [\"pandas\", \"numpy\", \"matplotlib\", \"seaborn\"]
notebooks = [\"jupyter\", \"notebook\", \"ipykernel\"]
```

#### API Integration Agent

```bash
# Setup
uv add requests httpx aiohttp
uv add --dev responses httpx-mock pytest-asyncio

# pyproject.toml
[project.optional-dependencies]
api = [\"requests\", \"httpx\", \"aiohttp\"]
testing = [\"responses\", \"httpx-mock\", \"pytest-asyncio\"]
```

#### AI/ML Agent

```bash
# Setup
uv add openai anthropic langchain
uv add --optional ml torch transformers scikit-learn

# pyproject.toml
[project.optional-dependencies]
ai = [\"openai\", \"anthropic\", \"langchain\"]
ml = [\"torch\", \"transformers\", \"scikit-learn\"]
```

## ⚙️ Configuration

### pyproject.toml Configuration

```toml
[project]
name = \"my-toolhouse-agent\"
version = \"0.1.0\"
description = \"Toolhouse agent with Python integration\"
readme = \"README.md\"
requires-python = \">=3.9\"
dependencies = [
    \"requests>=2.31.0\",
    \"pandas>=2.0.0\",
]

[project.optional-dependencies]
dev = [
    \"pytest>=7.0.0\",
    \"black>=23.0.0\",
    \"ruff>=0.1.0\",
    \"mypy>=1.0.0\",
]
data = [
    \"numpy>=1.24.0\",
    \"matplotlib>=3.7.0\",
    \"seaborn>=0.12.0\",
]
ai = [
    \"openai>=1.0.0\",
    \"anthropic>=0.7.0\",
    \"langchain>=0.1.0\",
]

[project.scripts]
my-agent = \"my_agent.main:main\"

[build-system]
requires = [\"hatchling\"]
build-backend = \"hatchling.build\"

# UV-specific configuration
[tool.uv]
dev-dependencies = [
    \"pytest>=7.0.0\",
    \"black>=23.0.0\",
    \"ruff>=0.1.0\",
]

# Tool configurations
[tool.black]
line-length = 88
target-version = ['py39']

[tool.ruff]
select = [\"E\", \"F\", \"I\", \"N\", \"W\"]
line-length = 88
target-version = \"py39\"

[tool.pytest.ini_options]
pythonpath = [\"src\"]
testpaths = [\"tests\"]
```

### Global UV Configuration

```bash
# UV configuration file: ~/.config/uv/config.toml
mkdir -p ~/.config/uv

cat > ~/.config/uv/config.toml << EOF
[global]
index-url = \"https://pypi.org/simple\"
extra-index-url = [\"https://download.pytorch.org/whl/cpu\"]

[pip]
no-deps = false
break-system-packages = false

[tool]
environment = \"uv\"
EOF
```

## 🔄 Migration Guide

### From pip + requirements.txt

```bash
# Old workflow
pip install -r requirements.txt
pip install -r dev-requirements.txt
python script.py

# New UV workflow
uv init --bare  # Creates pyproject.toml
uv add -r requirements.txt
uv add -r dev-requirements.txt --dev
uv run python script.py
```

### From Poetry

```bash
# Poetry uses pyproject.toml - mostly compatible!
# Copy [project] and [project.optional-dependencies] sections
# Then:
uv lock  # Generate uv.lock from pyproject.toml
uv sync  # Install dependencies

# Replace poetry commands:
# poetry install → uv sync
# poetry add pkg → uv add pkg
# poetry run cmd → uv run cmd
```

### From Conda

```bash
# Extract package names from environment.yml
# Add them with UV:
uv add package1 package2 package3

# For conda-specific packages, use conda-forge:
uv add --index-url https://conda.anaconda.org/conda-forge package
```

## 🧪 Testing and Development

### Test Setup

```bash
# Add testing dependencies
uv add --dev pytest pytest-cov pytest-mock

# For async testing
uv add --dev pytest-asyncio

# For web testing
uv add --dev httpx-mock responses
```

### Running Tests

```bash
# Run tests
uv run pytest

# With coverage
uv run pytest --cov=src --cov-report=html

# Run specific tests
uv run pytest tests/test_main.py::test_function

# Watch mode (with pytest-watch)
uv add --dev pytest-watch
uv run ptw
```

### Code Quality

```bash
# Format code
uv run black src tests

# Lint code
uv run ruff check src tests

# Type checking
uv run mypy src

# All quality checks
uv run black src tests && uv run ruff check src tests && uv run mypy src
```

## 🚀 Deployment Patterns

### Docker with UV

```dockerfile
# Dockerfile
FROM python:3.12-slim

# Install UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Set working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml uv.lock ./
COPY src/ ./src/

# Install dependencies
RUN uv sync --frozen --no-dev

# Run application
CMD [\"uv\", \"run\", \"python\", \"-m\", \"my_agent.main\"]
```

### GitHub Actions with UV

```yaml
# .github/workflows/test.yml
name: Test Python Agent

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [\"3.9\", \"3.10\", \"3.11\", \"3.12\"]
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Install UV
      uses: astral-sh/setup-uv@v3
      with:
        version: \"latest\"
    
    - name: Set up Python
      run: uv python install ${{ matrix.python-version }}
    
    - name: Install dependencies
      run: uv sync --all-extras --dev
    
    - name: Run tests
      run: uv run pytest
    
    - name: Run linting
      run: uv run ruff check .
    
    - name: Run formatting check
      run: uv run black --check .
```

### Production Environment

```bash
# Production deployment
export UV_CACHE_DIR=/tmp/uv-cache
export PYTHONPATH=/app/src

# Install production dependencies only
uv sync --frozen --no-dev

# Run application
uv run python -m my_agent.main
```

## 🔧 Advanced Features

### Dependency Resolution

```bash
# Override dependency versions
uv add 'package==1.0.0' --override

# Use alternative resolution strategies
uv lock --resolution lowest-direct  # Use lowest compatible versions
uv lock --resolution highest        # Use highest compatible versions

# Pre-release versions
uv add package --prerelease allow
```

### Environment Variables

```bash
# UV environment variables
export UV_CACHE_DIR=\"/custom/cache/dir\"
export UV_INDEX_URL=\"https://custom-pypi.com/simple\"
export UV_EXTRA_INDEX_URL=\"https://additional-index.com/simple\"
export UV_NO_CACHE=1  # Disable caching
export UV_OFFLINE=1   # Offline mode
```

### Global Tools

```bash
# Install global tools
uv tool install black
uv tool install ruff
uv tool install pytest

# Run tools globally
uv tool run black .
uvx black .  # Shorthand

# List installed tools
uv tool list

# Update tools
uv tool upgrade black
```

## 🐛 Troubleshooting

### Common Issues

#### UV Not Found
```bash
# Add UV to PATH
export PATH=\"$HOME/.cargo/bin:$PATH\"
echo 'export PATH=\"$HOME/.cargo/bin:$PATH\"' >> ~/.bashrc
source ~/.bashrc
```

#### Permission Issues
```bash
# Fix ownership (Linux/macOS)
sudo chown -R $USER ~/.local/share/uv
sudo chown -R $USER ~/.cache/uv

# Windows: Run as administrator or use User directory
```

#### Dependency Conflicts
```bash
# Clear cache and reinstall
uv cache clean
uv sync --reinstall

# Use different resolution strategy
uv lock --resolution lowest-direct
```

#### Python Version Issues
```bash
# Install required Python version
uv python install 3.12

# Check available versions
uv python list

# Pin project to specific version
uv python pin 3.12
```

### Debug Mode

```bash
# Enable verbose output
export UV_VERBOSE=1
uv sync

# Show resolution details
uv lock --verbose

# Check UV configuration
uv config
```

## 📚 UV vs Other Tools

| Feature | UV | pip | poetry | conda |
|---------|----|----|-----------|-------|
| **Speed** | ⚡ 10-100x faster | Baseline | 2-5x slower | 5-10x slower |
| **Lock files** | ✅ uv.lock | ❌ | ✅ poetry.lock | ✅ environment.yml |
| **Python management** | ✅ Built-in | ❌ | ❌ | ✅ |
| **Virtual envs** | ✅ Auto-managed | ❌ Manual | ✅ Auto-managed | ✅ Built-in |
| **Standards compliance** | ✅ PEP 621 | ❌ | ✅ PEP 621 | ❌ |
| **Tool installation** | ✅ uvx | ❌ | ❌ | ✅ |
| **Cross-platform** | ✅ | ✅ | ✅ | ✅ |

## 🎯 Best Practices for Toolhouse Agents

### Project Organization

```
toolhouse-agent/
├── agent.yaml              # Toolhouse agent config
├── pyproject.toml          # Python project config
├── uv.lock                 # Dependency lock file
├── .python-version         # Python version pin
├── .env.example            # Environment template
├── src/
│   └── agent_name/
│       ├── __init__.py
│       ├── main.py         # Entry point
│       ├── processors/     # Data processing modules
│       ├── integrations/   # API clients
│       └── utils/          # Utility functions
├── tests/
│   ├── test_main.py
│   ├── test_processors.py
│   └── test_integrations.py
└── scripts/
    ├── setup.sh            # Environment setup
    ├── test.sh             # Run tests
    └── deploy.sh           # Deploy agent
```

### Dependency Management

```bash
# Keep dependencies minimal in main project
uv add only-essential-packages

# Use optional groups for different features
uv add --optional data pandas numpy
uv add --optional ai openai anthropic
uv add --optional web fastapi uvicorn

# Use dev dependencies for tooling
uv add --dev pytest black ruff mypy
```

### Development Workflow

```bash
# Daily workflow
uv sync                     # Sync dependencies
uv run python -m agent.main  # Run agent
uv run pytest              # Test
uv run black .              # Format
uv run ruff check .         # Lint

# Before commit
uv lock                     # Update lock file
uv export --format requirements.txt > requirements.txt  # For compatibility
```

## 🔗 Resources

- [UV Official Documentation](https://docs.astral.sh/uv/)
- [UV GitHub Repository](https://github.com/astral-sh/uv)
- [Python Packaging Guide](https://packaging.python.org/)
- [PEP 621 - Project Metadata](https://peps.python.org/pep-0621/)
- [Toolhouse Python Integration Examples](../examples/)

---

**🐍 UV makes Python development for Toolhouse agents fast, reliable, and enjoyable!**"