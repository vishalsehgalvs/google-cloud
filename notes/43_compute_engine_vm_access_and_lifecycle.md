# VM Access, Lifecycle, and OS Management

## Accessing a VM

### Linux Instances

- The **instance creator** has full **root privileges** by default.
- Creator has **SSH access** and can grant SSH access to other users via the GCP Console.
- Required firewall rule: allow TCP port **22** (SSH).

### Windows Instances

- The creator uses the Console to generate a **username and password**.
- Anyone with those credentials can connect using an **RDP (Remote Desktop Protocol)** client.
- Required firewall rule: allow TCP port **3389** (RDP).

> If you're using the **default network**, these firewall rules are already defined — no manual setup needed.

---

## VM Lifecycle

A VM moves through several states from creation to deletion:

| State                      | What's Happening                                                                |
| -------------------------- | ------------------------------------------------------------------------------- |
| **Provisioning**           | Resources (CPU, memory, disks) are being reserved; VM not running yet           |
| **Staging**                | Resources acquired; IP addresses added, system image booting                    |
| **Running**                | VM is live; startup scripts run; SSH/RDP access enabled                         |
| **Stopping**               | Shutdown scripts run; transitioning to terminated                               |
| **Terminated**             | VM is stopped; can be restarted or deleted                                      |
| **Repairing**              | Internal error or host unavailable; VM unusable; not billed; not covered by SLA |
| **Suspending / Suspended** | VM is being suspended; can be resumed or deleted                                |

### While Running, You Can

- **Live migrate** the VM to another host in the same zone (no reboot needed).
- Move the VM to a **different zone**.
- Take a **snapshot** of the persistent disk.
- **Export** the system image.
- **Reconfigure metadata**.

### Stopping a VM (Required For)

- Upgrading machine type (e.g., adding more CPU).
- Changing the image is **not possible** on a stopped VM.

### Reset vs. Stop

- **Reset**: wipes memory and restarts the VM back to its initial state; VM stays in the **running** state throughout.
- **Stop**: transitions the VM to **terminated**; can then restart or delete.

### Shutdown Timing

- Normal shutdown (stop, reboot, delete): allows ~**90 seconds** for shutdown scripts.
- **Preemptible VMs**: if the instance doesn't stop within **30 seconds**, Compute Engine sends an **ACPI G3 Mechanical Off** signal — keep this in mind when writing shutdown scripts.

### Billing While Terminated

- You are **not charged** for CPU and memory when a VM is terminated.
- You **are charged** for any **attached persistent disks** and **reserved static IP addresses**.

---

## Availability Policies

- **On host maintenance**: default behavior is **live migrate**; can be changed to **terminate** during maintenance events.
- **Automatic restart**: if a VM is terminated due to a crash or maintenance, it **restarts automatically** by default; this can be disabled.
- These settings can be configured at **creation time** or **while the VM is running**.

---

## OS Patch Management

- When you use a **premium OS image**, the cost includes both OS usage and **patch management**.
- Use **OS Patch Management** to apply OS patches across a fleet of Compute Engine VMs.
- Long-running VMs need regular updates to stay secure and stable.

### Two Main Components

1. **Patch compliance reporting** — shows patch status across Windows and Linux VMs, with recommendations.
2. **Patch deployment** — automates OS and software patch updates via scheduled patch jobs.

### What You Can Do

- Create **patch approvals** — choose exactly which patches to apply from the available set.
- Set up **flexible scheduling** — one-time or recurring patch schedules.
- Apply **advanced configurations** — add pre/post patching scripts.
- Manage all patch jobs from a **centralized location**.

---

## gcloud Commands

```bash
# SSH into a Linux VM
gcloud compute ssh my-vm --zone=us-central1-a

# Start a stopped VM
gcloud compute instances start my-vm --zone=us-central1-a

# Stop a running VM
gcloud compute instances stop my-vm --zone=us-central1-a

# Reset a VM (wipes memory, restarts)
gcloud compute instances reset my-vm --zone=us-central1-a

# Suspend a VM
gcloud compute instances suspend my-vm --zone=us-central1-a

# Resume a suspended VM
gcloud compute instances resume my-vm --zone=us-central1-a
```

## ACE Exam-Style Practice Questions

### Q1
A Compute Engine Vm Access And Lifecycle workload requires full OS control and custom runtime with strict policy against managed platforms. Which compute option is best?

A. Compute Engine
B. Cloud Run Functions
C. App Engine Standard
D. Dataflow

Answer: A
Trap: Full host-level control is a strong Compute Engine signal.

### Q2
In a Compute Engine Vm Access And Lifecycle scenario, a fault-tolerant nightly batch workload is too expensive. What should you test and then use?

A. Spot or preemptible VMs after simulated interruption testing
B. Owner role on all instances
C. Single large sole-tenant node
D. Cloud DNS autoscaling

Answer: A
Trap: Interruptible workloads are classic candidates for discounted VM pricing models.
