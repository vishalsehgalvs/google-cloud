# 🔍 Storage Options Comparison

## Quick Reference

| Service           | Type       | Capacity    | Max Unit Size          | Best for                                                      |
| ----------------- | ---------- | ----------- | ---------------------- | ------------------------------------------------------------- |
| **Cloud Storage** | Object     | Petabytes   | 5 TB per object        | Immutable blobs >10 MB (images, videos, backups)              |
| **Cloud SQL**     | Relational | Up to 64 TB | —                      | Web frameworks, existing apps (user credentials, orders)      |
| **Spanner**       | Relational | Petabytes   | —                      | Full SQL + horizontal scalability, mission-critical workloads |
| **Firestore**     | NoSQL      | Terabytes   | 1 MB per entity        | Mobile/web apps needing real-time sync and offline support    |
| **Bigtable**      | NoSQL      | Petabytes   | 10 MB/cell, 100 MB/row | Analytical workloads, heavy read/write (AdTech, IoT, finance) |

---

## Decision Guide

- **Cloud Storage** — immutable blobs larger than 10 MB (images, videos, large files)
- **Cloud SQL** — full SQL + OLTP, existing web app frameworks
- **Spanner** — full SQL + OLTP, but needs horizontal scalability (beyond read replicas)
- **Firestore** — massive scaling, real-time queries, offline support, mobile/web apps
- **Bigtable** — large number of structured objects, no SQL/multi-row transactions needed, high read/write throughput

---

## What About BigQuery?

- BigQuery sits on the edge between **data storage and data processing**
- Not purely a storage product — main value is **big data analysis and interactive querying**
- Store data in BigQuery when you want to run large-scale analytics on it

---

## gcloud Commands

```bash
# Quick reference — list resources for each product
gcloud storage ls                   # Cloud Storage buckets
gcloud sql instances list           # Cloud SQL
gcloud spanner instances list       # Spanner
gcloud firestore databases list     # Firestore
gcloud bigtable instances list      # Bigtable
bq ls                               # BigQuery datasets (uses bq CLI, not gcloud)
```

## ACE Exam-Style Practice Questions

### Q1
In a Storage Comparison scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Storage Comparison, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
