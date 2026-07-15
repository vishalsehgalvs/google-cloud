# Google Cloud Resource Hierarchy, Projects, and IAM

## Resource Hierarchy (Bottom to Top)

| Level                     | Description                                                 |
| ------------------------- | ----------------------------------------------------------- |
| **1 — Resources**         | VMs, containers, BigQuery tables, etc.                      |
| **2 — Projects**          | Resources are organized into projects                       |
| **3 — Folders**           | Projects can be grouped into folders or subfolders          |
| **4 — Organization node** | Top level; encompasses all folders, projects, and resources |

---

## Policies and Inheritance

- Policies can be defined at the **project**, **folder**, and **organization node** levels
- Some services also allow policies on **individual resources**
- **Policies are inherited downward** — a policy applied to a folder applies to all projects inside it

---

## Projects

- The basis for enabling and using Google Cloud services (APIs, billing, collaborators, etc.)
- Each resource belongs to **exactly one project**
- Projects can have different owners and users — they are **billed and managed separately**

### Project Identifiers

| Attribute          | Set By                    | Unique?                   | Changeable?                          |
| ------------------ | ------------------------- | ------------------------- | ------------------------------------ |
| **Project ID**     | Google (user can suggest) | Globally unique           | No (immutable)                       |
| **Project name**   | User                      | Not required to be unique | Yes                                  |
| **Project number** | Google                    | Unique                    | No — used internally by Google Cloud |

---

## Folders

- Group projects under an organization in a hierarchy (e.g., per department)
- Allow teams to **delegate administrative rights** so they can work independently
- Can be nested (subfolders)

---

## Identity and Access Management (IAM)

- Administrators use IAM to define **who can do what on which resources**

### IAM Policy Components

| Component             | Description                                                                                           |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| **Who** (principal)   | Google account, Google group, service account, or Cloud Identity domain — identified by email address |
| **Can do what**       | Defined by an **IAM role**                                                                            |
| **On which resource** | The resource the policy applies to                                                                    |

### IAM Roles

- A role is a **collection of permissions**
- Granting a role to a principal grants all permissions in that role
- Example: managing VMs requires create, delete, start, stop, and change permissions — these are grouped into a single role

---

## Shared Responsibility for Security

> "If you configure or store it, you're responsible for securing it."

| Responsibility                             | Owner            |
| ------------------------------------------ | ---------------- |
| Hardware, networks, physical security      | **Google Cloud** |
| Configurations, access policies, user data | **Customer**     |

Security in the cloud is a **shared responsibility** regardless of which cloud provider you use.

## ACE Exam-Style Practice Questions

### Q1
In a Resource Hierarchy Projects Iam requirement, resources must be restricted to approved regions only. What should you use?

A. Budget alerts
B. Organization Policy for resource location restrictions
C. Cloud Scheduler
D. Labels only

Answer: B
Trap: IAM controls who can act; Org Policy controls what can be created under governance constraints.

### Q2
A new team needs isolated IAM, APIs, quotas, and billing in a Resource Hierarchy Projects Iam setup. What is best first step?

A. Create new project for the team
B. Add team as Editor to existing project
C. Create only a folder
D. Use one service account for all teams

Answer: A
Trap: Project is the operational boundary for billing, IAM bindings, API enablement, and quotas.
