# Ingestion — Datastream CDC

Data ingestion uses Google Cloud Datastream for CDC (Change Data Capture) replication.

Datastream reads MySQL binlog and replicates changes into BigQuery in near real-time.

## Source and Destination

- Source: Cloud SQL (MySQL)
- Destination: BigQuery
- Mode: CDC (binlog-based)

## Schema Mapping

| Cloud SQL Schema | BigQuery Dataset |
|-----------------|------------------|
| a0a2 | raw_a0a2 |
| b0a2 | raw_b0a2 |

## Replicated Tables

- ct010dl_new
- ct020dl_new
- ct020bv2dl_new
- eq010dl_new
- sd022dl_new
- sd023dl_new
- mm000dl_new
- CONSUMP_DETAIL

## Type Mismatch Note

Datastream may change column types during replication (e.g., MySQL VARCHAR → BigQuery FLOAT64/INT64).

These mismatches are handled in the dbt staging layer using `CAST()`.