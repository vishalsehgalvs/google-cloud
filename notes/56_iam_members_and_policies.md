# IAM — Members, Policies, and Identity

## Types of Members (the "Who")

| Member Type                 | Description                                                                                          |
| --------------------------- | ---------------------------------------------------------------------------------------------------- |
| **Google Account**          | Any individual (developer, admin, user) with a Google-associated email — including non-Gmail domains |
| **Service Account**         | Belongs to an application, not a person — used when code running on GCP needs an identity            |
| **Google Group**            | A named collection of Google Accounts and service accounts, managed via a single group email         |
| **Google Workspace Domain** | All Google Accounts in an org's Google Workspace (e.g. `username@example.com`)                       |
| **Cloud Identity Domain**   | Same as Workspace but without Gmail, Docs, Drive, Calendar — just user/group management              |

> IAM cannot create or manage users/groups — use **Cloud Identity** or **Google Workspace** for that.

---

## Policies and Bindings

- A **policy** is a collection of access statements attached to a resource
- A policy is made up of **bindings** — each binding ties one or more members to a single role
- Resources **inherit** policies from their parents in the hierarchy

### Policy Inheritance Rules

- Resource policies = **union of parent + resource policies**
- A **less restrictive parent policy overrides a more restrictive resource policy**
- Child policies **cannot restrict access granted at the parent level**

> **Example:** If you're granted Editor at the Department X level but only Viewer at the project level — you still have Editor on that project.

### Allow Policy Example

| Binding | Principal                         | Role                                      |
| ------- | --------------------------------- | ----------------------------------------- |
| 1       | jie@example.com                   | `roles/resourcemanager.organizationAdmin` |
| 2       | jie@example.com, raha@example.com | `roles/resourcemanager.projectCreator`    |

Jie has both roles; Raha only has Project Creator.

---

## Deny Policies

- Let you set **guardrails** that block specific principals from using specific permissions — regardless of what roles they're granted
- Made up of **deny rules**: specifies which principals are denied which permissions
- Optionally include a **condition** for when the denial applies
- IAM always checks **deny policies before allow policies**

---

## IAM Conditions

- Enforce **conditional, attribute-based access** to resources
- Access is only granted when the condition expression evaluates to **true**
- Specified in the role binding of an IAM policy
- Use cases:
  - Grant **temporary access** during a production incident
  - Limit access to requests made **only from the corporate office**

---

## Organization Policies

- A **configuration of restrictions** applied at the organization, folder, or project level
- Enforces constraints across an entire resource hierarchy
- Descendants inherit the organization policy from their parents
- Only a user with the **Organization Policy Admin** role can create exceptions

---

## Best Practice: Principle of Least Privilege

- Always select the **smallest scope** necessary for the task
- Use the **IAM Recommender** to identify and remove excess permissions
  - Suggests roles to remove or replace based on actual usage
  - Powered by **Policy Insights** — ML-based findings on permission usage
  - Works at project, folder, or organization level

---

## Federating Existing Identities into Google Cloud

### Google Cloud Directory Sync

- Lets admins use their **existing Active Directory or LDAP** usernames and passwords in Google Cloud
- **One-way sync only** — no changes are made to your AD/LDAP data
- Designed to run **scheduled synchronizations** without supervision after setup

### Single Sign-On (SSO)

- If you have your own identity system, configure SSO to keep using it
- Authentication flow:
  1. User tries to access Google Cloud
  2. Google redirects to your identity provider
  3. If authenticated → access granted; if not → prompted to sign in
- Revoking access in your system revokes Google Cloud access too
- If your system supports **SAML2** → SSO setup is just 3 links + a certificate
- Otherwise, use a third-party provider like **ADFS**, **Ping**, or **Okta**

---

## gcloud Commands

```bash
# View the IAM policy for a project
gcloud projects get-iam-policy PROJECT_ID

# Add a member to a role (allow policy)
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=user:jie@example.com --role=roles/resourcemanager.organizationAdmin

# Remove a member from a role
gcloud projects remove-iam-policy-binding PROJECT_ID \
  --member=user:jie@example.com --role=roles/resourcemanager.organizationAdmin

# Set the full IAM policy from a file (replaces existing policy)
gcloud projects set-iam-policy PROJECT_ID policy.json

# Create a deny policy
gcloud iam policies create POLICY_ID \
  --attachment-point=cloudresourcemanager.googleapis.com/projects/PROJECT_ID \
  --policy-file=deny_policy.json

# List deny policies on a resource
gcloud iam policies list \
  --attachment-point=cloudresourcemanager.googleapis.com/projects/PROJECT_ID

# List organization policies on a project
gcloud resource-manager org-policies list --project=PROJECT_ID
```
