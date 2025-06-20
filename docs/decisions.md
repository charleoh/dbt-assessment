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
**Rationale**: Improves modularity and makes the raw file inspection easier per source (data contracts). In real-world, these would be external sources anyways.  
**Alternatives considered**: Read files with read_json directly in `staging/`.  
**Outcome**: More maintainable model structure.  
**Link**:

- [/scripts/](../scripts/)
- [/dbt_project/sources/](../dbt_project/sources/)

---

## 3. Introduced an Intermediate layer

**Decision**: Handle business logic and some transformations in an intermediate layer.  
**Rationale**: Keeps the mart layer as clean implementation of selecting only the fields they need.  
**Alternatives considered**: Data Vault 2.0  
**Outcome**: More maintainable model structure.  
**Link**: [/dbt_project/models/intermediate/](../dbt_project/models/intermediate/)

---

## 4. Handling Keys

**Decision**: Generate surrogate key for relations based on source + procurement_number.  
**Rationale**: On analysis, it appeared that project_id was unique to source + procurement_number. However, not sure how 'future-proof' this approach may be.  
**Alternatives considered**:  
**Outcome**: No breakdown in relations to bids.  
**Link**: [/dbt_project/models/intermediate/](../dbt_project/models/intermediate/)

---

## 5. Historical Mart Layer

**Decision**: Apply SCD 2 at the mart layer.  
**Rationale**: Future-proof for record changes.  
**Alternatives considered**: -  
**Outcome**: Better visibility on data over time.  
**Link**: [/dbt_project/models/mart/](../dbt_project/models/mart/)

---

## 6. Report Base Layer

**Decision**: Create base tables for shared metrics.  
**Rationale**: Allows us to use similar metrics across different tables (consolidating their definitions).  
**Alternatives considered**: Per report definitions  
**Outcome**: Better maintainability and definition ownership.  
**Link**: [/dbt_project/models/report/base/](../dbt_project/models/report/base/)

---

## 7. Report Layer

**Decision**: Left data relatively as-is (little formatting).  
**Rationale**: Reporting tool or analytics rarely want data pre-formatted (however, it is highly customer usage dependent).  
**Alternatives considered**: Consumption ready data  
**Outcome**: Data can be ingested more universally without further wrangling, and display/formatting can be handled by further analysis or reporting.  
**Link**: [/dbt_project/models/report/](../dbt_project/models/report/)

---

## 8. CI/CD

**Decision**: Singular pipeline with both dev/prod.  
**Rationale**: CI/CD can get overly complicated, but in this circumstance, we need just a dev for testing changes, and then a production pipeline (based on branch).  
**Alternatives considered**: pipeline stages, safe-guards, roll-backs  
**Outcome**: Given the simplicity of the dbt project, the pipeline works as intended. Providing the project grew or relied on other elements in the stack, this would need to iteratively change.  
**Link**: [.github/workflows/dbt-ci.yml](../.github/workflows/dbt-ci.yml)

---

## 9. Make

**Decision**: Make use of a Makefile
**Rationale**: Makefiles are a bit more universal (platform independent) and also easy to ready.  
**Alternatives considered**: bash, separate commands, Docker
**Outcome**: It does simplify everything, but it does allow quick start.
**Link**: [Makefile](Makefile)
