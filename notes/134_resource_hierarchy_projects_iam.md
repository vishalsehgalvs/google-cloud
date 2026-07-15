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

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

Your team must grant temporary production access for incident response. Which approach is best?

A. Grant a time-bound least-privilege role through group membership and audit the binding.  
B. Grant Owner role temporarily and remove it manually later.  
C. Share one administrator account for faster troubleshooting.  
D. Store service account keys in a shared drive because it is internal.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

A workload is still using a JSON key file in source control. What is the best fix?

A. Share one administrator account for faster troubleshooting.  
B. Move to service account impersonation or Workload Identity and disable long-lived keys.  
C. Store service account keys in a shared drive because it is internal.  
D. Apply organization-level broad roles so future access requests are avoided.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

Which setup best reduces blast radius across environments?

A. Store service account keys in a shared drive because it is internal.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Use separate projects per environment with narrow IAM bindings at project or resource level.  
D. Skip audit logs to reduce logging costs during non-peak hours.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

What should you monitor first for IAM abuse detection?

A. Apply organization-level broad roles so future access requests are avoided.  
B. Skip audit logs to reduce logging costs during non-peak hours.  
C. Grant Owner role temporarily and remove it manually later.  
D. Alert on IAM policy changes, service account key creation, and high-risk privilege grants.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

A developer needs read-only billing visibility. Which decision is best?

A. Assign a billing viewer role at the required scope instead of broad project editor access.  
B. Skip audit logs to reduce logging costs during non-peak hours.  
C. Grant Owner role temporarily and remove it manually later.  
D. Share one administrator account for faster troubleshooting.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

Two designs both satisfy the happy path for Google Cloud Resource Hierarchy, Projects, and IAM. Which choice is most correct?

A. Grant Owner role temporarily and remove it manually later.  
B. Choose the option that preserves reliability and security while reducing operational burden.  
C. Share one administrator account for faster troubleshooting.  
D. Store service account keys in a shared drive because it is internal.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

What should you validate first before choosing an architecture for Google Cloud Resource Hierarchy, Projects, and IAM?

A. Share one administrator account for faster troubleshooting.  
B. Store service account keys in a shared drive because it is internal.  
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.  
D. Apply organization-level broad roles so future access requests are avoided.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

A proposal lowers cost but increases failure risk. What is the best decision?

A. Store service account keys in a shared drive because it is internal.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

Which option best reflects optimization for Security posture and blast-radius minimization?

A. Select the design that best meets Security posture and blast-radius minimization while keeping constraints balanced.  
B. Apply organization-level broad roles so future access requests are avoided.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Grant Owner role temporarily and remove it manually later.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

How should you evaluate a design that needs frequent manual interventions?

A. Skip audit logs to reduce logging costs during non-peak hours.  
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.  
C. Grant Owner role temporarily and remove it manually later.  
D. Share one administrator account for faster troubleshooting.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q11

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

Two options have similar latency. Which tie-breaker is best?

A. Grant Owner role temporarily and remove it manually later.  
B. Share one administrator account for faster troubleshooting.  
C. Pick the option with stronger operability, clearer failure isolation, and simpler incident response.  
D. Store service account keys in a shared drive because it is internal.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q12

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

What is the best way to choose between a custom stack and a managed service?

A. Share one administrator account for faster troubleshooting.  
B. Store service account keys in a shared drive because it is internal.  
C. Apply organization-level broad roles so future access requests are avoided.  
D. Prefer managed services when they meet requirements with lower long-term maintenance effort.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q13

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

How do you confirm a solution is production-ready for 

A. Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.  
B. Store service account keys in a shared drive because it is internal.  
C. Apply organization-level broad roles so future access requests are avoided.  
D. Skip audit logs to reduce logging costs during non-peak hours.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q14

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

Which pattern usually wins in ACE scenario tie-breakers?

A. Apply organization-level broad roles so future access requests are avoided.  
B. Managed-service-first plus least-privilege access plus clear observability usually wins.  
C. Skip audit logs to reduce logging costs during non-peak hours.  
D. Grant Owner role temporarily and remove it manually later.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q15

Scenario Focus: Google Cloud Resource Hierarchy, Projects, and IAM

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