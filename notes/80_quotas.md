# Quotas in Google Cloud

## What Are Quotas?

All resources in Google Cloud are subject to **project quotas** (limits) — the maximum amount of a resource type you can create or use.

> Quotas do **not** guarantee resource availability. If a region is out of a resource (e.g. local SSDs), you cannot create it even if you have quota remaining.

---

## Types of Quotas

| Type                       | Description                             | Example                            |
| -------------------------- | --------------------------------------- | ---------------------------------- |
| Resource count per project | Max number of a resource you can create | 15 VPC networks per project        |
| Rate limits (API requests) | Max API calls per second per project    | 5 admin actions/sec on Spanner API |
| Regional quotas            | Max resources per region                | 24 CPUs per region (default)       |

---

## Why Quotas Exist

| Reason                      | Detail                                                                                                   |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Prevent runaway consumption | Protects against accidental over-provisioning (e.g. creating 100 VMs instead of 10) or malicious attacks |
| Prevent billing spikes      | Caps unexpected cost surprises                                                                           |
| Force sizing consideration  | Encourages periodic review — do you really need a 96-core VM?                                            |

---

## Managing Quotas

- View current quotas on the **Quotas page** in the Google Cloud Console
- Quotas may **increase automatically** as your usage of Google Cloud grows over time
- You can **proactively request quota increases** from the Quotas page before an expected usage spike

---

## gcloud Commands

```bash
# List quotas for a project (requires Compute API)
gcloud compute project-info describe --project=my-project

# List regional quotas
gcloud compute regions describe us-central1 --project=my-project

# List quotas via the Service Usage API
gcloud services quota list --service=compute.googleapis.com --project=my-project

# Request a quota increase (opens browser to Cloud Console)
gcloud alpha quotas update --project=my-project
```
