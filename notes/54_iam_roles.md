# IAM — Roles

## What Roles Define

Roles define the **"can do what on which resource"** part of IAM.

There are three types: **Basic**, **Predefined**, and **Custom**.

---

## 1. Basic Roles

The original roles from the Google Cloud console. They are **broad and coarse-grained** — applied to an entire project and affect all resources in it.

| Role                      | Access Level                                                                 |
| ------------------------- | ---------------------------------------------------------------------------- |
| **Viewer**                | Read-only access                                                             |
| **Editor**                | Modify and delete access (deploy apps, modify/configure resources)           |
| **Owner**                 | Full admin access — includes adding/removing members and deleting projects   |
| **Billing Administrator** | Manage billing and add/remove admins — no access to change project resources |

### Concentric Permissions

Roles are nested inside each other:

```
Owner
└── Editor
    └── Viewer
```

Each project can have multiple Owners, Editors, Viewers, and Billing Administrators.

---

## 2. Predefined Roles

Google Cloud services each offer their own predefined roles. These provide **granular access to specific resources** without granting access to unrelated ones.

- Roles are **collections of permissions** (you usually need more than one permission to do anything meaningful)
- Permissions follow the format: `service.resource.verb`
  - Example: `compute.instances.start` → start a stopped Compute Engine instance
  - These align with the corresponding REST API actions

### Example: `InstanceAdmin` Role on `project_a`

Grants a group all Compute Engine instance-level permissions (create, delete, start, stop, etc.)

### Common Compute Engine Predefined Roles

| Role              | What it allows                                                                                           |
| ----------------- | -------------------------------------------------------------------------------------------------------- |
| **Compute Admin** | Full control of all Compute Engine resources (all `compute.*` permissions)                               |
| **Network Admin** | Create, modify, delete networking resources — **except** firewall rules and SSL certificates (read-only) |
| **Storage Admin** | Create, modify, delete disks, images, and snapshots                                                      |

> **Example use case for Storage Admin:** Grant it to someone who manages project images instead of giving them the broad Editor role.

---

## 3. Custom Roles

Used when predefined roles are either **too broad** or **too narrow** for your needs.

- Built on the **principle of least privilege** — give each person only the minimum permissions needed to do their job
- You define exactly which permissions to include

### Example

Create an **"Instance Operator"** role that allows users to **start and stop** VMs but not reconfigure them — something no predefined role does exactly.

> **Note:** Custom roles must be managed manually — you are responsible for keeping them up to date as Google adds new permissions.

---

## gcloud Commands

```bash
# List all predefined roles
gcloud iam roles list

# Describe a specific role and its permissions
gcloud iam roles describe roles/compute.instanceAdmin

# Grant a role to a member on a project
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=user:alice@example.com --role=roles/editor

# Remove a role from a member
gcloud projects remove-iam-policy-binding PROJECT_ID \
  --member=user:alice@example.com --role=roles/editor
```
