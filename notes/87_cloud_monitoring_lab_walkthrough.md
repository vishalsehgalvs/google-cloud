# Cloud Monitoring Lab Walkthrough

## Lab Overview

- Verify VMs created by Deployment Manager
- Set up a Cloud Monitoring workspace
- Create a dashboard with a chart
- Create an alerting policy with multiple conditions
- Create a resource group
- Create an uptime check

---

## Task 1 — Verify VM Instances

- Navigate to **Compute Engine** → confirm 3 nginx VMs were pre-created via Deployment Manager

---

## Task 2 — Set Up Monitoring Workspace

- Navigate to **Cloud Monitoring** → opens in a new tab
- Monitoring automatically sets up a workspace for your project
- Wait a few minutes — you'll be redirected to the **Monitoring Overview** page once ready

---

## Task 3 — Create a Dashboard and Chart

1. **Monitoring → Dashboards → Create Dashboard**
2. Name: `My Dashboard` → press Enter
3. Click **Add Chart**:
   - Title: `My Chart`
   - Resource type: `GCE VM Instance`
   - Metric: `CPU Utilization`
   - Filters: none (to see all instances)
   - View Options: select **X-Ray mode**
   - Click **Save**

### Metrics Explorer (no dashboard required)

- **Monitoring → Resources → Metrics Explorer**
- Search any metric (e.g. `CPU Utilization`) to explore without creating a chart

---

## Task 4 — Create an Alerting Policy with Multiple Conditions

1. **Monitoring → Alerting → Create Policy**
2. **Add first condition:**
   - Resource: `GCE VM Instance`
   - Metric: `CPU Usage`
   - Condition: `is above`
   - Threshold: `20`
   - Duration: `1 minute`
   - Click **Save**
3. **Add second condition:**
   - Different metric (e.g. `Reserved Cores`)
   - Condition: `is above 15`
   - Click **Save**
4. **Policy trigger:** set to **"All conditions are met"**
5. **Notifications:**
   - Add channel: **Email** → enter email address → **Add**
6. **Documentation** (best practice): describe what happened, why the alert fired, and how to fix it — makes alerts actionable
7. Name the policy: `My First Alerting Policy` → click **Save**

---

## Task 5 — Create a Resource Group

1. **Monitoring → Groups → Create Group**
2. Name: `VM Instances`
3. Criteria: **Name contains** `nginx`
4. Click **Save Group**

> All 3 nginx VMs appear in the group because their names match the filter.

---

## Task 6 — Create an Uptime Check

1. **Monitoring → Uptime Checks → Create Uptime Check**
2. Title: `My First Uptime Check`
3. Protocol: `HTTP`
4. Applies to: **Group** → select `VM Instances`
5. Check interval: **every 1 minute**
6. Click **Save** (skip creating an alert policy for now)

---

## Lab Summary

| Task              | What was done                                                   |
| ----------------- | --------------------------------------------------------------- |
| Workspace setup   | Auto-created by Cloud Monitoring for your project               |
| Dashboard + chart | CPU utilization chart with X-Ray mode                           |
| Alerting policy   | Two conditions (CPU usage + reserved cores); email notification |
| Resource group    | Grouped all nginx VMs by name filter                            |
| Uptime check      | HTTP check on VM group every 1 minute                           |
