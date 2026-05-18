# Compute Engine Pricing

## Billing Basics

- All vCPUs, GPUs, and GB of memory are charged a **minimum of 1 minute**.
  - Example: a 30-second VM run is billed as 1 full minute.
- After the first minute, instances are charged in **1-second increments**.
- Compute Engine uses **resource-based pricing**: vCPUs and memory are billed separately, not as a bundled machine type.
  - You still create VMs using predefined machine types, but billing breaks them down into individual vCPUs and GB of memory.

---

## Discount Types (cannot be combined)

| Discount | How It Works | Max Savings |
|---|---|---|
| **Sustained use discount** | Automatic; applies when you run a resource >25% of the billing month | Up to 30% |
| **Committed use discount** | Commit to 1 or 3 years of specific vCPUs/memory | Up to 57% (most types), up to 70% (memory-optimized) |
| **Preemptible / Spot VMs** | Use excess capacity at a much lower price; may be terminated by GCP | Varies |

---

## Sustained Use Discounts

- **Automatic** — no sign-up needed.
- Kicks in when a resource (vCPU, memory, GPU) runs for more than **25% of the billing month**.
- Every incremental minute beyond 25% usage earns a bigger discount.
- Maximum discount: **30%** for resources running the full month.

| Usage in Month | Effective Discount |
|---|---|
| 25% | Discount starts |
| 50% | ~10% |
| 75% | ~20% |
| 100% | 30% |

- Discounts **reset at the start of each month** — create VMs on the **1st of the month** to maximize the discount.
- Calculated per **region**, separately for **predefined** and **custom** machine types.
- Compute Engine pools vCPUs and memory across all predefined instances in a region to maximize discount eligibility.

### Example: Two Instances in the Same Region

| Period | Instance | vCPUs | Memory |
|---|---|---|---|
| First half of month | n1-standard-4 | 4 | 15 GB |
| Second half of month | n1-standard-16 | 16 | 60 GB |

Compute Engine combines and reorganizes these into:

- **4 vCPUs + 15 GB** running for the **full month** → qualifies for full sustained use discount
- **12 vCPUs + 45 GB** running for **half the month** → qualifies for partial discount

---

## Preemptible vs. Spot VMs

Both use excess Compute Engine capacity and can be **terminated by GCP** at any time if those resources are needed elsewhere.

| | Preemptible VM | Spot VM |
|---|---|---|
| Max runtime | **24 hours** | No maximum |
| Pricing | Much lower than standard | Much lower than standard |
| Availability | Varies with demand | Varies with demand |

---

## VM Sizing Recommendations

- Compute Engine automatically provides **rightsizing recommendations** to help optimize resource usage.
- Recommendations appear **24 hours after** a new instance is created.

---

## Free Usage Limits

- Compute Engine includes a **free usage tier** — refer to current GCP documentation for limits.
