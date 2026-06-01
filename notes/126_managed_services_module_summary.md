# Managed Services — Module Summary

## Services Covered

| Service      | Purpose                                                         |
| ------------ | --------------------------------------------------------------- |
| **BigQuery** | Serverless, petabyte-scale data warehouse for SQL analytics     |
| **Dataflow** | Fully managed stream and batch data processing (Apache Beam)    |
| **Dataprep** | No-code intelligent data cleaning and preparation (by Trifacta) |
| **Dataproc** | Managed Apache Spark and Hadoop clusters                        |

---

## Key Takeaway — What "Managed Service" Means

- Outsource administrative and maintenance overhead to Google
- Focus on your **workloads and data**, not the infrastructure

---

## What "Serverless" Actually Means

- Servers (Compute Engine instances) are **obfuscated** — you don't see or manage them
- This does **not** mean there are no servers — data is still processed on real machines
- You just don't have to worry about provisioning, scaling, or maintaining them

### Serverless vs Not Serverless in This Module

| Service      | Serverless? | Reason                                                                            |
| ------------ | ----------- | --------------------------------------------------------------------------------- |
| **BigQuery** | Yes         | No infrastructure to manage                                                       |
| **Dataflow** | Yes         | Fully managed; no clusters to configure                                           |
| **Dataprep** | Yes         | Fully managed; no infrastructure to deploy                                        |
| **Dataproc** | **No**      | You can view and manage the underlying master and worker Compute Engine instances |
