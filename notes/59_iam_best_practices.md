# IAM — Best Practices

## 1. Understand and Use the Resource Hierarchy

- Group resources that share the same **trust boundary** into the same project
- Check the policy on each resource and understand what's being **inherited**
- Apply **principle of least privilege** at every level
- Audit policies using **Cloud Audit Logs**
- Audit memberships of groups used in policies

---

## 2. Grant Roles to Groups, Not Individuals

- Easier to manage — update group membership instead of changing IAM policies
- Audit group membership regularly
- Control ownership of Google Groups used in IAM policies

### Using Multiple Groups for Fine-Grained Control

You can create groups that exist purely for role assignment, not just job roles.

**Example:**

| Group | Role |
| ----- | ---- |
| `network-admins` | Network Admin |
| `network-admins-storage-rw` | Cloud Storage read/write |
| `network-admins-storage-ro` | Cloud Storage read-only |

Adding/removing users from these groups controls their total access across all resources.

---

## 3. Service Account Best Practices

- Be **very careful** granting the **Service Account User** role — it gives access to everything the service account can access
- Give service accounts a **clear display name** that identifies their purpose; use a consistent naming convention
- Establish **key rotation policies** for user-managed keys
- Audit keys using `serviceAccount.keys.list`

---

## 4. Use Identity-Aware Proxy (IAP)

**IAP** provides a central authorization layer for HTTPS applications — an application-level access control model that doesn't rely on network-level firewalls.

- Resources protected by IAP can only be accessed by users/groups with the correct IAM role
- No VPN required
- IAP performs **authentication + authorization** on every request before allowing access

---

## gcloud Commands

```bash
# View Cloud Audit Logs for IAM activity
gcloud logging read 'logName="projects/PROJECT_ID/logs/cloudaudit.googleapis.com%2Factivity"' \
  --limit=10

# List keys for a service account (for auditing)
gcloud iam service-accounts keys list \
  --iam-account=my-sa@PROJECT_ID.iam.gserviceaccount.com

# Grant a role to a group (recommended over individuals)
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=group:my-group@example.com --role=roles/storage.objectViewer

# Enable IAP for a backend service
gcloud compute backend-services update my-backend \
  --global --iap=enabled

# Grant a user access through IAP
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=user:alice@example.com --role=roles/iap.httpsResourceAccessor
```
