# 🖥️ Compute Engine

## What is Compute Engine?

Google Cloud's **IaaS** solution — lets you create and run virtual machines on Google's infrastructure.

- No upfront investment needed.
- Thousands of virtual CPUs can run simultaneously.
- Designed for speed and consistent performance.

---

## What a VM Can Do

Each VM has the full power of an operating system. You configure it like a physical server:

- How many **CPUs** and how much **memory**
- How much **storage** and what **type**
- Which **operating system**

### Ways to Create a VM

- **Google Cloud Console** — web-based UI
- **Google Cloud CLI** — command line
- **Compute Engine API** — programmatically

### Supported Operating Systems

- Linux and Windows Server images provided by Google
- Customized versions of those images
- Other operating systems you build yourself

---

## Cloud Marketplace

A quick way to get started — offers pre-configured solutions from Google and third-party vendors.

- No manual setup of software, VMs, storage, or networking.
- Most packages are free beyond normal Google Cloud usage fees.
- Third-party images with commercial software may have extra charges — all shown upfront before launch.

---

## Pricing & Billing

### Billing by the Second

- Compute Engine bills **per second**, with a **1-minute minimum**.

### Sustained-Use Discounts

- Automatically applied the longer a VM runs.
- If a VM runs for **more than 25% of a month**, Google automatically discounts every additional minute.

### Committed-Use Discounts

- For stable, predictable workloads.
- Commit to **1 year or 3 years** of a specific amount of vCPUs and memory.
- Save up to **57% off** normal prices.

---

## Preemptible & Spot VMs

For workloads that don't need a human waiting on them (e.g. batch jobs, data processing).

> Save up to **90%** compared to regular VMs.

The trade-off: Google can **terminate the VM at any time** if it needs those resources elsewhere.
You must ensure your job can be **stopped and restarted**.

### Preemptible vs. Spot VMs

| Feature             | Preemptible VM | Spot VM    |
| ------------------- | -------------- | ---------- |
| Max runtime         | 24 hours       | No maximum |
| More features       | ❌             | ✅         |
| Pricing (currently) | Same           | Same       |

---

## Storage

- High throughput between processing and persistent disks is the **default** — no special configuration needed.
- No extra cost for this.

---

## Custom Machine Types

You're not locked into predefined sizes. Choose exactly what you need:

- Set your own number of **virtual CPUs**
- Set your own amount of **memory**
- Pay only for what you actually use
