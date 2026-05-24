# Labels in Google Cloud

## What Are Labels?

- **Key-value pairs** attached to Google Cloud resources for organization and filtering
- Can be applied to: VMs, disks, snapshots, images, and more
- Each resource supports up to **64 labels**
- Managed via: Google Cloud Console, gcloud, or Resource Manager API

---

## Common Label Use Cases

| Label Category      | Examples                                | Purpose                             |
| ------------------- | --------------------------------------- | ----------------------------------- |
| Team / Cost center  | `team:marketing`, `team:research`       | Cost accounting, budgeting          |
| Component           | `component:redis`, `component:frontend` | Distinguish app components          |
| Environment / Stage | `env:production`, `env:test`            | Filter resources by lifecycle stage |
| Owner / Contact     | `owner:gaurav`, `contact:opm`           | Identify responsible person         |
| State               | `state:inuse`, `state:readyfordeletion` | Track resource lifecycle            |

---

## What You Can Do with Labels

- **Search and list** resources — e.g. find all production VMs
- **Analyze costs** — labels propagate through billing reports
- **Run bulk operations** — use labels in scripts to target specific resource groups
- **Inventory management** — filter by team, environment, or component

---

## Labels vs Network Tags

|                            | Labels                                     | Network Tags                               |
| -------------------------- | ------------------------------------------ | ------------------------------------------ |
| Format                     | Key-value pairs                            | Plain strings                              |
| Apply to                   | Any resource (VMs, disks, snapshots, etc.) | VM instances only                          |
| Purpose                    | Organize resources, cost tracking          | Networking (firewall rules, static routes) |
| Propagates through billing | ✅                                         | ❌                                         |

---

## gcloud Commands

```bash
# Add a label to a VM instance
gcloud compute instances add-labels my-vm \
  --labels=env=production,team=marketing

# List labels on a VM
gcloud compute instances describe my-vm \
  --format="json(labels)"

# Remove a label from a VM
gcloud compute instances remove-labels my-vm \
  --labels=env

# Add a label to a disk
gcloud compute disks add-labels my-disk \
  --labels=state=inuse \
  --zone=us-central1-a

# Add a label to a Cloud Storage bucket
gcloud storage buckets update gs://my-bucket \
  --update-labels=team=research

# Filter resources by label (list VMs with a specific label)
gcloud compute instances list \
  --filter="labels.env=production"
```
