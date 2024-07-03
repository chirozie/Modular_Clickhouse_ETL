# INCREMENTAL LOAD ETL PIPELINE: CLICKHOUSE TO POSTGRES

This repository contains a pipeline for incrementally loading NYC cab trip data from a ClickHouse database to a PostgreSQL on-premises database. The data is first extracted and loaded into a staging environment, then transformed and aggregated to produce daily metrics before being loaded into the production environment.

## Table of Contents
- [Overview](#overview)
- [Source System](#source-system)
- [Environment Variables](#environment-variables)

## Overview

This pipeline performs the following steps:
1. **Extract**: Data is extracted from the ClickHouse database.
2. **Load (Staging)**: Extracted data is loaded into a staging environment.
3. **Transform**: Data is transformed and aggregated to calculate daily metrics.
4. **Load (Production)**: Transformed data is loaded into the production environment in PostgreSQL.

## Source System

The data source for this pipeline is a ClickHouse database accessible at the following URL:
- [ClickHouse Play](https://github.demo.trial.altinity.cloud:8443/play)

## Environment Variables

To reproduce the pipeline, an environment variable file (`.env`) is required with credentials for both the ClickHouse and PostgreSQL databases. The `.env` file should have the following format:

ClickHouse Credentials
ch_host = <your_clickhouse_host>
ch_port = <your_clickhouse_port>
ch_user = <your_clickhouse_user>
ch_password = <your_clickhouse_password>

PostgreSQL Credentials
pg_user = <your_postgres_user>
pg_password = <your_postgres_password>
pg_dbname = <your_postgres_dbname>
pg_port = <your_postgres_port>
pg_host = <your_postgres_host>