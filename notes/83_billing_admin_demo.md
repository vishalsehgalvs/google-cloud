# Billing Administration Demo

## Billing Console Overview

Navigate to: **Navigation Menu → Billing**

- View current month's consumption and credits
- Switch between multiple billing accounts (if applicable)
- See billing account name, payment method

---

## Creating a Budget and Alert (Demo Walkthrough)

**Billing → Budgets & Alerts → Create Budget**

1. **Name** — e.g. `My-Budget-Alert`
2. **Projects** — select one or multiple projects to apply the budget to
3. **Amount** — choose one:
   - Specific dollar amount (e.g. `$500`)
   - Match last month's spend (auto-populated)
   - Option to include or exclude credits
4. **Alert thresholds** — default: 50%, 90%, 100%
   - Can add custom thresholds (e.g. 25%)
   - Choose between **actual** spend or **forecasted** spend
5. **Pub/Sub** — optionally connect to a Pub/Sub topic for automated cost management
6. Click **Finish**

> After creation, the budget page shows a visual indicator of how far along you are in your spend.

---

## Transactions Page

**Billing → Transactions**

- Shows all charges line by line (Compute Engine, disk, etc.)
- Credits offset charges on trial/promotional accounts
- Useful for auditing resource usage

---

## Billing Export

**Billing → Billing Export**

Two export options:

| Option          | Destination          | Format                 |
| --------------- | -------------------- | ---------------------- |
| BigQuery export | BigQuery dataset     | Tables (SQL-queryable) |
| File export     | Cloud Storage bucket | CSV or JSON            |

### BigQuery Export Setup

1. Click **BigQuery** → **Edit Settings**
2. Define a BigQuery dataset to export to
3. Click **Save**

### File Export Setup

1. Click **File Export** → **Edit Settings**
2. Create a Cloud Storage bucket first
3. Define bucket name and file prefix
4. Choose CSV or JSON format
5. Click **Save**

---

## Payment Settings

**Billing → Payment Method**

- Review payment profiles (credit card or bank account)
- Manage payment accounts

---

## Key Takeaways

- Billing administrators set up accounts, create budgets, and run reports as routine tasks
- Billing data can be exported as **JSON or CSV** to Cloud Storage, or to **BigQuery** for advanced querying
- More sophisticated filtering and analysis happens **after** export (explored in the upcoming BigQuery billing lab)
