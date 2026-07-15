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

| Permission                  | Purpose                                     |
| --------------------------- | ------------------------------------------- |
| `compute.instances.get`     | View instance details                       |
| `compute.instances.list`    | List all instances                          |
| `compute.instances.reset`   | Reset an instance                           |
| `compute.instances.resume`  | Resume a suspended (sleep/standby) instance |
| `compute.instances.start`   | Start a stopped instance                    |
| `compute.instances.stop`    | Stop a running instance                     |
| `compute.instances.suspend` | Suspend an instance                         |

8. Click **"Add"**, review the permissions, then click **"Create"**

---

## Alternative Approach

Instead of starting from scratch, you could:

1. Select the **Instance Admin** role as a base
2. Remove the permissions you don't want

---

## Important Reminder

> Custom roles are **not maintained by Google**. When new permissions, features, or services are added to Google Cloud, your custom roles will **not be updated automatically** — you must manage them yourself.

---

## gcloud Commands

```bash
# Create a custom role from scratch
gcloud iam roles create instanceOperator --project=PROJECT_ID \
  --title="Instance Operator" \
  --permissions=compute.instances.get,compute.instances.list,compute.instances.start,compute.instances.stop,compute.instances.reset,compute.instances.resume,compute.instances.suspend

# Create a custom role by copying an existing one
gcloud iam roles copy \
  --source=roles/compute.instanceAdmin \
  --destination=instanceOperator \
  --dest-project=PROJECT_ID

# List custom roles in a project
gcloud iam roles list --project=PROJECT_ID

# Update a custom role (add permissions)
gcloud iam roles update instanceOperator --project=PROJECT_ID \
  --add-permissions=compute.instances.getSerialPortOutput

# Delete a custom role
gcloud iam roles delete instanceOperator --project=PROJECT_ID
```

## ACE Exam-Style Practice Questions

### Q1
For Iam Custom Role Demo, a team needs only permission to read logs and datasets without modification rights. What is best?

A. roles/editor
B. roles/owner
C. Predefined read-only roles assigned to a Google Group
D. Shared admin account

Answer: C
Trap: Broad primitive roles are common distractors when least privilege is explicit.

### Q2
In a Iam Custom Role Demo question, two options work technically but one grants extra permissions. Which should you choose?

A. Broad role for future convenience
B. Narrow role that satisfies exact requirement
C. Owner to avoid access errors
D. Service account key in source code

Answer: B
Trap: Exam scoring favors least privilege and operational safety.
