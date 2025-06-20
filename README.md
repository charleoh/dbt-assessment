# dbt Pipeline Assessment

A modern data pipeline built with dbt and DuckDB, featuring automated testing and deployment through GitHub Actions.

## 📋 Project Documentation

- **[Assessment Instructions](docs/instructions.md)** - Original requirements and evaluation criteria
- **[Output Description](docs/output-description.md)** - Provided explanation of deliverables and results
- **[Decision Tracking](docs/decisions.md)** - Architectural decisions and rationale behind implementation choices

## 🚀 Quick Start

### Prerequisites

- Python 3.10+
- Git
- Make (usually pre-installed on macOS/Linux, available via chocolatey/scoop on Windows)

### Setup & Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/charleoh/dbt-assessment.git
   cd dbt-assessment
   ```

2. **Create and activate virtual environment**

   ```bash
   # Create virtual environment
   python -m venv venv

   # Activate virtual environment
   # On macOS/Linux:
   source venv/bin/activate

   # On Windows:
   venv\Scripts\activate
   ```

3. **Run the complete pipeline**

   ```bash
   # Development environment (default)
   make
   ```

That's it! The `make` command will automatically:

- Install all Python dependencies
- Set up dbt dependencies
- Load raw data into DuckDB
- Run the appropriate dbt pipeline based on environment

## 🛠️ Available Commands

The project uses a Makefile to simplify common operations:

### Core Commands

```bash
# Run complete pipeline (development mode)
make

# Run complete pipeline (production mode)
make ENVIRONMENT=prod

# Install dependencies only
make install-deps

# Load raw data only
make load-data

# Run dbt pipeline only (development - staged approach)
make dbt-dev

# Run dbt pipeline only (production - full run)
make dbt-prod

# Clean up generated files
make clean

# Show help
make help
```

### Environment Differences

**Development Mode** (`ENVIRONMENT=dev`):

- Uses `dev.duckdb` database
- Runs dbt models in staged order: staging → intermediate → mart → report
- Includes comprehensive testing at each stage

**Production Mode** (`ENVIRONMENT=prod`):

- Uses `prod.duckdb` database
- Runs all dbt models in a single execution
- Optimized for performance and reliability

## 🔄 CI/CD Pipeline

The project includes automated GitHub Actions workflows that:

- **Pull Requests**: Automatically run the development pipeline to validate changes
- **Main Branch**: Deploy to production environment on merge
- **Artifacts**: Store generated databases and dbt artifacts for inspection

The CI/CD pipeline leverages the same Makefile commands used locally, ensuring consistency between development and deployment environments.

## 📁 Project Structure

```
├── dbt_project/          # dbt models, tests, and configuration
├── scripts/              # Data loading and utility scripts
├── requirements.txt      # Python dependencies
├── Makefile             # Build automation and task management
├── .github/workflows/   # GitHub Actions CI/CD configuration
└── *.duckdb            # Generated database files (git-ignored)
```

## 🧪 Testing

Testing is integrated into the pipeline and runs automatically with each execution:

```bash
# Run tests for development environment
make dbt-dev

# Run tests for production environment
make dbt-prod
```

Tests include data quality checks, schema validations, and business rule assertions defined in the dbt project.

## 🔧 Troubleshooting

**Common Issues:**

- **Missing dependencies**: Run `make install-deps` to ensure all packages are installed
- **Database locked**: Run `make clean` to remove any stale database files
- **dbt compilation errors**: Check that all dbt dependencies are installed with `dbt deps`

**Getting Help:**

- Run `make help` to see all available commands
- Check the [Decision Tracking](docs/decisions.md) document for implementation details
- Review the [Output Description](docs/output-description.md) for expected results

## 📊 Results

After running the pipeline, you'll find:

- Generated DuckDB databases (`dev.duckdb` or `prod.duckdb`)
- dbt artifacts in `dbt_project/target/`
- Detailed logs and test results

---
