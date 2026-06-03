# Google Cloud Billing and Cost Controls

## How Billing Works

- Billing is established at the **project level** of the resource hierarchy
- When you create a project, you **link a billing account** to it
- The billing account holds all payment configuration

### Billing Account Rules

| Rule                               | Details                                                                             |
| ---------------------------------- | ----------------------------------------------------------------------------------- |
| A billing account can be linked to | Zero or more projects                                                               |
| Projects without a billing account | Can only use free Google Cloud services                                             |
| Charges                            | Automatic — invoiced monthly or at a threshold limit                                |
| **Billing subaccounts**            | Used to separate billing by project (e.g., resellers use one subaccount per client) |

---

## Tools to Control Costs

### 1. Budgets

- Set at the **billing account level** or **project level**
- Can be a **fixed limit** or tied to a metric (e.g., a percentage of the previous month's spend)

### 2. Alerts

- Notify you when costs approach your budget limit
- Example: budget of $20,000 with an alert at 90% → notification when spend reaches $18,000
- Default alert thresholds: **50%, 90%, and 100%** (can be customized)

### 3. Reports

- A **visual tool in the GCP Console** to monitor expenditure by project or service

### 4. Quotas

- Prevent over-consumption of resources due to **errors or malicious attacks**
- Applied at the **project level**
- Protects both individual account owners and the Google Cloud community

#### Two Types of Quotas

| Type                  | Description                                 | Example                                          |
| --------------------- | ------------------------------------------- | ------------------------------------------------ |
| **Rate quotas**       | Reset after a specific time period          | GKE API: 3,000 calls per project per 100 seconds |
| **Allocation quotas** | Govern the number of resources you can have | Default: max 5 VPC networks per project          |

> All projects start with the same default quotas. Some quotas can be increased by requesting a limit increase from Google Cloud Support.
