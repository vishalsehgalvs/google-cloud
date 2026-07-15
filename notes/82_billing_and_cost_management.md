# Billing, Budgets, and Cost Management

## Budgets

Set a budget to track spend and get alerted before costs grow out of control.

### How to Set a Budget

1. Go to **Billing** → **Budgets & Alerts** → **Create Budget**
2. Set a **budget name** and select the **project** it applies to
3. Set the budget amount:
   - A specific dollar amount, OR
   - Match it to the **previous month's spend**
4. Configure **alert thresholds**

---

## Budget Alerts

Alerts send emails to **Billing Admins** when spend crosses a threshold.

| Alert Type        | Example                                                                  |
| ----------------- | ------------------------------------------------------------------------ |
| Percent of budget | Alert at 50%, 90%, 100% of budget                                        |
| Forecasted spend  | Alert when spend is **forecasted** to exceed the budget by end of period |

### Email Notification Contains

- Project name
- Percent of budget exceeded
- Budget amount

---

## Programmatic Alerts with Pub/Sub

- Connect a budget to a **Pub/Sub topic** to receive spend updates programmatically
- Create a **Cloud Run function** that listens to the Pub/Sub topic to automate cost management (e.g. shut down non-critical resources when budget is exceeded)

```
Budget threshold exceeded
        │
        ▼
   Pub/Sub Topic
        │
        ▼
 Cloud Run Function  →  automated action (e.g. stop VMs)
```

---

## Cost Optimization with Labels

- Label VM instances and resources across regions
- Identify resources sending traffic to distant continents (higher networking cost)
- Actions to reduce cost:
  - Relocate instances closer to users
  - Use **Cloud CDN** to cache content closer to users → reduces networking spend

---

## Analyzing Billing Data

| Tool              | Purpose                                                                          |
| ----------------- | -------------------------------------------------------------------------------- |
| **BigQuery**      | Export billing data; run SQL queries to analyze spend by label, project, service |
| **Looker Studio** | Visualize spend over time; create dashboards sliced by labels, projects, regions |

### Recommended Workflow

1. Label all resources (team, env, component, etc.)
2. Export billing data to BigQuery
3. Query spend by label/project/service
4. Visualize with Looker Studio dashboards

---

## gcloud Commands

```bash
# List billing accounts
gcloud billing accounts list

# Link a billing account to a project
gcloud billing projects link my-project \
  --billing-account=BILLING_ACCOUNT_ID

# Describe billing info for a project
gcloud billing projects describe my-project

# List projects linked to a billing account
gcloud billing projects list --billing-account=BILLING_ACCOUNT_ID

# Export billing data to BigQuery (done via Console or Billing API — no direct gcloud command)
# Recommended: Billing → Billing Export → BigQuery Export in Cloud Console
```

## ACE Exam-Style Practice Questions

### Q1
For Billing And Cost Management, you need to be notified at 50%, 90%, and 100% spend and also prevent runaway usage. What is best?

A. Budgets only
B. Quotas only
C. Budget alerts plus quotas
D. Cloud Trace only

Answer: C
Trap: Budgets notify while quotas enforce hard limits.

### Q2
You manage many sandbox projects in a Billing And Cost Management scenario and need owner-specific overspend alerts. What is best?

A. One shared budget for all projects
B. Budget per project with alert thresholds
C. CSV export once per quarter
D. Single alert at billing account only

Answer: B
Trap: Per-project budgets improve accountability and alert precision.
