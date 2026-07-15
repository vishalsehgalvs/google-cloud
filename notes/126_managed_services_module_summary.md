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

## ACE Exam-Style Practice Questions

### Q1
In a Managed Services Module Summary scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Managed Services Module Summary, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
