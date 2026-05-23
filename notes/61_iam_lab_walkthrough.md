# IAM — Lab Walkthrough: Access Control with IAM

## Setup

- Two users provided by Qwiklabs: **Username 1** (admin) and **Username 2** (restricted)
- Username 1 has: App Engine Admin, BigQuery Admin, Editor, Owner, Viewer
- Username 2 starts with: **Viewer only**

---

## Task 1 & 2 — Explore the IAM Console

- Log in as both users in separate tabs
- In IAM, compare the roles assigned to each user
- Observe that role options are organized by product/service

---

## Task 3 — Create a Storage Bucket (as Username 1)

- Create a bucket using the **Project ID** as the name (globally unique)
- Upload any file and rename it to `sample.txt`
- Username 2 (Viewer) can see the bucket via inheritance

---

## Task 4 — Remove Viewer Role from Username 2

- In IAM (as Username 1), find Username 2 → Edit → delete the Viewer role → Save
- Verify: Username 2 can no longer list or view buckets
  - Error: _"List of buckets could not be loaded"_

---

## Task 5 — Add Storage Object Viewer to Username 2

- In IAM (as Username 1) → Add member → paste Username 2 → assign **Storage Object Viewer**
- Verify via Cloud Shell (as Username 2):

```bash
gsutil ls gs://BUCKET_NAME
# Expected: sample.txt is listed
```

> Note: Username 2 has no project Viewer role, so the console won't show resources — use Cloud Shell instead.

---

## Task 6 — Create a Service Account and Assign It to a VM

1. Go to **IAM & Admin → Service Accounts** → Create
   - Name: `read-bucket-objects`
   - Role: **Storage Object Viewer**
2. On the service account resource itself, grant **Service Account User** role to a domain (e.g. `autostrat.com`)
3. Grant **Compute Instance Admin v1** to the same domain via IAM
4. Create a VM:
   - Name: `demoIAM`
   - Region: `us-central1-c`
   - Machine type: `f1-micro`
   - Service account: `read-bucket-objects`

---

## Task 7 — Explore Service Account Permissions (via SSH into VM)

```bash
# This FAILS — service account has no permission to list instances
gcloud compute instances list

# This SUCCEEDS — service account has Storage Object Viewer
gsutil cp gs://BUCKET_NAME/sample.txt .

# This FAILS — service account cannot write to the bucket
gsutil cp sample.txt gs://BUCKET_NAME/
```

**Key takeaway:** The VM inherits only the permissions of its assigned service account — nothing more.

---

## Lab Summary

| Action                                    | Result                                               |
| ----------------------------------------- | ---------------------------------------------------- |
| Removed Viewer from Username 2            | Lost all console/bucket access                       |
| Added Storage Object Viewer to Username 2 | Can list bucket contents only                        |
| VM with `read-bucket-objects` SA          | Can read from bucket, cannot list instances or write |

> **Tip:** If you miss a checkpoint, go back 2–3 steps and re-check your work before assuming the lab is broken.
