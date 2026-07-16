# IAM — Roles

## Why Roles Matter

When an identity calls a Google Cloud API, IAM checks that the identity has the appropriate permissions for that resource. You grant permissions by assigning roles to a user, group, or service account.

---

## What Roles Define

Roles define the **"can do what on which resource"** part of IAM.

There are three types: **Basic** (also called **Primitive**), **Predefined**, and **Custom**.

---

## 1. Basic Roles (Primitive Roles)

The original roles from before Cloud IAM was introduced — sometimes still called **Primitive roles**. They are **broad and coarse-grained** — applied to an entire project and affect all resources in it.

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

## ACE Exam-Style Practice Questions

### Q1
For Iam Roles, a team needs only permission to read logs and datasets without modification rights. What is best?

A. roles/editor
B. roles/owner
C. Predefined read-only roles assigned to a Google Group
D. Shared admin account

Answer: C
Trap: Broad primitive roles are common distractors when least privilege is explicit.

### Q2
In a Iam Roles question, two options work technically but one grants extra permissions. Which should you choose?

A. Broad role for future convenience
B. Narrow role that satisfies exact requirement
C. Owner to avoid access errors
D. Service account key in source code

Answer: B
Trap: Exam scoring favors least privilege and operational safety.

<!-- ACE_DEEP_ENRICHMENT_START -->
## ACE Deep Enrichment

### Think Like a Google Engineer
- Primary optimization axis: Security posture and blast-radius minimization.
- Start with constraints first: SLO, security, compliance, latency, budget, and team operations capacity.
- Prefer managed services if they satisfy requirements with lower long-term operational toil.
- Minimize blast radius using environment isolation, least privilege, and failure-domain awareness.
- Design for day-2 operations: observability, rollback strategy, and quota or budget guardrails.

### Most Correct Option Filter (60 Seconds)
1. Eliminate options with broad access, single points of failure, or missing monitoring.
2. Confirm the option meets non-negotiables first: security and reliability requirements.
3. Compare remaining options on operational simplicity and long-term maintainability.
4. Use cost as an optimizer only after requirements and risk controls are satisfied.

### Weighted Decision Matrix
| Dimension | Weight | Strong Signal |
| --- | --- | --- |
| Security | 3 | Least privilege, secure defaults, no exposed blast radius |
| Reliability | 3 | Multi-zone or HA design, health checks, tested recovery path |
| Operability | 2 | Clear monitoring, alerting, rollout and rollback simplicity |
| Cost Efficiency | 2 | Right-sized resources, no waste, no reliability regression |
| Performance | 1 | Meets latency and throughput targets with headroom |

### Real-Life Scenario
A fintech team is onboarding 40 engineers and 12 workloads in one quarter. They need strict access boundaries, auditability, and zero long-lived credentials while still shipping features fast.

### Worked Example
- Create separate projects for dev, staging, and prod so IAM and quotas are isolated.
- Map users to Google Groups and grant predefined roles at the narrowest scope.
- Use service accounts for workloads and rotate to short-lived credentials through Workload Identity.
- Enable audit logs and alert on policy changes and service account key creation.

### Flowchart
```mermaid
flowchart TD
    A[New Access Request] --> B{Human or Workload?}
    B -->|Human| C[Group Based IAM]
    B -->|Workload| D[Service Account + Workload Identity]
    C --> E{Least Privilege Verified?}
    D --> E
    E -->|No| F[Reduce Permissions]
    E -->|Yes| G[Approve and Log]
    G --> H[Continuous Audit Alerts]
```

### Optimization Decision Flow
```mermaid
flowchart TD
    A[Read Requirement] --> B[Identify Hard Constraints]
    B --> C{Security and Reliability Met?}
    C -->|No| D[Reject Option]
    C -->|Yes| E[Score Operability and Cost]
    E --> F{Managed Service Meets Needs?}
    F -->|Yes| G[Prefer Managed Path]
    F -->|No| H[Use Custom Design with Guardrails]
    G --> I[Validate Observability and Rollback]
    H --> I
    I --> J[Pick Highest Weighted Score]
```

### Interaction Sequence
```mermaid
sequenceDiagram
    participant User
    participant IAM
    participant SA as ServiceAccount
    participant API
    User->>IAM: Request role binding
    IAM-->>User: Grant least privilege role
    SA->>IAM: Exchange identity token
    IAM-->>SA: Short lived access token
    SA->>API: Call API with token
    API-->>SA: Authorized response
```

### Extra Exam Practice (15 Questions)
#### Q1

Scenario Focus: IAM — Roles

Your team must grant temporary production access for incident response. Which approach is best?

A. Grant a time-bound least-privilege role through group membership and audit the binding.  
B. Grant Owner role temporarily and remove it manually later.  
C. Share one administrator account for faster troubleshooting.  
D. Store service account keys in a shared drive because it is internal.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2

Scenario Focus: IAM — Roles

