# Cloud Storage — Deep Dive

## Key Characteristics

- Scalable to **exabytes** of data
- Time to first byte: **milliseconds**
- **11 nines of durability** (99.999999999%) — you won't lose data, but availability varies by class
- Single API across all storage classes
- Not a file system — it's a collection of **buckets** containing **objects**, accessed via unique URLs

---

## Storage Classes

| Class        | Min Duration | Retrieval Cost | Best For                                   |
| ------------ | ------------ | -------------- | ------------------------------------------ |
| **Standard** | None         | None           | Hot data, frequently accessed, short-lived |
| **Nearline** | 30 days      | Yes            | Backups, infrequent access (~once/month)   |
| **Coldline** | 90 days      | Higher         | Rarely accessed (~once/quarter)            |
| **Archive**  | 365 days     | Highest        | Long-term archival, DR (<once/year)        |

> Archive data is still available within **milliseconds** — unlike cold storage on other clouds that takes hours.

### Location Types (apply to all storage classes)

| Type             | Description                                           | Redundancy    |
| ---------------- | ----------------------------------------------------- | ------------- |
| **Region**       | Single geographic location (e.g. London)              | Zonal         |
| **Dual-region**  | Specific pair of regions (e.g. Finland + Netherlands) | Geo-redundant |
| **Multi-region** | Large area containing 2+ regions (e.g. US)            | Geo-redundant |

> You **cannot** change location type after bucket creation (e.g. regional → multi-region).

---

## Buckets and Objects

- Bucket names must be **globally unique**; buckets cannot be nested
- Objects inherit the bucket's storage class by default — but you can set a **per-object storage class**
- You can change the storage class of an object **without moving it** or changing its URL
- Use **Object Lifecycle Management** to automate class transitions (e.g. move to Nearline after 30 days)

---

## Access Control — Four Layers

From broadest to most granular:

| Mechanism                   | Scope                                  | Use When                                           |
| --------------------------- | -------------------------------------- | -------------------------------------------------- |
| **IAM**                     | Project → bucket → object              | Standard access control (recommended)              |
| **ACLs**                    | Per bucket or object (max 100 entries) | Fine-grained control beyond IAM                    |
| **Signed URLs**             | Per object, time-limited               | Granting temporary access without a Google account |
| **Signed Policy Documents** | Upload restrictions on signed URL      | Controlling what files can be uploaded             |

### ACLs

Each ACL entry has:

- **Scope** — who (specific user, group, `allUsers`, `allAuthenticatedUsers`)
- **Permission** — what (read, write)

> `allUsers` = anyone on the internet (no Google account needed)
> `allAuthenticatedUsers` = anyone signed in with a Google account

### Signed URLs

- Grant **read or write** access to a specific object for a limited time
- Signed with a **private key** tied to a service account
- Once issued, you can't revoke it — keep expiry short
- Useful when users don't have Google accounts

---

## gcloud Commands

```bash
# Create a bucket
gcloud storage buckets create gs://my-bucket --location=us-central1

# Upload an object
gcloud storage cp my-file.txt gs://my-bucket/

# Change the storage class of a bucket
gcloud storage buckets update gs://my-bucket --default-storage-class=NEARLINE

# Change the storage class of a specific object
gcloud storage objects update gs://my-bucket/my-file.txt \
  --storage-class=COLDLINE

# Set a lifecycle policy on a bucket
gcloud storage buckets update gs://my-bucket \
  --lifecycle-file=lifecycle.json

# Generate a signed URL (valid for 1 hour)
gcloud storage sign-url gs://my-bucket/my-file.txt \
  --duration=1h --private-key-file=key.json

# List ACL entries on a bucket
gcloud storage buckets get-iam-policy gs://my-bucket
```

---

## Object Versioning

Keeps previous versions of an object whenever it is overwritten or deleted:

```bash
# Enable versioning
gcloud storage buckets update gs://my-bucket --versioning

# List all versions of an object
gcloud storage ls -a gs://my-bucket/my-file.txt

# Restore a previous version (copy it back)
gcloud storage cp gs://my-bucket/my-file.txt#GENERATION_NUMBER gs://my-bucket/my-file.txt

# Delete a specific version
gcloud storage rm gs://my-bucket/my-file.txt#GENERATION_NUMBER
```

