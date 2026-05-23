# IAM — Organization Node and Folders

## The Organization Node

The **organization resource** is the root node in the Google Cloud resource hierarchy — it represents your entire company.

### Key Roles at the Organization Level

| Role                   | What it does                                                                 |
| ---------------------- | ---------------------------------------------------------------------------- |
| **Organization Admin** | Full access to administer all resources in the org (useful for auditing)     |
| **Project Creator**    | Allows creating projects within the org (inherited by all projects below it) |
| **Viewer**             | Read-only view access to all resources within the organization               |

---

## How the Organization Resource Gets Created

- When a user with a **Google Workspace** or **Cloud Identity** account creates a Google Cloud project, an organization resource is **automatically provisioned**.
- Google Cloud then notifies the **Google Workspace / Cloud Identity super admins** of its availability.

> Super admin accounts have a lot of control — use them carefully.

---

## Two Critical Roles During Setup

These two roles are typically assigned to **different users or groups**:

### Google Workspace / Cloud Identity Super Admin

- Assigns the Organization Admin role to users
- Acts as point of contact for recovery issues
- Controls the lifecycle of the Workspace/Cloud Identity account and organization resource

### Organization Admin

- Defines IAM policies
- Determines the structure of the resource hierarchy
- Delegates responsibility for networking, billing, and hierarchy through IAM roles

> **Principle of Least Privilege:** The Organization Admin role does NOT include permissions like creating folders. Those must be explicitly added.

---

## Folders — Sub-Organizations Within the Org

Folders provide **grouping and isolation** between projects. They can model:

- Legal entities
- Departments
- Teams
- Applications

### Example Structure

```
Organization
├── Department X
│   ├── Team A
│   │   ├── Product 1
│   │   └── Product 2
│   └── Team B
└── Department Y
```

### Why Folders Matter

- **Delegation:** Department heads can be granted full ownership of all resources in their folder.
- **Access isolation:** Users in one department can be restricted to only their folder's resources.

### Folder-Level Roles

| Role               | What it does                               |
| ------------------ | ------------------------------------------ |
| **Folder Admin**   | Full control over folders                  |
| **Folder Creator** | Browse hierarchy and create folders        |
| **Folder Viewer**  | View folders and projects below a resource |

---

## Project-Level Roles

| Role                | What it does                                                 |
| ------------------- | ------------------------------------------------------------ |
| **Project Creator** | Create new projects; creator automatically becomes the owner |
| **Project Deleter** | Delete projects                                              |

---

## Key Inheritance Rule

> Policies are inherited **top to bottom** — roles granted at the organization level flow down to folders, projects, and individual resources.

---

## gcloud Commands

```bash
# List organizations
gcloud organizations list

# Grant a role at the org level
gcloud organizations add-iam-policy-binding ORG_ID \
  --member=user:admin@example.com --role=roles/resourcemanager.organizationAdmin

# Create a folder
gcloud resource-manager folders create \
  --display-name=FOLDER_NAME --organization=ORG_ID

# List folders under an org
gcloud resource-manager folders list --organization=ORG_ID

# Delete a folder
gcloud resource-manager folders delete FOLDER_ID

# Create a project
gcloud projects create PROJECT_ID --folder=FOLDER_ID

# Delete a project
gcloud projects delete PROJECT_ID
```
