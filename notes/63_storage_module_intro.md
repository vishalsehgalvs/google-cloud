# Storage and Database Services — Module Introduction

## What This Module Covers

- Cloud Storage
- Filestore
- Cloud SQL
- Spanner
- AlloyDB
- Firestore
- Bigtable
- Memorystore

> **BigQuery** is mentioned but covered later — it sits on the edge between storage and data processing (intended for big data analysis and interactive querying).

---

## Storage Services Overview

| Service           | Type               | Best For                                 |
| ----------------- | ------------------ | ---------------------------------------- |
| **Cloud Storage** | Object store       | Unstructured data, blobs, backups        |
| **Filestore**     | Shared file system | Lift-and-shift apps needing NFS          |
| **Cloud SQL**     | Relational (SQL)   | Standard web apps, OLTP                  |
| **Spanner**       | Relational (SQL)   | Global scale, strong consistency         |
| **AlloyDB**       | Relational (HTAP)  | Hybrid transactional + analytical        |
| **Firestore**     | NoSQL document     | Mobile/web apps, real-time sync          |
| **Bigtable**      | NoSQL wide-column  | IoT, AdTech, FinTech, analytics at scale |
| **Memorystore**   | In-memory          | Application caching (Redis)              |

---

## Decision Tree — How to Pick a Storage Service

```
Is your data structured?
├── No
│   ├── Need a shared file system? → Filestore
│   └── No → Cloud Storage
└── Yes
    ├── Analytics workload?
    │   ├── Low latency + high read/write → Bigtable
    │   └── Large-scale SQL analysis / data warehouse → BigQuery
    └── Not analytics
        ├── Relational?
        │   ├── Need HTAP (hybrid transactional + analytical)? → AlloyDB
        │   ├── Need global scalability? → Spanner
        │   └── Neither → Cloud SQL
        └── Not relational
            ├── Need caching? → Memorystore
            └── No → Firestore
```

---

## Module Goal

Understand **which service to use and when** from an infrastructure perspective — enough to set up and connect to a service. For deeper design, schema optimization, and data modeling, see Google Cloud's **Data Engineering courses**.
