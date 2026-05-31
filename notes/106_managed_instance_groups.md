# Managed Instance Groups (MIGs)

## What Is a MIG?

A **Managed Instance Group** is a collection of identical VM instances controlled as a single entity using an **instance template**.

---

## Key Features

- **Rolling updates** — update all instances by specifying a new template
- **Autoscaling** — automatically scales the number of instances based on load
- **Load balancing integration** — distributes network traffic across all instances in the group
- **Auto-healing** — if an instance stops, crashes, or is deleted outside of group commands, the MIG automatically recreates it with the same name and instance template
- **Health checks** — identifies and recreates unhealthy instances to keep all instances running optimally

---

## Regional vs. Zonal MIGs

| Type                           | Description                                                                          |
| ------------------------------ | ------------------------------------------------------------------------------------ |
| **Regional MIG** (recommended) | Spreads instances across multiple zones in a region; protects against zonal failures |
| **Zonal MIG**                  | All instances in a single zone; simpler but no cross-zone redundancy                 |

> If all instances in a single zone malfunction, a regional MIG continues serving traffic from instances in another zone within the same region.

---

## Creating a MIG

### Step 1 — Create an Instance Template

- Works like creating a regular VM instance, but the choices are saved and reused
- Can be created via Cloud Console, gcloud, or API

### Step 2 — Create the Managed Instance Group

When creating a MIG, define the following:

1. **Type** — stateless (serving/batch workloads like website frontends, image processing) or stateful (databases, legacy apps)
2. **Name** — unique name for the group
3. **Location** — single-zone or multi-zone; choose the zone(s)/region
4. **Port name mapping** (optional) — map named ports for load balancing
5. **Instance template** — select the template to use
6. **Autoscaling** — enable/disable and configure scaling policies
7. **Health check** — define which instances are healthy and should receive traffic

> The instance group manager automatically populates the group based on the chosen template.
