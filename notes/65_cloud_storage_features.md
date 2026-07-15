# Cloud Storage — Features and Data Management

## Key Features Overview

| Feature                               | What it does                                                                   |
| ------------------------------------- | ------------------------------------------------------------------------------ |
| **Customer-supplied encryption keys** | Use your own encryption keys instead of Google-managed keys                    |
| **Object Lifecycle Management**       | Automatically delete or change storage class of objects based on rules         |
| **Object Versioning**                 | Keep multiple versions of objects in a bucket                                  |
| **Soft Delete**                       | Protect against accidental deletion — retains deleted objects for a set period |
| **Object Retention Lock**             | Enforce compliance-based retention — prevent deletion before a set date        |
| **Directory Synchronization**         | Sync a VM directory with a bucket                                              |
| **Object Change Notifications**       | Triggered via Pub/Sub when objects change                                      |
| **Autoclass**                         | Automatically manages storage classes for a bucket based on access patterns    |

---

## Object Versioning

- When enabled, every overwrite or delete creates an **archived version** identified by a **generation number**
- You can: list archived versions, restore a previous version, or permanently delete a specific version
- Turning versioning **off** stops new versions from being created but leaves existing archived versions in place
- **You are charged for all versions** as if they were separate files

> Google recommends **Soft Delete** over Object Versioning for protection against accidental/malicious deletion.

---

## Soft Delete

- **Enabled by default** on all new buckets with a **7-day** retention duration
- Retains all deleted objects (from delete commands or overwrites) for the configured period
- After the retention duration, objects are **permanently deleted**
- Configurable up to **90 days**; can be disabled by setting duration to 0

---

## Object Lifecycle Management

Assign rules to a bucket — Cloud Storage automatically acts on objects that meet the criteria.

**Example rules:**

- Downgrade objects older than 1 year to **Coldline**
- Delete objects created before a specific date
- Keep only the **3 most recent versions** of each object

> Rules are applied in **asynchronous batches** — not immediate. Configuration changes can take up to **24 hours** to take effect.

---

## Object Retention Lock

- Set a retention duration on individual objects
- Optionally lock the retention to **prevent it from being reduced or removed**
- Helps meet compliance requirements: **FINRA, SEC, CFTC**

---

## Uploading Large Data Sets

| Service                      | Use For                                                                                 |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| **Transfer Appliance**       | Physical hardware device — migrate 100 TB to 1 PB offline                               |
| **Storage Transfer Service** | Online import from another Cloud Storage bucket, S3, or HTTP/HTTPS source               |
| **Offline Media Import**     | Send physical media (drives, tapes, USB) to a third-party provider who uploads the data |

---

## Strong Consistency

Cloud Storage is **strongly consistent** — no eventual consistency delays:

- After a successful upload → object is **immediately** available for download
- After a delete → an immediate read returns **404 Not Found**
- After creating a bucket → it **immediately** appears in bucket listings
- After uploading an object → it **immediately** appears in object listings

---

## gcloud Commands

```bash
# Enable object versioning on a bucket
gcloud storage buckets update gs://my-bucket --versioning

# Disable object versioning
gcloud storage buckets update gs://my-bucket --no-versioning

# List all versions of objects in a bucket
gcloud storage ls -a gs://my-bucket/

# Set a lifecycle policy from a JSON config file
gcloud storage buckets update gs://my-bucket \
  --lifecycle-file=lifecycle.json

# Update Soft Delete retention duration (in seconds; 0 = disable)
gcloud storage buckets update gs://my-bucket \
  --soft-delete-duration=604800

# Start a Storage Transfer Service job
gcloud transfer jobs create \
  s3://my-s3-bucket gs://my-gcs-bucket
```

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Storage Features scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Cloud Storage Features bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.
