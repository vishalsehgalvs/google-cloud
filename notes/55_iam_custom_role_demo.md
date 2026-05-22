# IAM — Creating a Custom Role (Demo)

## Goal

Create an **Instance Operator** role that lets users start and stop Compute Engine VMs but not reconfigure them.

---

## Steps in the Console

1. Open the **Navigation menu** → **IAM & Admin** → **Roles**
2. Browse existing roles (you can select one as a base and add/remove permissions, or start from scratch)
3. Click **"Create Role"**
4. Fill in:
   - **Name:** Instance Operator
   - **ID:** must be unique and cannot be changed after creation
   - **Launch Stage:** Alpha → Beta → General Availability → Disabled
     - Start at Alpha, test it, then promote so others know it's available
5. Click **"Add Permissions"**
6. Filter by typing `compute.instances.` — narrows ~2,000 permissions down to 44
7. Select the following permissions:

| Permission                    | Purpose                                      |
| ----------------------------- | -------------------------------------------- |
| `compute.instances.get`       | View instance details                        |
| `compute.instances.list`      | List all instances                           |
| `compute.instances.reset`     | Reset an instance                            |
| `compute.instances.resume`    | Resume a suspended (sleep/standby) instance  |
| `compute.instances.start`     | Start a stopped instance                     |
| `compute.instances.stop`      | Stop a running instance                      |
| `compute.instances.suspend`   | Suspend an instance                          |

8. Click **"Add"**, review the permissions, then click **"Create"**

---

## Alternative Approach

Instead of starting from scratch, you could:
1. Select the **Instance Admin** role as a base
2. Remove the permissions you don't want

---

## Important Reminder

> Custom roles are **not maintained by Google**. When new permissions, features, or services are added to Google Cloud, your custom roles will **not be updated automatically** — you must manage them yourself.
