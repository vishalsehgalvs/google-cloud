# Identity and Access Management (IAM) — Overview

## What is IAM?

IAM answers three questions:

- **Who** — a person, group, or application
- **Can do what** — specific privileges or actions
- **On which resource** — any Google Cloud service

### Example

Granting someone the **Compute Viewer** role gives them:

- Read-only access to get and list Compute Engine resources
- No access to read data stored on those resources

---

## IAM Objects

IAM is made up of several components covered in this module:

- Organizations
- Folders
- Projects
- Resources
- Roles
- Members
- Service Accounts

---

## IAM Resource Hierarchy

Google Cloud resources are organized in a tree structure:

```
Organization  (root — represents your company)
└── Folders   (represent departments)
    └── Projects  (represent trust boundaries)
        └── Individual Resources
```

### Key Rules

- Each resource has **exactly one parent**
- IAM roles granted at a higher level are **inherited** by all resources below it

### Level-by-Level Breakdown

| Level            | Represents         | Inheritance Scope                                |
| ---------------- | ------------------ | ------------------------------------------------ |
| **Organization** | Your company       | Roles here apply to all resources in the org     |
| **Folder**       | A department       | Roles here apply to all resources in the folder  |
| **Project**      | A trust boundary   | Services in the same project share default trust |
| **Resource**     | Individual service | Most granular level                              |

---

## gcloud Commands

```bash
# View IAM policy on a project
gcloud projects get-iam-policy PROJECT_ID

# View IAM policy on an organization
gcloud organizations get-iam-policy ORG_ID

# View IAM policy on a folder
gcloud resource-manager folders get-iam-policy FOLDER_ID
```

## ACE Exam-Style Practice Questions

### Q1
For Iam Overview, a team needs only permission to read logs and datasets without modification rights. What is best?

A. roles/editor
B. roles/owner
C. Predefined read-only roles assigned to a Google Group
D. Shared admin account

Answer: C
Trap: Broad primitive roles are common distractors when least privilege is explicit.

### Q2
In a Iam Overview question, two options work technically but one grants extra permissions. Which should you choose?

A. Broad role for future convenience
B. Narrow role that satisfies exact requirement
C. Owner to avoid access errors
D. Service account key in source code

Answer: B
Trap: Exam scoring favors least privilege and operational safety.
