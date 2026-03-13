# Aurora Data Platform Demo

This repository demonstrates a production-style data platform built on **Google Cloud Platform (GCP)**.

The platform replicates operational data from MySQL into BigQuery using **Datastream (CDC)** and transforms it into analytics-ready datasets using **dbt**.

The project simulates a **multi-subsidiary data environment**, where multiple operational schemas share the same structure but are processed using a single dbt transformation framework.

## Pipeline Overview

Cloud SQL (MySQL)
↓
Datastream (CDC)
↓
BigQuery (Raw Layer)
↓
dbt (Staging → Datamart)
↓
Analytics / BI

## Documentation

Detailed documentation:

- `docs/project_scope.md`
- `docs/architecture.md`
- `docs/decision.md`
- `docs/ingestion.md`

## Repository Structure

aurora-data-platform-demo/
├── docs/
├── dbt/
├── orchestration/
└── README.md