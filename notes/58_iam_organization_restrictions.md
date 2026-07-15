# IAM — Organization Restrictions

## What is it?

**Organization Restrictions** prevents data exfiltration through phishing or insider attacks by restricting managed devices to only access resources in **authorized Google Cloud organizations**.

---

## How it Works

Two admins collaborate to set it up:

| Role                   | Responsibility                                                                                                |
| ---------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Google Cloud Admin** | Configures which organizations are authorized                                                                 |
| **Egress Proxy Admin** | Configures the proxy to inject organization restriction headers on all outbound requests from managed devices |

The egress proxy adds headers to every request from a managed device. Google Cloud inspects those headers and **allows or denies** the request based on whether the target organization is authorized.

---

## Use Cases

- **Restrict to your org only** — employees can only access resources in your Google Cloud organization, not any other
- **Restrict Cloud Storage reads** — allow employees to read Cloud Storage, but only from buckets in your org
- **Allow vendor org access** — permit access to both your org and a specific vendor's Google Cloud org

---

## Key Point

> Organization Restrictions are enforced at the **egress proxy level** on managed devices — employees using unmanaged devices are not subject to these restrictions.

## ACE Exam-Style Practice Questions

### Q1
In a Iam Organization Restrictions requirement, resources must be restricted to approved regions only. What should you use?

A. Budget alerts
B. Organization Policy for resource location restrictions
C. Cloud Scheduler
D. Labels only

Answer: B
Trap: IAM controls who can act; Org Policy controls what can be created under governance constraints.

### Q2
A new team needs isolated IAM, APIs, quotas, and billing in a Iam Organization Restrictions setup. What is best first step?

A. Create new project for the team
B. Add team as Editor to existing project
C. Create only a folder
D. Use one service account for all teams

Answer: A
Trap: Project is the operational boundary for billing, IAM bindings, API enablement, and quotas.
