# Project Scope

## Objective

The objective of this project is to design and implement a production-style data platform that simulates a real-world business analytics pipeline.

The platform ingests operational data from MySQL, replicates it into BigQuery using Change Data Capture (CDC), and transforms the data into analytics-ready datasets using dbt.

This project also simulates a **multi-subsidiary data environment**, where multiple operational schemas represent different companies with similar data structures.

Each subsidiary stores operational data in a separate schema, while the analytics layer processes all subsidiaries using **a single dbt project with shared transformation logic**.

The final objective is to orchestrate the pipeline using a workflow engine to simulate a production data platform environment.

---

## Pipeline Overview

The data pipeline follows a modern cloud data architecture:
Cloud SQL (MySQL)
↓
Datastream (CDC Replication)
↓
BigQuery Raw Datasets
↓
dbt Transformations (Staging → Datamart)
↓
Analytics Tables / BI


Operational data is replicated using CDC and transformed through a layered data warehouse modeling approach.

---

## Multi-Subsidiary Design

To simulate a realistic enterprise environment, this project models multiple subsidiaries operating similar transactional systems.

Each subsidiary maintains a separate operational schema while sharing the same data structure.

Example operational schemas:

Cloud SQL

a0a2
c0a2

Datastream replicates these schemas into separate BigQuery datasets:
raw_a0a2
raw_c0a2


Although the data is stored in separate datasets, the table structures remain identical.

The analytics layer processes these datasets using **a shared dbt transformation framework**, allowing the platform to reuse transformation logic across subsidiaries.

This approach demonstrates how a centralized analytics platform can support **multi-tenant operational systems while maintaining reusable transformation logic**.

---

## Project Phases

### Phase 1 — Platform Foundation

- Initialize Git repository
- Configure dbt with BigQuery
- Establish project structure and baseline models

### Phase 2 — Data Ingestion Layer

- Implement MySQL to BigQuery ingestion pipeline
- Configure Datastream CDC replication
- Replicate operational schemas into BigQuery raw datasets

### Phase 3 — Data Warehouse Modeling

- Define dbt sources for replicated tables
- Implement staging models for type normalization
- Build datamart models containing business logic
- Support multi-subsidiary processing using shared dbt macros

### Phase 4 — Pipeline Orchestration

- Implement workflow orchestration
- Evaluate orchestration approaches (Cloud Run vs Airflow)

### Phase 5 — Production Hardening

- Implement data quality tests
- Improve project documentation
- Finalize architecture and repository structure

---

## Expected Outcomes

By completing this project, the following capabilities are demonstrated:

- designing modern cloud data platform architectures
- implementing CDC-based ingestion pipelines
- supporting multi-subsidiary (multi-tenant) data platforms
- building reusable data warehouse transformations using dbt
- implementing layered data warehouse modeling (raw → staging → datamart)
- orchestrating production-style data pipelines
- maintaining a production-style Git repository structure