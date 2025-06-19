# 📜 Decision Log

I am using this markdown file to track key technical and design decisions made during development.

---

## 1. Use DuckDB with dbt-duckdb

**Decision**: Use `dbt-duckdb` as the database backend.  
**Rationale**: Lightweight, no installation overhead, easy to kick up and run locally.  
**Alternatives considered**: Postgres, SQLite  
**Trade-offs**: No concurrency; not suitable for production-scale use.  
**Outcome**: Fast local development with no external dependencies.

---

## 2. Introduced a Landing Zone layer

**Decision**: Separate ingestion into `landing/` models before transforming in `staging/`.  
**Rationale**: Improves modularity and makes the raw file inspection easier per source. In real-world, these would be external sources anyways.  
**Alternatives considered**: Read files directly in `staging/`.  
**Outcome**: More maintainable model structure.
