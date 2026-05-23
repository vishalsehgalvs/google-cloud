# IAM — Module Summary

## What Was Covered

- IAM components: organizations, folders, projects, roles, members, service accounts
- Basic, predefined, and custom roles
- Policy inheritance and the principle of least privilege
- Deny policies, IAM conditions, and organization policies
- Organization Restrictions for preventing data exfiltration
- Best practices for groups, service accounts, and IAP

---

## Key Takeaways

- **Identity creation** (users, groups) is managed via **Google Workspace Admin** or **Cloud Identity** — usually by a separate admin from the Google Cloud administrator
- **Google Groups** bridge the gap: the Cloud admin assigns roles to groups; the Workspace admin manages who's in those groups
- **Service accounts** are highly flexible — they enable infrastructure-level access control, letting you scope permissions per VM or microservice without managing credentials manually