- Non-current versions still incur storage costs — use lifecycle rules to delete old versions automatically

---

## Retention Policies and Legal Holds

| Feature              | Description                                                                   |
| -------------------- | ----------------------------------------------------------------------------- |
| **Retention policy** | Objects cannot be deleted or replaced until the retention period expires      |
| **Retention lock**   | Makes the policy permanent (cannot be shortened or removed)                   |
| **Legal hold**       | Temporarily blocks deletion regardless of retention period; released manually |

```bash
# Set a 30-day retention policy
gcloud storage buckets update gs://my-bucket --retention-period=30d

# Place a legal hold on an object
gcloud storage objects update gs://my-bucket/my-file.txt --event-based-hold
```

- WORM (**Write Once Read Many**) compliance: use retention lock

---

## Pub/Sub Notifications

Trigger downstream processing whenever objects are created, updated, or deleted:

```bash
# Create a Pub/Sub notification for new objects
gcloud storage buckets notifications create gs://my-bucket \
  --topic=my-topic \
  --event-types=OBJECT_FINALIZE
```

| Event type               | Trigger                                          |
| ------------------------ | ------------------------------------------------ |
| `OBJECT_FINALIZE`        | Object successfully created or overwritten       |
| `OBJECT_DELETE`          | Object permanently deleted                       |
| `OBJECT_ARCHIVE`         | Non-current version created (versioning enabled) |
| `OBJECT_METADATA_UPDATE` | Object metadata changed                          |

---

## Encryption Options

| Type                         | Who manages keys           | Use case                                               |
| ---------------------------- | -------------------------- | ------------------------------------------------------ |
| **Google-managed** (default) | Google                     | Zero effort; suitable for most workloads               |
| **Customer-managed (CMEK)**  | You (via Cloud KMS)        | Compliance requiring key control; key rotation audit   |
| **Customer-supplied (CSEK)** | You (supplied per request) | Maximum key control; you hold key material, not Google |

```bash
# Create a bucket with CMEK
gcloud storage buckets create gs://my-bucket \
  --location=us-central1 \
  --default-encryption-key=projects/PROJECT/locations/global/keyRings/my-ring/cryptoKeys/my-key
```

- CSEK: you pass the AES-256 key in the API request header. If you lose the key, data is unrecoverable.

---

## CORS Configuration

Required when a web browser calls Cloud Storage from a different origin (e.g. a web app reading files from a bucket):

```json
[
  {
    "origin": ["https://example.com"],
    "method": ["GET", "HEAD"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
```

```bash
gcloud storage buckets update gs://my-bucket --cors-file=cors.json
```

---

## Storage Transfer Service

Managed service for large-scale data transfers **into** Cloud Storage:

| Source                                              | Use case                  |
| --------------------------------------------------- | ------------------------- |
| Another GCS bucket                                  | Cross-region/project copy |
| AWS S3                                              | Cloud migration           |
| HTTP/HTTPS URLs                                     | Public dataset ingestion  |
| On-premises (Transfer Service for On Premises Data) | Local file servers        |

- Supports filters (by prefix, creation time), scheduling, and deletions after transfer
- For one-off transfers < 1TB, `gsutil rsync` or `gcloud storage rsync` is simpler

---

## Access Logging

Captures who accessed what object and when:

```bash
# Enable access logs (writes logs to a destination bucket)
gcloud storage buckets update gs://my-bucket \
  --log-bucket=gs://my-log-bucket \
  --log-object-prefix=access-logs/
```

- Each log object is a CSV file with fields: time, requester, bucket, object, bytes, status
- Log objects themselves are billed as standard storage

---

## Key Takeaways — Cloud Storage Deep Dive

| Topic                     | Key Point                                                  |
| ------------------------- | ---------------------------------------------------------- |
| **Versioning**            | Keeps old copies; add lifecycle rules to control costs     |
| **Retention policy**      | WORM compliance; lock to make permanent                    |
| **Legal hold**            | Blocks deletion independently of retention period          |
| **CMEK vs CSEK**          | CMEK = Cloud KMS; CSEK = you supply key bytes per request  |
| **Pub/Sub notifications** | Use to trigger Cloud Functions/Cloud Run on object changes |
| **Transfer Service**      | Best for large migrations from S3 or on-premises           |

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Storage Deep Dive scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Cloud Storage Deep Dive bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.
