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
