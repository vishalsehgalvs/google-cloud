# Dataprep by Trifacta

## What Is Dataprep?

- An **intelligent data service** for visually exploring, cleaning, and preparing structured and unstructured data
- Used for **analysis, reporting, and machine learning**
- **Serverless and fully managed** — no infrastructure to deploy or manage, scales on-demand
- **No code required** — the UI suggests and predicts your next ideal data transformation as you interact with it

---

## Key Features

- **Visual UI** — explore and clean data without writing code
- **Smart suggestions** — transformations are suggested and predicted with each UI input
- **Automatic detection** of:
  - Schema
  - Data types
  - Possible joins
  - Anomalies
- Skips time-consuming manual data profiling so you can focus on analysis
- **Fully managed and scalable** — grows with your data preparation needs

---

## Partnership with Trifacta

- Dataprep is an **integrated partner service operated by Trifacta**, based on their **Trifacta Wrangler** product
- Google and Trifacta work closely together to provide a seamless experience
- No up-front software installation, no separate licensing costs, no operational overhead

---

## Dataprep Architecture

```
Raw Data Sources
    ├── BigQuery
    ├── Cloud Storage
    └── File Upload
           │
           ▼
       Dataprep
    (explore, clean, prepare)
           │
           ▼
    Dataflow Pipeline
    (transform and enrich)
           │
           ▼
    Output / Analysis
    ├── BigQuery  (analytics)
    └── Cloud Storage  (ML, archiving)
```

- **Input**: raw data from BigQuery, Cloud Storage, or direct file uploads
- **Processing**: Dataprep cleans and prepares the data, then feeds it into a Dataflow pipeline
- **Output**: refined data exported to BigQuery or Cloud Storage for analysis and machine learning

## ACE Exam-Style Practice Questions

### Q1
In a Dataprep use case, analysts need visual data cleaning with minimal coding. Which service is best?

A. Dataprep
B. Dataproc
C. Cloud SQL
D. Memorystore

Answer: A
Trap: Dataprep is designed for visual wrangling, not cluster management.

### Q2
You need repeatable transformation steps for Dataprep before loading into analytics. What is best?

A. Save and schedule transformation recipes
B. Copy and paste ad-hoc SQL each day
C. Recreate datasets manually
D. Disable version history

Answer: A
Trap: Repeatability and lineage are key for reliable prep workflows.
