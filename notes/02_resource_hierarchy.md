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
