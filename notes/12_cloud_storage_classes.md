# 🏷️ Cloud Storage Classes & Data Movement

## Four Primary Storage Classes

| Class        | Best for / Access Pattern             | Min. Duration | Example Use Cases                  |
| ------------ | ------------------------------------- | ------------- | ---------------------------------- |
| **Standard** | Frequently accessed ("hot") data      | None          | Active content, short-term storage |
| **Nearline** | Infrequently accessed (~1/mo or less) | 30 days       | Backups, archives, long-tail media |
| **Coldline** | Rarely accessed (~1/90 days or less)  | 90 days       | Disaster recovery, archival        |
| **Archive**  | Accessed <1/year, lowest cost         | 365 days      | Deep archive, compliance, DR       |

- All classes: unlimited storage, no min object size, global access, low latency, high durability, uniform security/tools/APIs, geo-redundancy (multi/dual-region)

---

## Autoclass

- Automatically transitions objects to the right storage class based on access patterns
- Moves cold data to cheaper classes, hot data to Standard
- Simplifies cost savings

---

## Security & Cost

- No minimum fee — pay only for what you use
- No need to pre-provision capacity
- Data is always encrypted at rest (server-side) and in transit (HTTPS/TLS)

---

## Data Ingestion & Transfer

- **gcloud storage** (Cloud SDK) — command-line uploads
- **Cloud Console** — drag-and-drop (in Chrome)
- **Storage Transfer Service** — schedule/manage large online transfers (from other clouds, regions, HTTP(S))
- **Transfer Appliance** — lease a physical device, load data, ship to Google for upload (up to 1 PB per appliance)
- **Tight integration** with other Google Cloud products (BigQuery, Cloud SQL, App Engine, Firestore, Compute Engine, etc.)

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Storage Classes scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Cloud Storage Classes bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.
