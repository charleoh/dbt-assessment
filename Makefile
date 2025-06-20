# Set default environment if not specified
ENVIRONMENT ?= dev

# Set database configuration based on environment
ifeq ($(ENVIRONMENT),prod)
    DATABASE_NAME = prod.duckdb
    DBT_TARGET = prod
else
    DATABASE_NAME = dev.duckdb
    DBT_TARGET = dev
endif

# Export variables for use in commands
export DATABASE_NAME
export DBT_TARGET

.PHONY: all load-data dbt-prod dbt-dev clean help

# Default target
all: install-deps load-data
	@echo "Running in $(ENVIRONMENT) mode with database: $(DATABASE_NAME)"
ifeq ($(ENVIRONMENT),prod)
	$(MAKE) dbt-prod
else
	$(MAKE) dbt-dev
endif
	@echo "dbt pipeline completed successfully!"

# Install dependencies
install-deps:
	@echo "Installing all dependencies..."
	python -m pip install --upgrade pip
	pip install -r requirements.txt
	cd dbt_project && dbt deps

# Load raw data
load-data:
	@echo "Loading raw JSONL to DuckDB..."
	python scripts/load_jsonl_to_duckdb.py

# Production DBT run (full run)
dbt-prod:
	@echo "Running PROD build (full run)..."
	cd dbt_project && \
	dbt run --target $(DBT_TARGET) && \
	dbt test --target $(DBT_TARGET)

# Development DBT run (staged approach)
dbt-dev:
	@echo "Running DEV build (staged approach)..."
	cd dbt_project && \
	dbt run --target $(DBT_TARGET) --select tag:staging && \
	dbt test --target $(DBT_TARGET) --select tag:staging && \
	dbt run --target $(DBT_TARGET) --select tag:intermediate && \
	dbt test --target $(DBT_TARGET) --select tag:intermediate && \
	dbt run --target $(DBT_TARGET) --select tag:mart && \
	dbt test --target $(DBT_TARGET) --select tag:mart && \
	dbt run --target $(DBT_TARGET) --select tag:report && \
	dbt test --target $(DBT_TARGET) --select tag:report

# Clean up generated files (optional target)
clean:
	rm -f *.duckdb
	cd dbt_project && dbt clean

# Help target
help:
	@echo "Available targets:"
	@echo "  all (default) - Run the complete pipeline"
	@echo "  install-deps  - Install dependencies"
	@echo "  load-data     - Load raw JSONL data to DuckDB"
	@echo "  dbt-prod      - Run production DBT pipeline"
	@echo "  dbt-dev       - Run development DBT pipeline"
	@echo "  clean         - Clean up generated files"
	@echo ""
	@echo "Usage examples:"
	@echo "  make                    # Run in dev mode (default)"
	@echo "  make ENVIRONMENT=prod   # Run in production mode"
	@echo "  make load-data          # Just load the data"
	@echo "  make clean              # Clean up files"