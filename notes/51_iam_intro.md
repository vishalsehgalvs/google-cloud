# Identity and Access Management (IAM) — Module Introduction

## What is IAM?

IAM (Identity and Access Management) is a sophisticated system built on three familiar concepts:

- **Email-like address names** — to identify who
- **Job-type roles** — to define what level of access
- **Granular permissions** — to control exactly what actions are allowed

> If you've used IAM in other systems (AWS, Azure, etc.), pay attention to how Google has made it easier to administer and more secure.

---

## What This Module Covers

1. **High-level overview** of IAM
2. **IAM components** in depth:
   - Organizations
   - Roles
   - Members
   - Service Accounts
3. **Organization Restrictions** feature
4. **Best practices** for day-to-day IAM use
5. **Hands-on lab** for first-hand IAM experience

---

## gcloud Commands

```bash
# View IAM policy for a project
gcloud projects get-iam-policy PROJECT_ID

# List all IAM roles
gcloud iam roles list

# Describe a specific role
gcloud iam roles describe roles/viewer
```

---

## Resource Hierarchy and IAM Inheritance

IAM policies are set at any level of the resource hierarchy and **inherit downward**:

```
Organization
  └── Folder
        └── Project
              └── Resource (VM, bucket, etc.)
```

- A policy granted at the **Organization** level applies to every resource in every project
- A policy granted at the **Project** level applies to all resources in that project
- **More permissive policy wins** — you cannot restrict access at a lower level if a higher level has already granted it
- Example: if a user has `Editor` at the Organization level, you cannot remove that access at the Project level

---

## IAM Policy Structure

An IAM policy is a collection of **bindings**:

```json
{
  "bindings": [
    {
      "role": "roles/storage.objectViewer",
      "members": [
        "user:alice@example.com",
        "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
        "group:devs@example.com"
      ]
    }
  ]
}
```

- **Member types**: `user:`, `serviceAccount:`, `group:`, `domain:`, `allAuthenticatedUsers`, `allUsers`
- A policy can have up to **1500 members per role binding** and **1500 bindings** total

---

## Organization Policies

**Organization Policies** are constraints applied to an entire org, folder, or project — they control **what can be configured**, not who can access it.

| Example Constraint                              | Effect                                |
| ----------------------------------------------- | ------------------------------------- |
| `constraints/compute.vmExternalIpAccess`        | Prevent VMs from having external IPs  |
| `constraints/iam.disableServiceAccountCreation` | Block new service account creation    |
| `constraints/compute.restrictCloudArmor`        | Require Cloud Armor on load balancers |
| `constraints/storage.uniformBucketLevelAccess`  | Enforce ULA on all new buckets        |

```bash
# List organisation policies on a project
gcloud org-policies list --project=PROJECT_ID

# Describe a specific policy
gcloud org-policies describe constraints/compute.vmExternalIpAccess \
  --project=PROJECT_ID
```

- Org policies are set by **Organisation Policy Administrator** (`roles/orgpolicy.policyAdmin`)
- Separate from IAM — org policies restrict configuration regardless of IAM permissions

---

## IAM Conditions

Add **attribute-based conditions** to role bindings — restrict access based on time, resource type, or request attributes:

```json
{
  "role": "roles/storage.objectViewer",
  "members": ["user:contractor@example.com"],
  "condition": {
    "title": "Expires Jan 2025",
    "expression": "request.time < timestamp('2025-01-01T00:00:00Z')"
  }
}
```

Common condition attributes:

- `request.time` — time-bounded access
- `resource.name` — restrict to specific resource
- `resource.type` — restrict to a resource type

---

## Audit Logs

IAM actions are captured in **Cloud Audit Logs**:

| Log Type           | What it captures                                                 |
| ------------------ | ---------------------------------------------------------------- |
| **Admin Activity** | IAM policy changes, role grants — always on, no cost             |
| **Data Access**    | Reading/writing resource data — off by default, can be expensive |
| **System Event**   | GCP system actions — always on, no cost                          |

```bash
# Query admin activity logs in Cloud Logging
gcloud logging read \
  'logName="projects/PROJECT_ID/logs/cloudaudit.googleapis.com%2Factivity"' \
  --limit=10
```

---

## IAM Best Practices

| Practice                                          | Why                                                                     |
| ------------------------------------------------- | ----------------------------------------------------------------------- |
| **Least privilege**                               | Grant only the minimum role needed                                      |
| **Use groups, not individuals**                   | Easier to manage; add/remove group members instead of updating bindings |
| **Avoid basic roles in production**               | `Owner/Editor/Viewer` are too broad; use predefined or custom roles     |
| **Prefer service accounts over user credentials** | For applications and automation                                         |
| **Audit regularly**                               | Review who has what access; remove stale bindings                       |
| **Use org policies**                              | Enforce guardrails at org/folder level independent of IAM               |
| **Enable VPC Service Controls**                   | Add a perimeter around sensitive APIs to prevent data exfiltration      |

## ACE Exam-Style Practice Questions

### Q1
For Iam Intro, a team needs only permission to read logs and datasets without modification rights. What is best?

A. roles/editor
B. roles/owner
C. Predefined read-only roles assigned to a Google Group
D. Shared admin account

Answer: C
Trap: Broad primitive roles are common distractors when least privilege is explicit.

### Q2
In a Iam Intro question, two options work technically but one grants extra permissions. Which should you choose?

A. Broad role for future convenience
B. Narrow role that satisfies exact requirement
C. Owner to avoid access errors
D. Service account key in source code

Answer: B
Trap: Exam scoring favors least privilege and operational safety.