A workload is still using a JSON key file in source control. What is the best fix?

A. Share one administrator account for faster troubleshooting.  
B. Move to service account impersonation or Workload Identity and disable long-lived keys.  
C. Store service account keys in a shared drive because it is internal.  
D. Apply organization-level broad roles so future access requests are avoided.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3

Scenario Focus: IAM — Roles

Which setup best reduces blast radius across environments?

A. Store service account keys in a shared drive because it is internal.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Use separate projects per environment with narrow IAM bindings at project or resource level.  
D. Skip audit logs to reduce logging costs during non-peak hours.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4

Scenario Focus: IAM — Roles

What should you monitor first for IAM abuse detection?

A. Apply organization-level broad roles so future access requests are avoided.  
B. Skip audit logs to reduce logging costs during non-peak hours.  
C. Grant Owner role temporarily and remove it manually later.  
D. Alert on IAM policy changes, service account key creation, and high-risk privilege grants.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5

Scenario Focus: IAM — Roles

A developer needs read-only billing visibility. Which decision is best?

A. Assign a billing viewer role at the required scope instead of broad project editor access.  
B. Skip audit logs to reduce logging costs during non-peak hours.  
C. Grant Owner role temporarily and remove it manually later.  
D. Share one administrator account for faster troubleshooting.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6

Scenario Focus: IAM — Roles

Two designs both satisfy the happy path for IAM — Roles. Which choice is most correct?

A. Grant Owner role temporarily and remove it manually later.  
B. Choose the option that preserves reliability and security while reducing operational burden.  
C. Share one administrator account for faster troubleshooting.  
D. Store service account keys in a shared drive because it is internal.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7

Scenario Focus: IAM — Roles

What should you validate first before choosing an architecture for IAM — Roles?

A. Share one administrator account for faster troubleshooting.  
B. Store service account keys in a shared drive because it is internal.  
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.  
D. Apply organization-level broad roles so future access requests are avoided.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8

Scenario Focus: IAM — Roles

A proposal lowers cost but increases failure risk. What is the best decision?

A. Store service account keys in a shared drive because it is internal.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9

Scenario Focus: IAM — Roles

Which option best reflects optimization for Security posture and blast-radius minimization?

A. Select the design that best meets Security posture and blast-radius minimization while keeping constraints balanced.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Grant Owner role temporarily and remove it manually later.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10

Scenario Focus: IAM — Roles

How should you evaluate a design that needs frequent manual interventions?

A. Skip audit logs to reduce logging costs during non-peak hours.  
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.  
C. Grant Owner role temporarily and remove it manually later.  
D. Share one administrator account for faster troubleshooting.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q11

Scenario Focus: IAM — Roles

Two options have similar latency. Which tie-breaker is best?

A. Grant Owner role temporarily and remove it manually later.  
B. Share one administrator account for faster troubleshooting.  
C. Pick the option with stronger operability, clearer failure isolation, and simpler incident response.  
D. Store service account keys in a shared drive because it is internal.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q12

Scenario Focus: IAM — Roles

What is the best way to choose between a custom stack and a managed service?

A. Share one administrator account for faster troubleshooting.  
B. Store service account keys in a shared drive because it is internal.  
C. Apply organization-level broad roles so future access requests are avoided.  
D. Prefer managed services when they meet requirements with lower long-term maintenance effort.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q13

Scenario Focus: IAM — Roles

How do you confirm a solution is production-ready for 

A. Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.  
B. Store service account keys in a shared drive because it is internal.  
C. Apply organization-level broad roles so future access requests are avoided.  
D. Skip audit logs to reduce logging costs during non-peak hours.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q14

Scenario Focus: IAM — Roles

Which pattern usually wins in ACE scenario tie-breakers?

A. Apply organization-level broad roles so future access requests are avoided.  
B. Managed-service-first plus least-privilege access plus clear observability usually wins.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Grant Owner role temporarily and remove it manually later.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q15

Scenario Focus: IAM — Roles

What is the best final check before locking the answer?

A. Skip audit logs to reduce logging costs during non-peak hours.  
B. Grant Owner role temporarily and remove it manually later.  
C. Run a weighted check across security, reliability, cost, performance, and operability.  
D. Share one administrator account for faster troubleshooting.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

### Quick Commands
```bash
gcloud projects get-iam-policy PROJECT_ID
gcloud projects add-iam-policy-binding PROJECT_ID --member=group:team@example.com --role=roles/viewer
gcloud iam service-accounts list --project=PROJECT_ID
gcloud logging read "protoPayload.methodName=\"SetIamPolicy\"" --freshness=7d --project=PROJECT_ID --limit=20
```

### Fast Recall
- Least privilege beats convenience in all exam scenarios.
- Prefer groups for humans and service accounts for workloads.
- Avoid long-lived keys whenever possible.
<!-- ACE_DEEP_ENRICHMENT_END -->