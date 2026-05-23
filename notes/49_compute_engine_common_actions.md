# Compute Engine: Common VM Actions

## Instance Metadata

- Every VM stores its metadata on a **metadata server**.
- Useful in combination with **startup and shutdown scripts** — lets you programmatically fetch instance-specific info without extra authorization.
- Example: write a startup script that reads the instance's external IP address from metadata and uses it to configure a database.
- Default metadata keys are the **same on every instance**, so scripts can be reused across instances without modification — reduces brittle code.
- **Recommended**: store startup and shutdown scripts in **Cloud Storage**.

---

## Moving a VM to a New Zone or Region

Reasons to move: geographical requirements, zone deprecation.

### Steps

1. **Shut down** the VM.
2. **Move** it to the destination zone or region.
3. **Restart** it.
4. **Update any references** to the old VM (e.g., target VMs, target pools).

> Note: Some server-generated properties of the VM and its disks change during the move.

### How to Move (High Level)

1. Create a **machine image** of the source VM.
2. Create a new VM from that machine image in the **target zone or region**.

Example: move `myinstance` from `europe-west1-c` to `us-west1-b` (with persistent disks `mybootdisk` and `mydatadisk`).

---

## Snapshots

Snapshots apply only to **persistent disks** — not local SSDs.

### Use Cases

- **Backup**: back up critical data to a durable storage solution (snapshots are stored in Cloud Storage).
- **Zone migration**: transfer data from one zone to another (e.g., to minimize latency by moving data closer to where it's used).
- **Disk type transfer**: move data from one disk type to another — e.g., from a standard HDD to an SSD persistent disk to improve performance.

### How Snapshots Work

- **Incremental** — only changes since the last snapshot are saved.
- **Automatically compressed** — faster and cheaper than creating a full image each time.
- Can be **restored to a new persistent disk** in any zone.
- You can create a **snapshot schedule** to automatically back up zonal and regional persistent disks on a regular basis.

### Snapshots vs. Images

|             | Snapshots                               | Public/Custom Images                                 |
| ----------- | --------------------------------------- | ---------------------------------------------------- |
| Primary use | Periodic backup of persistent disk data | Creating instances or configuring instance templates |
| Incremental | Yes                                     | No                                                   |
| Stored in   | Cloud Storage                           | —                                                    |

---

## Resizing a Persistent Disk

- You can **increase** the size of a persistent disk while it is attached to a running VM — no snapshot needed, no downtime.
- Benefit: larger disk size also **improves I/O performance**.
- **You can never shrink a disk** — only grow it. Keep this in mind before resizing.

---

## gcloud Commands

```bash
# Create a snapshot of a disk
gcloud compute disks snapshot my-disk \
  --zone=us-central1-a --snapshot-names=my-snapshot

# Create a snapshot schedule
gcloud compute resource-policies create snapshot-schedule my-schedule \
  --region=us-central1 --daily-schedule --start-time=04:00 \
  --max-retention-days=7

# Move a VM to a different zone
gcloud compute instances move my-vm \
  --zone=us-central1-a --destination-zone=us-west1-b

# Resize a disk (online, no downtime)
gcloud compute disks resize my-disk --zone=us-central1-a --size=200GB
```
