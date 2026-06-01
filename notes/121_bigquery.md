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
