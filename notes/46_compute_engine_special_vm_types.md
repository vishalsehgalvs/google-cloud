# Compute Engine: Special VM Types

## Preemptible VMs

- Run at **60–91% discount** compared to normal instances.
- Can be **preempted at any time** by GCP if it needs those resources.
- **No charge** if the VM is preempted within the first minute.
- Maximum runtime: **24 hours**.
- You get a **30-second notification** before the machine is preempted.
- **No live migration** and **no automatic restarts**.
- You can use external monitoring and load balancers to automatically start new preemptible VMs if one is preempted.

### Best Use Case: Batch Processing

- If some instances terminate mid-job, the job slows down but does not stop completely.
- Lets you complete batch tasks without adding load to existing instances and without paying full price.

---

## Spot VMs

- Spot VMs are the **latest version** of preemptible VMs, using the **spot provisioning model**.
- Preemptible VMs continue to be supported and use the same pricing as Spot VMs.
- Key difference: Spot VMs have **no maximum runtime** (preemptible VMs cap at 24 hours).

### What's the Same as Preemptible VMs

- GCP may preempt Spot VMs at any time to reclaim resources.
- **No live migration** to standard VMs while running.
- **No automatic restart** on maintenance events.
- Finite capacity — not always available; availability varies by day and zone.

### Tips for Getting Spot VM Capacity

- Capacity is easier to obtain for **smaller machine types** (fewer vCPUs and less memory).
- Resources come from Google's excess and backup capacity.

---

## Sole-Tenant Nodes

- A **sole-tenant node** is a physical Compute Engine server dedicated exclusively to **your project**.
- All VM instances on the node belong to the same project — physically isolated from other customers.
- Use cases:
  - Compliance requirements (e.g., payment processing workloads that must be isolated).
  - Grouping instances together on the same host hardware.
- You can fill a node with **multiple smaller VM instances** of varying sizes, including custom machine types and extended memory instances.
- Supports **bring-your-own-license (BYOL)** for existing OS licenses, with the in-place restart feature to minimize physical core usage.

---

## Shielded VMs

- Offer **verifiable integrity** — you can be confident instances haven't been compromised by boot-level malware or rootkits.
- Integrity is achieved through three mechanisms:
  1. **Secure Boot** — only trusted software is allowed to run during boot.
  2. **vTPM-enabled Measured Boot** — virtual Trusted Platform Module measures the boot process.
  3. **Integrity monitoring** — compares boot measurements against a trusted baseline.
- Part of the **Shielded Cloud Initiative**, which aims to provide a more secure foundation across all of Google Cloud.
- Features include **vTPM shielding/sealing** to help prevent data exfiltration.
- To use Shielded VM features, you must select a **shielded image** when creating the VM.

---

## Confidential VMs

- Allow you to **encrypt data in use** — while it is being processed in memory.
- No code changes required; no significant performance penalty.
- Built on **N2D Compute Engine VM instances** running on **AMD EPYC "Rome"** (2nd Gen) processors.
- Uses **AMD Secure Encrypted Virtualization (SEV)** for inline memory encryption.
- The AMD Rome processor family is optimized for:
  - High memory capacity
  - High throughput
  - Parallel workloads
- **Google does not have access to the encryption keys**.
- Can be enabled when creating a VM via the GCP Console, Compute Engine API, or `gcloud` CLI.

## ACE Exam-Style Practice Questions

### Q1
A Compute Engine Special Vm Types workload requires full OS control and custom runtime with strict policy against managed platforms. Which compute option is best?

A. Compute Engine
B. Cloud Run Functions
C. App Engine Standard
D. Dataflow

Answer: A
Trap: Full host-level control is a strong Compute Engine signal.

### Q2
In a Compute Engine Special Vm Types scenario, a fault-tolerant nightly batch workload is too expensive. What should you test and then use?

A. Spot or preemptible VMs after simulated interruption testing
B. Owner role on all instances
C. Single large sole-tenant node
D. Cloud DNS autoscaling

Answer: A
Trap: Interruptible workloads are classic candidates for discounted VM pricing models.
