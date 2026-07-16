# IAM — Members, Policies, and Identity

## Types of Members (the "Who")

| Member Type                 | Description                                                                                          |
| --------------------------- | ---------------------------------------------------------------------------------------------------- |
| **Google Account**          | Any individual (developer, admin, user) with a Google-associated email — including non-Gmail domains |
| **Service Account**         | Belongs to an application, not a person — used when code running on GCP needs an identity            |
| **Google Group**            | A named collection of Google Accounts and service accounts, managed via a single group email         |
| **Google Workspace Domain** | All Google Accounts in an org's Google Workspace (e.g. `username@example.com`)                       |
| **Cloud Identity Domain**   | Same as Workspace but without Gmail, Docs, Drive, Calendar — just user/group management              |

- IAM identity principals are users, groups of users, service accounts, and domains.

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

## ACE Exam-Style Practice Questions

### Q1
For Iam Members And Policies, a team needs only permission to read logs and datasets without modification rights. What is best?

A. roles/editor
B. roles/owner
C. Predefined read-only roles assigned to a Google Group
D. Shared admin account

Answer: C
Trap: Broad primitive roles are common distractors when least privilege is explicit.

### Q2
In a Iam Members And Policies question, two options work technically but one grants extra permissions. Which should you choose?

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

Scenario Focus: IAM — Members, Policies, and Identity

Your team must grant temporary production access for incident response. Which approach is best?

A. Grant a time-bound least-privilege role through group membership and audit the binding.  
B. Grant Owner role temporarily and remove it manually later.  
C. Share one administrator account for faster troubleshooting.  
D. Store service account keys in a shared drive because it is internal.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2

Scenario Focus: IAM — Members, Policies, and Identity

A workload is still using a JSON key file in source control. What is the best fix?

A. Share one administrator account for faster troubleshooting.  
B. Move to service account impersonation or Workload Identity and disable long-lived keys.  
C. Store service account keys in a shared drive because it is internal.  
D. Apply organization-level broad roles so future access requests are avoided.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3

Scenario Focus: IAM — Members, Policies, and Identity

Which setup best reduces blast radius across environments?

A. Store service account keys in a shared drive because it is internal.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Use separate projects per environment with narrow IAM bindings at project or resource level.  
D. Skip audit logs to reduce logging costs during non-peak hours.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4

Scenario Focus: IAM — Members, Policies, and Identity

What should you monitor first for IAM abuse detection?

A. Apply organization-level broad roles so future access requests are avoided.  
B. Skip audit logs to reduce logging costs during non-peak hours.  
C. Grant Owner role temporarily and remove it manually later.  
D. Alert on IAM policy changes, service account key creation, and high-risk privilege grants.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5

Scenario Focus: IAM — Members, Policies, and Identity

A developer needs read-only billing visibility. Which decision is best?

A. Assign a billing viewer role at the required scope instead of broad project editor access.  
B. Skip audit logs to reduce logging costs during non-peak hours.  
C. Grant Owner role temporarily and remove it manually later.  
D. Share one administrator account for faster troubleshooting.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6

Scenario Focus: IAM — Members, Policies, and Identity

Two designs both satisfy the happy path for IAM — Members, Policies, and Identity. Which choice is most correct?

A. Grant Owner role temporarily and remove it manually later.  
B. Choose the option that preserves reliability and security while reducing operational burden.  
C. Share one administrator account for faster troubleshooting.  
D. Store service account keys in a shared drive because it is internal.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7

Scenario Focus: IAM — Members, Policies, and Identity

What should you validate first before choosing an architecture for IAM — Members, Policies, and Identity?

A. Share one administrator account for faster troubleshooting.  
B. Store service account keys in a shared drive because it is internal.  
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.  
D. Apply organization-level broad roles so future access requests are avoided.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8

Scenario Focus: IAM — Members, Policies, and Identity

A proposal lowers cost but increases failure risk. What is the best decision?

A. Store service account keys in a shared drive because it is internal.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9

Scenario Focus: IAM — Members, Policies, and Identity

Which option best reflects optimization for Security posture and blast-radius minimization?

A. Select the design that best meets Security posture and blast-radius minimization while keeping constraints balanced.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Grant Owner role temporarily and remove it manually later.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10

Scenario Focus: IAM — Members, Policies, and Identity

How should you evaluate a design that needs frequent manual interventions?

A. Skip audit logs to reduce logging costs during non-peak hours.  
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.  
C. Grant Owner role temporarily and remove it manually later.  
D. Share one administrator account for faster troubleshooting.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q11

Scenario Focus: IAM — Members, Policies, and Identity

Two options have similar latency. Which tie-breaker is best?

A. Grant Owner role temporarily and remove it manually later.  
B. Share one administrator account for faster troubleshooting.  
C. Pick the option with stronger operability, clearer failure isolation, and simpler incident response.  
D. Store service account keys in a shared drive because it is internal.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q12

Scenario Focus: IAM — Members, Policies, and Identity

What is the best way to choose between a custom stack and a managed service?

A. Share one administrator account for faster troubleshooting.  
B. Store service account keys in a shared drive because it is internal.  
C. Apply organization-level broad roles so future access requests are avoided.  
D. Prefer managed services when they meet requirements with lower long-term maintenance effort.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q13

Scenario Focus: IAM — Members, Policies, and Identity

How do you confirm a solution is production-ready for 

A. Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.  
B. Store service account keys in a shared drive because it is internal.  
C. Apply organization-level broad roles so future access requests are avoided.  
D. Skip audit logs to reduce logging costs during non-peak hours.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q14

Scenario Focus: IAM — Members, Policies, and Identity

Which pattern usually wins in ACE scenario tie-breakers?

A. Apply organization-level broad roles so future access requests are avoided.  
B. Managed-service-first plus least-privilege access plus clear observability usually wins.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Grant Owner role temporarily and remove it manually later.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q15

Scenario Focus: IAM — Members, Policies, and Identity

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