# 🔍 Storage Options Comparison

## Quick Reference

| Service         | Type        | Capacity    | Max Unit Size              | Best for                                                      |
| --------------- | ----------- | ----------- | -------------------------- | ------------------------------------------------------------- |
| **Cloud Storage** | Object    | Petabytes   | 5 TB per object            | Immutable blobs >10 MB (images, videos, backups)              |
| **Cloud SQL**   | Relational  | Up to 64 TB | —                          | Web frameworks, existing apps (user credentials, orders)      |
| **Spanner**     | Relational  | Petabytes   | —                          | Full SQL + horizontal scalability, mission-critical workloads |
| **Firestore**   | NoSQL       | Terabytes   | 1 MB per entity            | Mobile/web apps needing real-time sync and offline support    |
| **Bigtable**    | NoSQL       | Petabytes   | 10 MB/cell, 100 MB/row     | Analytical workloads, heavy read/write (AdTech, IoT, finance) |

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
