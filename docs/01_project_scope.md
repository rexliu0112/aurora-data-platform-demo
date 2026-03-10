# Project Scope

## Objective

The objective of this project is to build a production-style data platform
demo that simulates a real-world business pipeline.

The pipeline ingests operational data from MySQL, loads it into BigQuery,
and performs transformations using dbt.

The final goal is to orchestrate the pipeline using a workflow engine.

---

## Pipeline Overview

MySQL (Cloud SQL)

↓

Python ingestion pipeline

↓

BigQuery raw dataset

↓

dbt transformation

↓

analytics tables

---

## Project Phases

Phase 1 — Project foundation

- Setup Git repository
- Setup dbt with BigQuery
- Run initial dbt models

Phase 2 — Data ingestion layer

- Build MySQL to BigQuery ingestion pipeline
- Load raw tables into BigQuery

Phase 3 — Data warehouse modeling

- Define dbt sources
- Create staging models
- Create mart models

Phase 4 — Orchestration

- Implement workflow orchestration
- Compare Cloud Run vs Airflow approaches

Phase 5 — Production hardening

- Add data tests
- Improve documentation
- Finalize architecture design

---

## Expected Outcomes

By completing this project, the following capabilities will be demonstrated:

- designing a modern data platform architecture
- implementing ingestion pipelines
- building data warehouse models using dbt
- orchestrating data pipelines
- managing a production-style Git project
