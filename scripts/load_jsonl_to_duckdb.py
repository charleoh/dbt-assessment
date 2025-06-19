import duckdb
import os
import sys
import yaml

CONFIG_FILE = "scripts/load_config.yaml"

def load_config():
    try:
        with open(CONFIG_FILE, "r") as f:
            return yaml.safe_load(f)
    except Exception as e:
        print(f"Failed to read YAML config: {e}")
        sys.exit(1)

def get_duckdb_path():
    path = os.getenv("DATABASE_NAME")
    if not path:
        print("Environment variable DATABASE_NAME is not set.")
        sys.exit(1)
    
    return path

def build_select_cast(columns: dict):
    casts = [f"CAST({col} AS {dtype}) AS {col}" for col, dtype in columns.items()]
    return ",\n    ".join(casts)

def main():
    config = load_config()
    schema = config.get("schema", "raw")
    tables = config.get("tables", {})

    duckdb_path = get_duckdb_path()
    con = duckdb.connect(duckdb_path)

    con.execute(f"CREATE SCHEMA IF NOT EXISTS {schema};")

    for table_name, table_config in tables.items():
        file_path = table_config.get("path")
        columns = table_config.get("columns")

        if not file_path or not os.path.exists(file_path):
            print(f"File not found: {file_path} — Skipping {table_name}")
            continue

        if not columns:
            print(f"No column types defined for {table_name} — Skipping")
            continue

        full_table_name = f"{schema}.{table_name}"
        select_casts = build_select_cast(columns)

        query = f"""
        CREATE OR REPLACE TABLE {full_table_name} AS
        SELECT
            {select_casts}
        FROM read_json_auto('{file_path}')
        """

        print(f"Loading {file_path} into {full_table_name} with explicit casting...")
        try:
            con.execute(query)
        except Exception as e:
            print(f"Failed to load {table_name}: {e}")
            continue

    print("All JSONL files loaded with explicit schema enforcement.")

if __name__ == "__main__":
    main()
