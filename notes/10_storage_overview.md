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
