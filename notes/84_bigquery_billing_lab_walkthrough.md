# Billing Data with BigQuery Lab Walkthrough

## Lab Overview

- Import exported billing data (CSV) into BigQuery
- Run simple and complex SQL queries to analyze resource billing consumption
- Use query results for capacity planning and efficiency decisions

---

## Task 1 — Import Billing Data into BigQuery

1. Navigate to **BigQuery** in the Cloud Console
2. Ensure correct Qwiklabs project ID is selected
3. **Create a dataset:**
   - Click **Create Dataset**
   - Name: `imported_billing_data`
   - Data location: `US`
   - Default table expiration: 1 day
   - Click **Create Dataset**
4. **Create a table inside the dataset:**
   - Click the dataset → **Create Table**
   - Source: **Cloud Storage** → paste the bucket path from the lab
   - Format: **CSV**
   - Destination: Native table, name: `sampleinfotable`
   - Schema: **Auto Detect**
   - Advanced → **Header rows to skip: 1** (skips the CSV header row)
   - Click **Create Table**

---

## Task 2 — Examine the Data

- Click the table → **Schema** tab — see column names and types
- Click **Details** tab — see row count (e.g. 44 rows in the small dataset)
- Click **Preview** tab — see the first few rows of data

---

## Task 3 — Simple Query

Click **Query Table** — BigQuery auto-populates the project/dataset/table in the editor.

```sql
SELECT *
FROM `project.imported_billing_data.sampleinfotable`
WHERE cost > 0
```

- Returns only rows where actual charges occurred
- Example: 20 out of 44 rows had cost > 0

---

## Task 4 — Complex Queries on Shared Dataset (22,537 records)

### View all billing records

```sql
SELECT *
FROM `project.cloud-training-prod-bucket.arc111.billing_data`
```

Returns 22,537 rows of billing data.

### Latest 100 records with charges

```sql
SELECT *
FROM `project.cloud-training-prod-bucket.arc111.billing_data`
WHERE cost > 0
ORDER BY usage_end_time DESC
LIMIT 100
```

### All charges greater than $3

```sql
SELECT *
FROM `project.cloud-training-prod-bucket.arc111.billing_data`
WHERE cost > 3
```

### Last 2 days of billing over $10

```sql
SELECT *
FROM `project.cloud-training-prod-bucket.arc111.billing_data`
WHERE cost > 10
  AND usage_end_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 DAY)
```

---

## Key Takeaways

| Activity                                 | Value                                                   |
| ---------------------------------------- | ------------------------------------------------------- |
| Import CSV billing export                | One-time setup to enable SQL analysis                   |
| Simple queries (`WHERE cost > 0`)        | Filter out zero-cost rows; understand active spend      |
| Complex queries (filters, sorts, limits) | Answer specific questions for leadership reporting      |
| Regular BigQuery use                     | Develop custom queries to monitor consumption over time |

- Billing data analysis is a key input to **capacity planning**
- Helps determine when to **scale up** (growth) or **scale down** (efficiency)

## ACE Exam-Style Practice Questions

### Q1

You need to analyze spend across many projects with fresh data and flexible SQL reporting in this BigQuery billing workflow. What is best?

A. Download CSV from reports once a month
B. Enable Billing Data Export to BigQuery and build dashboards
C. Use pricing calculator only
D. Store billing data in Cloud DNS

Answer: B
Trap: BigQuery export provides near real-time analytical visibility; reports and calculators are less flexible.

### Q2

Users must run BigQuery queries but charges must always apply to a dedicated billing project while data remains read-only in data projects. Which role split is correct?

A. bigquery.user everywhere
B. bigquery.jobUser on billing project and bigquery.dataViewer on data project
C. owner on billing project only
D. editor on data project only

Answer: B
Trap: Separate query job execution permissions from data-read permissions to control cost and access.
