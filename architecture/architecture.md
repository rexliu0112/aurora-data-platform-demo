# Aurora Data Platform Demo

## Overview

This project demonstrates a modern data platform architecture built on GCP.  
The goal is to simulate a real-world business pipeline similar to the printer
business workflow previously implemented on AWS.

Original pipeline (AWS):

MySQL → AWS Glue → MySQL

This project rebuilds the pipeline using a modern data stack:

Cloud SQL (MySQL) → Python ETL → BigQuery → dbt → Orchestration

---

## Architecture

Operational Database

Cloud SQL (MySQL)

Stores operational data such as:

- equipment
- print_detail
- toner_detail

Data Ingestion Layer

Python ETL

Responsible for:

- extracting data from MySQL
- loading data into BigQuery raw layer
- initial version performs full overwrite

↓

Data Warehouse

BigQuery

Data is organized into layers:

raw  
    ingestion tables from MySQL

staging  
    cleaned and standardized tables created by dbt

mart  
    business-level aggregated tables

↓

Transformation Layer

dbt

Responsible for:

- defining sources
- building staging models
- building mart models
- managing SQL lineage and DAG

↓

Orchestration Layer

Two orchestration approaches will be evaluated:


Airflow / Cloud Composer DAG

Example pipeline DAG:

extract_mysql_to_bq  
        ↓  
dbt_build  

---

## Technology Stack

Cloud SQL (MySQL)  
BigQuery  
Python  
dbt  
Cloud Run  
Airflow / Cloud Composer  

---

## Project Goal

The goal of this project is to demonstrate how a production-style data
pipeline can be designed and implemented using modern data platform tools.

This project serves as a portfolio project for demonstrating data engineering
skills including:

- data ingestion
- data warehouse modeling
- transformation using dbt
- workflow orchestration
- cloud architecture design
