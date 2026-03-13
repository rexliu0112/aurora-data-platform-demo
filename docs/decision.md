# Architecture Decisions

This document describes the key architectural decisions made in this project
and the reasoning behind them.

The goal is to simulate how design decisions are documented in real-world
data platform projects.

---

# Decision 1 — Use CDC for Data Ingestion

## Decision

Use **Google Cloud Datastream** to replicate MySQL data into BigQuery using
Change Data Capture (CDC).

## Context

In many production systems, operational databases are continuously updated
by application workloads.

Traditional batch ingestion methods (scheduled exports or ETL jobs)
introduce latency and increase operational complexity.

## Reasoning

CDC provides several advantages:

- near real-time data replication
- reduced load on the source database
- simplified ingestion pipelines
- automatic capture of inserts, updates, and deletes

Datastream integrates directly with BigQuery, making it a natural choice
for a GCP-native data platform.

## Alternatives Considered

Batch ingestion approaches:

- scheduled export jobs
- custom Python ingestion pipelines
- Airflow batch ETL

These approaches were rejected because they add complexity and do not
reflect modern CDC-based architectures commonly used in production systems.

---

# Decision 2 — Use BigQuery as the Data Warehouse

## Decision

Use **BigQuery** as the analytical data warehouse.

## Context

The platform requires a scalable analytical database capable of processing
large volumes of operational data.

## Reasoning

BigQuery offers:

- serverless architecture
- automatic scaling
- strong integration with GCP services
- support for SQL-based analytics

It is widely used in modern cloud data platforms and integrates well with dbt.

---

# Decision 3 — Use dbt for Data Transformations

## Decision

Use **dbt (data build tool)** to manage transformation logic.

## Context

Raw data replicated from operational systems requires cleaning,
standardization, and modeling before it becomes useful for analytics.

## Reasoning

dbt provides:

- modular SQL transformations
- dependency management
- lineage tracking
- built-in testing
- version-controlled analytics code

This allows the transformation layer to behave like a software project,
improving maintainability and reproducibility.

## Alternatives Considered

Alternative transformation approaches included:

- custom SQL scripts
- Python-based transformation pipelines
- manual transformation workflows

These approaches were rejected because they lack strong dependency
management and standardized project structure.

---

# Decision 4 — Layered Data Warehouse Design

## Decision

Adopt a **layered data warehouse architecture**.

## Structure

raw → staging → mart

## Context

Operational data replicated into BigQuery contains inconsistencies,
technical fields, and source-specific structures.

## Reasoning

Layered modeling improves:

- data quality control
- model readability
- reuse of transformation logic
- maintainability of analytical models

Typical responsibilities:

Raw layer

- replicated source tables
- minimal transformation

Staging layer

- standardized column names
- cleaned data
- derived intermediate fields

Mart layer

- business-level models
- analytics-ready tables

---

# Decision 5 — Multi-Subsidiary Schema Design

## Decision

Support **multiple subsidiaries using separate schemas** while sharing a
single transformation framework.

## Context

Many enterprise systems operate across multiple subsidiaries or regions.

Each entity may maintain its own operational schema while using similar
database structures.

## Implementation

Example operational schemas:

Cloud SQL

a0a2  
c0a2  

These schemas are replicated into BigQuery datasets:

raw_a0a2  
raw_c0a2  

Although the data is separated by dataset, the schema structures are identical.

## Reasoning

This design allows:

- logical isolation of company data
- scalable support for additional subsidiaries
- reuse of dbt transformation logic

A **single dbt project** can process data across multiple subsidiaries
by parameterizing dataset references.

This approach demonstrates how a centralized analytics platform can
support multi-tenant operational environments.

---

# Decision 6 — Separate Operational and Analytical Systems

## Decision

Separate operational databases from analytical workloads.

## Context

Transactional databases are optimized for application workloads,
not analytical queries.

Running heavy analytics queries on operational systems can impact
application performance.

## Reasoning

By replicating data into a warehouse:

- analytics workloads are isolated
- query performance improves
- data models can evolve independently
- historical analysis becomes easier

This separation is a fundamental principle of modern data platform design.