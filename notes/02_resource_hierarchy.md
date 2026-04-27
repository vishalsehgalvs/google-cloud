# 🏗️ Google Cloud Resource Hierarchy

## The 4 Levels (Bottom → Top)

```
Organization Node
    └── Folders (& sub-folders)
            └── Projects
                    └── Resources (VMs, buckets, BigQuery tables, etc.)
```

| Level                 | What it is                                                            |
| --------------------- | --------------------------------------------------------------------- |
| **Resources**         | The actual things — VMs, Cloud Storage buckets, BigQuery tables, etc. |
| **Projects**          | Groups of resources; the basic unit for billing, APIs, and access     |
| **Folders**           | Groups of projects (can be nested); used to mirror org structure      |
| **Organization Node** | The top — encompasses everything in your company                      |

---

## Why This Matters — Policies & Inheritance

- Policies can be set at **project, folder, or organization node** level.
- Some services also allow policies on individual resources.
- **Policies inherit downward** — a policy on a folder automatically applies to all projects inside it.

---

## Projects — The Core Unit

Every resource belongs to **exactly one project**. Projects are what you use to:

- Enable Google Cloud services & APIs
- Set up billing
- Add/remove team members

### 3 Identifying Attributes of a Project

| Attribute          | Set by                      | Changeable?  | Unique?            |
| ------------------ | --------------------------- | ------------ | ------------------ |
| **Project ID**     | Google (you can suggest it) | ❌ Immutable | ✅ Globally unique |
| **Project Name**   | You                         | ✅ Yes       | ❌ Not required    |
| **Project Number** | Google                      | ❌ Immutable | ✅ Globally unique |

- **Project ID** = what you use to tell Google Cloud which project to work with.
- **Project Number** = used internally by Google; you won't need it much.

### Resource Manager Tool

- An API to manage projects programmatically.
- Can: list, create, update, delete, and even **recover deleted projects**.
- Accessible via RPC API and REST API.

---

## Folders — Organizing at Scale

- Group projects by department, team, or environment (e.g. dev/staging/prod).
- Policies set on a folder apply to **all projects and resources inside it** — no need to duplicate.
- Teams can be given **delegated admin rights** within their own folder.
- Folders can contain other folders (nested).
- **Requires an organization node** to use folders.

> Example: Two projects managed by the same team → put them in one folder → set permissions once, not twice.

---

## Organization Node — The Top of the Tree

- Everything in your Google Cloud account sits under this node.
- **Special roles at this level:**
  - **Organization Policy Administrator** — only these people can change org-wide policies.
  - **Project Creator** — controls who can spin up new projects (and spend money).

### How to Get an Organization Node

| If you have...              | Then...                                                                    |
| --------------------------- | -------------------------------------------------------------------------- |
| **Google Workspace** domain | Projects automatically belong to your org node                             |
| No Workspace                | Use **Cloud Identity** (Google's identity & access platform) to create one |

Once created, anyone in the domain can create projects and billing accounts as usual — but now it's all organized under the org node.

---

## 🔑 Identity and Access Management (IAM)

### What is IAM?

A way for admins to control **who can do what on which resources** in Google Cloud.

> IAM = **Who** (principal) + **Can do what** (role) + **On which resource**

---

### The "Who" — Principals

A principal is anyone or anything that can be granted access. Each has an email-based identifier.

| Type                  | Example                       |
| --------------------- | ----------------------------- |
| Google Account        | individual user               |
| Google Group          | team or department            |
| Service Account       | an app or VM acting as a user |
| Cloud Identity domain | your whole company            |

---

### The "Can Do What" — Roles

A **role** is a bundle of permissions. You grant roles to principals — not individual permissions.

> Example: Managing VMs requires create, delete, start, stop, change permissions → bundled into one role.

#### 1. Basic Roles — Broad, project-wide

Applied to a whole project and affect **all resources** in it. Use with caution for sensitive projects.

| Role                      | What they can do                                          |
| ------------------------- | --------------------------------------------------------- |
| **Viewer**                | Read-only access                                          |
| **Editor**                | View + make changes                                       |
| **Owner**                 | View + change + manage roles/permissions + set up billing |
| **Billing Administrator** | Manage billing only — no access to resources              |

> ⚠️ Basic roles are too broad for sensitive data projects. Use predefined or custom roles instead.

#### 2. Predefined Roles — Specific to a service

Each Google Cloud service offers its own set of predefined roles with precise permissions.

- Applied at project, folder, or organization level.
- Example: Compute Engine's **`instanceAdmin`** role → lets you fully manage VM instances.
- Much safer and more precise than basic roles.

#### 3. Custom Roles — You define exactly what's allowed

Use when predefined roles are still too broad. Follow the **least-privilege model** — give people only what they need.

- Example: Create an **`instanceOperator`** role that can start/stop VMs but NOT reconfigure them.
- **Important limitations:**
  - You have to manage the permissions yourself.
  - Can only be applied at **project** or **organization** level — ❌ not at folder level.

---

### Policies & Inheritance

- A policy = a principal + a role, applied to a resource.
- Policies **inherit downward** — apply a role at the folder level → it applies to all projects inside.
- **Deny rules** always take priority over allow rules — checked first, regardless of what roles are granted.
- Deny policies also inherit downward through the hierarchy.

---

### Quick Recap

```
Basic Roles      → broad, whole project, 4 types (viewer/editor/owner/billing admin)
Predefined Roles → service-specific, precise, recommended for most cases
Custom Roles     → you define them, least-privilege, project/org level only
```

---

## 🤖 Service Accounts

### What is a Service Account?

A special account for **programs/apps/VMs** — not humans. Lets a VM or app interact with other Google Cloud services automatically, without anyone manually granting access each time.

> Think of it as: giving a virtual machine its own identity and permissions.

### How it Works

- Named like an email address (e.g. `my-vm@my-project.iam.gserviceaccount.com`)
- Uses **cryptographic keys** instead of passwords to authenticate.
- You assign IAM roles to the service account, just like you would to a person.

### Example

- VM needs to store data in Cloud Storage (but no one else on the internet should access it).
- Create a service account → grant it access to Cloud Storage → attach it to the VM.
- Now the VM can read/write to Cloud Storage automatically and securely.

### Service Accounts are Also Resources

A service account is both an **identity** (like a user) AND a **resource** (like a VM).
This means you can attach IAM policies to the service account itself to control who can manage it.

| Person | Role on the Service Account                                        |
| ------ | ------------------------------------------------------------------ |
| Alice  | Editor — can manage which accounts can act as this service account |
| Bob    | Viewer — can only see the service account exists                   |

---

## 🪪 Cloud Identity

### The Problem with Using Gmail Accounts

Many teams start by logging into Google Cloud with personal Gmail accounts and sharing access via Google Groups. This works initially but causes problems:

- No central management of who has access.
- If someone leaves the company, there's **no easy way to revoke their access** immediately.

### What Cloud Identity Does

Cloud Identity lets organizations **centrally manage users and groups** via the **Google Admin Console**.

- Admins can use the **same usernames and passwords** from existing **Active Directory or LDAP** systems — no need to create separate Google accounts.
- When someone leaves, an admin can instantly **disable their account and remove them from all groups** from one place.

### Editions

| Edition     | What's included                                   |
| ----------- | ------------------------------------------------- |
| **Free**    | User & group management, SSO, policy controls     |
| **Premium** | Everything in Free + **mobile device management** |

### Already a Google Workspace customer?

This is all already built into the **Google Admin Console** for you — no extra setup needed.
