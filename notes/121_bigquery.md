# BigQuery

## What Is BigQuery?

- Google Cloud's **serverless, highly scalable, and cost-effective cloud data warehouse**
- **Petabyte-scale** — handles massive datasets with super-fast queries powered by Google's infrastructure
- **No infrastructure to manage** — no database administrator needed; focus on analysis, not operations
- Uses **familiar Standard SQL** — no need to learn a new query language

---

## How to Access BigQuery

| Method                | Details                                                                 |
| --------------------- | ----------------------------------------------------------------------- |
| **GCP Console**       | Web-based UI for running queries and exploring data                     |
| **Command-line tool** | `bq` CLI for scripting and automation                                   |
| **BigQuery REST API** | Programmatic access via client libraries (Java, .NET, Python, and more) |
| **Third-party tools** | Data visualization tools (e.g., Looker, Tableau) and ETL/loading tools  |

---

## Example Query

```sql
SELECT *
FROM groceries AS g
```

- Standard SQL syntax — works just like querying any relational database
- Each column in the `groceries` table is returned; the table is aliased as `g`

---

## Key Characteristics

- **Serverless** — no clusters or VMs to provision or manage
- **Petabyte scale** — designed for very large datasets
- **Cost-effective** — pay for the queries you run and the storage you use
- **Fast** — leverages Google's distributed infrastructure for high-speed query processing
- Used by organizations of all sizes for analytics workloads

## ACE Exam-Style Practice Questions

### Q1
In a Bigquery design, all query costs must be billed to one project while users only read data in another project. What IAM setup is correct?

A. bigquery.user on both projects
B. bigquery.jobUser on billing project and bigquery.dataViewer on data project
C. Owner on billing project only
D. Editor on all projects

Answer: B
Trap: Job execution permission and data-read permission are intentionally split.

### Q2
A Bigquery table is expensive to query repeatedly with time filters. What is the best optimization?

A. Keep one unpartitioned table and query all rows
B. Use partitioning and clustering on common filter columns
C. Export to CSV before each query
D. Move data to Cloud SQL

Answer: B
Trap: Reducing scanned bytes is the first-line cost control in BigQuery.
