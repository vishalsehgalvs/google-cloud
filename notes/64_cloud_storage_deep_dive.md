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
