# Project Scope

## Objective

The objective of this project is to build a production-style data platform demo that simulates a real-world business analytics pipeline.

The pipeline ingests operational data from MySQL, loads it into BigQuery, and performs transformations using dbt.

This project also simulates a **multi-subsidiary data environment**, where multiple operational schemas represent different companies with similar data structures.

Each subsidiary stores its data in a separate schema, while the analytics layer uses **a single dbt project to process all subsidiaries using shared transformation logic**.

The final goal is to orchestrate the pipeline using a workflow engine.

---

## Pipeline Overview

Cloud SQL (MySQL)

↓

Datastream (CDC replication)

↓

BigQuery raw datasets

↓

dbt transformation

↓

analytics tables

---

## Multi-Subsidiary Design

To simulate a realistic enterprise environment, this project includes multiple subsidiaries.

Each subsidiary maintains a separate operational schema but shares the same table structure.

Example structure:

Cloud SQL schemas

a0a2  
c0a2  

Datastream replicates these schemas into BigQuery raw datasets:

raw_a0a2  
raw_c0a2  

Although the data is stored in separate datasets, the schema structure is identical.

This allows the analytics platform to reuse **a single dbt project** to process data across all subsidiaries.

This design demonstrates how a centralized analytics platform can support **multiple operational tenants while maintaining reusable transformation logic**.

---

## Project Phases

### Phase 1 — Project foundation

- Setup Git repository
- Setup dbt with BigQuery
- Run initial dbt models

### Phase 2 — Data ingestion layer

- Build MySQL to BigQuery ingestion pipeline
- Configure Datastream CDC replication
- Load raw tables into BigQuery datasets

### Phase 3 — Data warehouse modeling

- Define dbt sources
- Create staging models
- Create mart models
- Support multi-subsidiary transformations using shared dbt logic

### Phase 4 — Orchestration

- Implement workflow orchestration
- Compare Cloud Run vs Airflow approaches

### Phase 5 — Production hardening

- Add data tests
- Improve documentation
- Finalize architecture design

---

## Expected Outcomes

By completing this project, the following capabilities will be demonstrated:

- designing a modern data platform architecture
- implementing CDC-based ingestion pipelines
- supporting multi-subsidiary data platforms
- building reusable dbt data warehouse models
- orchestrating data pipelines
- managing a production-style Git project