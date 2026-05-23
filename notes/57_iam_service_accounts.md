# IAM — Service Accounts

## What is a Service Account?

A service account is an account that belongs to an **application**, not an individual user. It provides an identity for service-to-service interactions without requiring user credentials.

**Example:** An app that reads from Cloud Storage authenticates using a service account — no secret keys embedded in code.

Service accounts are identified by an **email address** (e.g. `PROJECT_NUMBER-compute@developer.gserviceaccount.com`).

---

## Three Types of Service Accounts

| Type                                  | Description                                                                                                         |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **User-created (Custom)**             | Created manually; most flexible; requires more management                                                           |
| **Built-in (Compute Engine default)** | Auto-created per project; auto-granted Editor role; email: `PROJECT_NUMBER-compute@developer.gserviceaccount.com`   |
| **Google APIs service account**       | Runs internal Google processes; email: `PROJECT_NUMBER@cloudservices.gserviceaccount.com`; auto-granted Editor role |

> When you start a new instance with `gcloud`, the default service account is enabled automatically. You can override this with a custom service account or disable it entirely.

---

## Custom Service Accounts

- Create as many as needed — one per microservice is a common pattern
- Assign specific IAM roles or access scopes
- Assign to any VM at creation time
- More flexible than the default account, but you manage them yourself

---

## Authorization: Scopes vs. IAM Roles

### Scopes (legacy)

- The old way of granting permissions to service accounts
- Still visible on VMs using the default service account
- Can be changed only when the VM is **stopped**
- **Access token example:**
  - App A → read-only scope → can only read from Cloud Storage
  - App B → read-write scope → can read and modify Cloud Storage

> For user-created service accounts, use **IAM roles** instead of scopes.

---

## Service Account as a Resource

A service account can itself be a **resource** that users are granted access to.

**Example flow:**

1. Create a service account with the `InstanceAdmin` role (create/modify/delete VMs)
2. Grant specific users the **Service Account User** role on that service account
3. Those users can now act as the service account — gaining all its permissions

> Be cautious when granting the **Service Account User** role — it gives access to everything the service account can do.

---

## Scoping Permissions with Service Accounts

You can slice a project into isolated microservices:

- VMs running `component_1` → Service Account 1 → Editor access on `project_b`
- VMs running `component_2` → Service Account 2 → `objectViewer` access on `bucket_1`

This way you don't need to recreate VMs to change their permissions — just update the service account's IAM bindings.

---

## Service Account Key Types

| Type                        | Who manages | Private key access                         | Key rotation                  |
| --------------------------- | ----------- | ------------------------------------------ | ----------------------------- |
| **Google-managed**          | Google      | Never directly accessible                  | Automatic (every 2 weeks max) |
| **User-managed (external)** | You         | You hold it; Google only stores public key | Manual or programmatic        |

- Up to **10 user-managed keys** per service account (to support rotation)
- If you lose a user-managed private key, **Google cannot recover it**
- Managed via IAM API, `gcloud`, or the Console

> User-managed keys should be a **last resort**. Prefer short-lived credentials (tokens) or service account impersonation.

---

## gcloud Commands

```bash
# List all service accounts in a project
gcloud iam service-accounts list

# Create a service account
gcloud iam service-accounts create my-sa \
  --display-name="My Service Account"

# Grant a role to a service account
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=serviceAccount:my-sa@PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/storage.objectViewer

# Grant a user the Service Account User role
gcloud iam service-accounts add-iam-policy-binding my-sa@PROJECT_ID.iam.gserviceaccount.com \
  --member=user:alice@example.com --role=roles/iam.serviceAccountUser

# List keys for a service account
gcloud iam service-accounts keys list \
  --iam-account=my-sa@PROJECT_ID.iam.gserviceaccount.com

# Create a user-managed key (download to file)
gcloud iam service-accounts keys create key.json \
  --iam-account=my-sa@PROJECT_ID.iam.gserviceaccount.com

# Delete a service account
gcloud iam service-accounts delete my-sa@PROJECT_ID.iam.gserviceaccount.com
```
