# Storage and Database Module Summary

## Services Covered

| Service       | Type                 | Key Characteristic                                           |
| ------------- | -------------------- | ------------------------------------------------------------ |
| Cloud Storage | Object store         | Fully managed, unstructured data                             |
| Filestore     | File storage         | Fully managed NFS file service                               |
| Cloud SQL     | Relational DB        | Managed MySQL & PostgreSQL                                   |
| Spanner       | Relational DB        | Transactional consistency + global scale + high availability |
| AlloyDB       | Relational DB        | Fully managed PostgreSQL-compatible, HTAP workloads          |
| Firestore     | NoSQL document DB    | Fully managed, serverless, mobile/web apps                   |
| Bigtable      | NoSQL wide-column DB | Fully managed, petabyte-scale, low latency                   |
| Memorystore   | In-memory store      | Fully managed Redis                                          |

---

## Quick Decision Guide

```
Need in-memory / microsecond latency?
  └─ Memorystore

Need object storage (files, blobs, backups)?
  └─ Cloud Storage

Need shared file system (NFS)?
  └─ Filestore

Need relational data?
  ├─ Analytics workload? → BigQuery
  ├─ Global scale + horizontal scaling? → Spanner
  ├─ HTAP + PostgreSQL + ML integration? → AlloyDB
  └─ Standard web/app DB (no global scale needed)? → Cloud SQL

Need NoSQL?
  ├─ > 1 TB, high-throughput, HBase compatible? → Bigtable
  └─ Schema flexibility, scales to zero, mobile/web? → Firestore
```

---

## Module Goal

Understand what storage and database services are available in Google Cloud and how to choose the right one for different circumstances.

> A complete data strategy (data engineering, ML pipelines) is covered separately in Google Cloud's data engineering and machine learning courses.

## ACE Exam-Style Practice Questions

### Q1
In a Storage Database Module Summary scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Storage Database Module Summary, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
