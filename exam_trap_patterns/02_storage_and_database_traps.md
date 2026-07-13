# Storage And Database Traps

## Trap 1: Storage Class By Access Frequency

The trap: Standard, Nearline, Coldline, Archive all "store data." The question is never asking which one can store the data. It is asking which one matches the stated access frequency.

Signal to answer mapping:

- "frequently analyzed / accessed often / multiple times a month" -> Standard (Regional or Multi-regional depending on serving need)
- "accessed about once a month or less" -> Nearline
- "accessed about once a quarter or less" -> Coldline
- "accessed less than once a year" -> Archive

Real example from practice:

- Question: "data is frequently analyzed" -> correct answer: Regional (Standard tier storage, single region)
- Why not Multi-regional: nothing in the question mentioned needing multi-region redundancy or global serving. Multi-regional costs more and is unnecessary here.
- Why not Nearline/Coldline/Archive: those are for infrequent access, opposite of "frequently analyzed."

One-line rule: match the exact frequency word first, then only add multi-region if the question explicitly needs global serving or redundancy.

## Trap 2: Location Type (Region vs Dual-region vs Multi-region)

- "data consumers/analytics pipeline in same region" -> Region (cheapest, lowest latency locally)
- "regional performance + higher availability from geo-redundancy" -> Dual-region
- "serving users outside Google's network across large geographic areas" -> Multi-region

One-line rule: default to single Region unless the question specifically asks for geographic redundancy or global serving.

## Trap 3: BigQuery vs Cloud SQL vs Spanner vs Firestore

The trap: all four can technically "store data you can query." The exam wants the one matching the workload type, not just any database.

- "analyze" + "SQL" + large dataset + no infra to manage -> BigQuery
- transactional app data (orders, user accounts) with a typical web framework -> Cloud SQL
- needs horizontal scaling AND strong consistency AND global scale -> Spanner
- mobile/web app needing flexible schema, offline sync, real-time updates -> Firestore

Why the wrong answers are wrong even though they "could" work:

- Cloud SQL is OLTP (transactional), not built for large-scale analytical aggregation queries.
- Spanner is for transactional workloads needing horizontal scale, not analytics.
- Firestore is a NoSQL document store for app data, not SQL analytics.

One-line rule: "analyze" + "SQL" -> BigQuery, almost every time.

## Trap 4: Bigtable vs Firestore

- "> 1 TB, high throughput, HBase-compatible, IoT/AdTech/finance" -> Bigtable
- "schema flexibility, scales to zero, mobile/web app" -> Firestore

One-line rule: Bigtable = huge scale analytical/operational throughput. Firestore = flexible app-facing document data.

## Trap 5: Cloud Storage vs Filestore

- object/blob data (images, video, backups, unstructured files) -> Cloud Storage
- shared POSIX file system / NFS mount needed by VMs -> Filestore

One-line rule: if the question says "file system" or "NFS," it is Filestore, not Cloud Storage.

## Trap 6: Cloud SQL vs AlloyDB

- standard managed relational, no special HTAP/ML requirement -> Cloud SQL
- PostgreSQL-compatible + HTAP (hybrid transactional/analytical) + ML integration -> AlloyDB

One-line rule: if the question mentions PostgreSQL plus heavy analytical queries alongside transactions, or ML integration, that is AlloyDB, not Cloud SQL.

## Quick Self-Test

1. Data accessed twice a week, no global requirement. Class + location?
2. App needs offline sync on mobile. Database?
3. 5 TB of IoT sensor data needing very high write throughput. Database?
4. Quarterly disaster recovery copy of data. Storage class?
5. Team wants SQL analytics without managing servers. Service?
