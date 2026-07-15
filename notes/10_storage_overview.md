# 💾 Google Cloud Storage Overview

Every application needs to store data — from media files to sensor data. Google Cloud offers storage solutions for all types of data and workloads.

## Types of Data

- **Structured**: Organized, often tabular (e.g. relational databases)
- **Unstructured**: Media, documents, logs, etc.
- **Transactional**: Data that changes frequently, often with ACID guarantees
- **Relational**: Data with relationships, typically managed by SQL databases

---

## The 5 Core Storage Products

| Product           | Best for                                                  |
| ----------------- | --------------------------------------------------------- |
| **Cloud Storage** | Unstructured data, media, backups, objects                |
| **Cloud SQL**     | Managed relational (SQL) databases                        |
| **Spanner**       | Globally distributed, strongly consistent relational data |
| **Firestore**     | NoSQL, document-oriented, scalable apps                   |
| **Bigtable**      | NoSQL, wide-column, large-scale analytics                 |

Depending on your application, you might use one or several of these services together.

---

## gcloud Commands

```bash
# Quick overview — list resources for each storage product
gcloud storage ls                   # Cloud Storage buckets
gcloud sql instances list           # Cloud SQL
gcloud spanner instances list       # Spanner
gcloud firestore databases list     # Firestore
gcloud bigtable instances list      # Bigtable
```

## ACE Exam-Style Practice Questions

### Q1
In a Storage Overview scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Storage Overview bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.
