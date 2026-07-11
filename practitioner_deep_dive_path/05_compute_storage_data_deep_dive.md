# Compute, Storage, Database, And Data Deep Dive

## Compute decision matrix

Compute Engine:

- full VM control
- suitable for lift-and-shift patterns

App Engine:

- managed app platform
- reduced infra management burden

Cloud Run:

- serverless stateless containers
- fast scale behavior and simplified operations

Cloud Run Functions:

- event-driven and function-centric workloads

GKE:

- Kubernetes orchestration for larger container ecosystems

## Storage and database selection by data shape

Object data:

- Cloud Storage

Relational transactional data:

- Cloud SQL

Global relational with high scale:

- Spanner

Document model NoSQL:

- Firestore

Wide-column high-throughput NoSQL:

- Bigtable

In-memory caching:

- Memorystore

## Data platform selection

BigQuery:

- SQL analytics and data warehouse needs

Dataflow:

- batch and streaming processing pipelines

Dataproc:

- Spark and Hadoop cluster workloads

Dataprep:

- data preparation and transformation workflows

## High-yield comparative cues

BigQuery vs Cloud SQL:

- BigQuery for large analytics workloads
- Cloud SQL for transactional application database

Firestore vs Bigtable:

- Firestore for document-centric app data
- Bigtable for massive low-latency throughput workloads

Cloud Run vs App Engine:

- Cloud Run for container-first stateless model
- App Engine for managed application runtime model

## Scenario set

1. E-commerce app needs relational order storage and managed operations.
   Likely answer: Cloud SQL.

2. Company wants global analytics over TB/PB data with SQL.
   Likely answer: BigQuery.

3. Platform handles high-velocity telemetry at huge scale.
   Likely answer: Bigtable.

4. Team wants low-latency session cache.
   Likely answer: Memorystore.

## Fast self-test

1. What signal in a question pushes you toward Spanner instead of Cloud SQL?
2. Why is BigQuery often preferred for analytics-heavy scenarios?
3. What keyword in a prompt usually indicates Dataflow?
