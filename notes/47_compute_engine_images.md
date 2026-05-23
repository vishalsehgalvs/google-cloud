# Compute Engine: Images

## What a Boot Disk Image Contains

When creating a VM, you choose a **boot disk image**. It includes:

- Boot loader
- Operating system
- File system structure
- Pre-configured software
- Any other customizations

---

## Public Images

- Available for both **Linux** and **Windows**.
- Some are **premium images** (marked with a `p`):
  - Charged **per second** after a 1-minute minimum.
  - Exception: **SQL Server images** are charged **per minute** after a 10-minute minimum.
  - Premium image prices vary with **machine type** but are **global** — they do not vary by region or zone.

---

## Custom Images

- Create a custom image by pre-installing software authorized for your organization.
- Can be **imported** from:
  - On-premises or a local workstation
  - Another cloud provider
- Importing is a **no-cost service** — just install an agent.
- Custom images can be **shared** within the same project or across other projects.

---

## Machine Images

- A **machine image** is a Compute Engine resource that stores all of the following from one or more disks:
  - Configuration
  - Metadata
  - Permissions
  - Data
- Used to create a full VM instance from a saved state.
- Ideal for:
  - **Disk backups**
  - **Instance cloning and replication**
  - System maintenance scenarios (creation, backup and recovery)

---

## gcloud Commands

```bash
# List available public images
gcloud compute images list

# Create a custom image from a disk
gcloud compute images create my-image \
  --source-disk=my-disk --source-disk-zone=us-central1-a

# Create a machine image from a running VM
gcloud compute machine-images create my-machine-image \
  --source-instance=my-vm --source-instance-zone=us-central1-a

# Delete a custom image
gcloud compute images delete my-image
```
