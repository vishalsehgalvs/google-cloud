# 🗄️ Cloud Storage (Object Storage)

## What is Object Storage?

- Stores data as **objects** (not files/folders or disk blocks)
- Each object = binary data + metadata (date, author, type, permissions, etc.) + globally unique ID
- Objects are accessed via URLs — works well with web technologies
- Common for media (video, images, audio), backups, and large data

---

## Google Cloud Storage

- Fully managed, scalable object storage
- Store any amount of data, retrieve as often as needed
- Use cases: website content, backup/archival, disaster recovery, direct downloads, intermediate workflow results

---

## Buckets

- Objects are organized into **buckets**
- Each bucket needs a **globally unique name** and a **geographic location** (region or multi-region)
- Choose a location close to your users for lower latency

---

## Immutability & Versioning

- Objects are **immutable** — edits create a new version
- By default, new versions overwrite old ones
- **Object versioning** (optional):
  - Keeps a history of all changes (overwrites/deletes)
  - Lets you list, restore, or permanently delete specific versions

---

## Access Control

- Use **IAM roles** for most access control (project → bucket → object inheritance)
- For finer control, use **Access Control Lists (ACLs)**
  - **Scope**: who can access (user/group)
  - **Permission**: what actions (read/write)

---

## Lifecycle Management

- Set policies to automatically delete or manage objects (e.g. delete after 365 days, keep only 3 most recent versions)
- Helps control costs by removing unneeded data

---

## gcloud Commands

```bash
# List all buckets
gcloud storage ls

# Create a bucket
gcloud storage buckets create gs://my-bucket --location=us-central1

# Upload a file
gcloud storage cp local-file.txt gs://my-bucket/

# Download a file
gcloud storage cp gs://my-bucket/file.txt .

# Set a lifecycle policy from a JSON file
gcloud storage buckets update gs://my-bucket --lifecycle-file=lifecycle.json

# Delete a bucket and all its contents
gcloud storage rm -r gs://my-bucket
```

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Storage scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Cloud Storage bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.
