# Google Cloud Marketplace

## What Is Cloud Marketplace?

- Lets you **quickly deploy functional software packages** that run on Google Cloud
- Offers **production-grade solutions** from third-party vendors
- Vendor deployment configurations are based on **Terraform** under the hood

---

## Key Features

- **Unified billing** — Marketplace solutions are billed together with all your other Google Cloud services in the same project
- **Bring Your Own License (BYOL)** — if you already have a license for a third-party service, you may be able to use a BYOL solution instead of paying through Marketplace
- **Scalable** — deploy a package now and scale it later when your application needs more capacity
- **Google-maintained images** — Google updates the base images to fix critical issues and vulnerabilities; however, updates do not apply to software you've already deployed
- **Partner support** — you can get direct access to support from the vendor/partner

---

## How It Works

1. Browse Marketplace for the solution you need (e.g., databases, security tools, developer tools)
2. Click **Launch** — Marketplace pre-fills the deployment configuration
3. Customize as needed and deploy
4. The solution runs on your GCP infrastructure and is billed to your project

---

## When to Use Marketplace

| Scenario                                                        | Why Marketplace                        |
| --------------------------------------------------------------- | -------------------------------------- |
| Need a known third-party stack (e.g., Jenkins, WordPress, LAMP) | Pre-configured, ready to deploy        |
| Want managed billing in one place                               | All charges roll up to your GCP bill   |
| Already have a software license                                 | Use BYOL to avoid double-paying        |
| Need vendor support                                             | Direct partner support access included |

---

## Demo Walkthrough — Deploying a LAMP Stack

### What Is a LAMP Stack?

| Letter | Component          |
| ------ | ------------------ |
| **L**  | Linux              |
| **A**  | Apache HTTP Server |
| **M**  | MySQL              |
| **P**  | PHP                |

---

### Steps

1. **Navigate to Marketplace** — go to the navigation menu → **Marketplace**
2. **Search** for "LAMP stack" — multiple providers will appear; each provider offers their own configuration of the same stack
3. **Select a solution** — click a result to see the configuration page, which shows:
   - Package contents (OS, Apache, PHP, MySQL)
   - Usage fee (if any — billed together with GCP services)
   - Instance billing details (e.g., N1 standard-1 with persistent disk and sustained use discount)
4. **Click Launch on Compute Engine** — opens a VM configuration page where you can:
   - Change the machine type (larger, smaller, custom)
   - See that the **HTTP firewall rule (TCP 80)** is pre-configured for Apache
   - Adjust networking options
   - Enable optional add-ons (e.g., phpMyAdmin)
   - Enable **Cloud Logging and Monitoring** (Stackdriver)
5. **Click Deploy** — GCP redirects to **Deployment Manager**, which shows:
   - The full deployment configuration and all imported files
   - A generated **VM instance** and **admin password**
   - The HTTP firewall rule (TCP 80) being applied

> Marketplace solutions are pre-built **Deployment Manager configurations** — you don't need to write them yourself.

---

### After Deployment

Once the instance is running, the Deployment Manager page shows:

- **Site address** — visit the deployed LAMP site directly
- **Admin username and password**
- **SSH link** to the instance
- **Next steps** suggested by the vendor, such as:
  - Enable HTTPS traffic
  - Change the admin password
  - Assign a static external IP (default is ephemeral)
  - Learn more about installed software

The instance also appears in **Compute Engine → VM Instances** like any other VM.

## ACE Exam-Style Practice Questions

### Q1
For Cloud Marketplace, the company wants repeatable multi-environment provisioning with minimal repetitive code. What should you use?

A. IaC templates and modules
B. Manual console steps each time
C. Ad-hoc scripts without version control
D. Spreadsheet-only process

Answer: A
Trap: Declarative IaC improves consistency, auditability, and reuse.

### Q2
In a Cloud Marketplace scenario, you must deploy supported third-party software quickly with managed packaging. Which option is best?

A. Google Cloud Marketplace solution deployment
B. Build everything from source on one VM manually
C. Use Cloud Trace to install software
D. Export billing CSV first

Answer: A
Trap: Marketplace is designed for rapid deployment of curated solutions.

<!-- ACE_DEEP_ENRICHMENT_START -->
## ACE Deep Enrichment

### Think Like a Google Engineer
- Primary optimization axis: Managed-service-first design with reliability and security by default.
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
A growing startup is moving from manual infrastructure to Google Cloud. They need fast delivery, better reliability, and clear operational controls while keeping architecture simple.

### Worked Example
- Translate business goals into technical constraints before selecting services.
- Favor managed services to reduce operational burden where possible.
- Apply least-privilege IAM and private-by-default networking decisions.
- Add monitoring, logging, and budget controls from the start.

### Flowchart
```mermaid
flowchart TD
    A[Business Goal] --> B[Technical Constraints]
    B --> C{Need Custom Infra Control?}
    C -->|Yes| D[Choose IaaS Pattern]
    C -->|No| E[Choose Managed Service]
    D --> F[Apply IAM and Network Guardrails]
    E --> F
    F --> G[Add Monitoring and Cost Controls]
    G --> H[Run Production Readiness Check]
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
    participant Team
    participant Platform
    participant Security
    participant Operations
    Team->>Platform: Deploy workload
    Platform->>Security: Enforce IAM and policy
    Platform->>Operations: Emit logs and metrics
    Operations-->>Team: Alert and feedback loop
```

### Extra Exam Practice (15 Questions)
#### Q1

Scenario Focus: Google Cloud Marketplace

Which design pattern is usually best for fast, safe cloud adoption?

A. Use managed services with least-privilege IAM and clear observability controls.  
B. Start with manual scripts and unrestricted access, then harden later.  
C. Use one project for everything to reduce setup effort.  
D. Ignore telemetry until after first production incident.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2

Scenario Focus: Google Cloud Marketplace

A team wants speed and low ops overhead. What should they prioritize?

A. Use one project for everything to reduce setup effort.  
B. Prefer services that reduce operational toil while meeting reliability goals.  
C. Ignore telemetry until after first production incident.  
D. Pick only the cheapest service regardless of reliability needs.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3

Scenario Focus: Google Cloud Marketplace

What is a common architecture trap in early cloud projects?

A. Ignore telemetry until after first production incident.  
B. Pick only the cheapest service regardless of reliability needs.  
C. Over-broad access and missing monitoring are high-risk trap patterns.  
D. Keep architecture opaque to avoid governance overhead.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4

Scenario Focus: Google Cloud Marketplace

Which control set should be baseline for production?

A. Pick only the cheapest service regardless of reliability needs.  
B. Keep architecture opaque to avoid governance overhead.  
C. Start with manual scripts and unrestricted access, then harden later.  
D. Baseline should include IAM guardrails, logging, monitoring, and cost alerts.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5

Scenario Focus: Google Cloud Marketplace

How should you evaluate conflicting requirements on the exam?

A. Choose the option that balances security, reliability, cost, and operability.  
B. Keep architecture opaque to avoid governance overhead.  
C. Start with manual scripts and unrestricted access, then harden later.  
D. Use one project for everything to reduce setup effort.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6

Scenario Focus: Google Cloud Marketplace

Two designs both satisfy the happy path for Google Cloud Marketplace. Which choice is most correct?

A. Start with manual scripts and unrestricted access, then harden later.  
B. Choose the option that preserves reliability and security while reducing operational burden.  
C. Use one project for everything to reduce setup effort.  
D. Ignore telemetry until after first production incident.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7

Scenario Focus: Google Cloud Marketplace

What should you validate first before choosing an architecture for Google Cloud Marketplace?

A. Use one project for everything to reduce setup effort.  
B. Ignore telemetry until after first production incident.  
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.  
D. Pick only the cheapest service regardless of reliability needs.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8

Scenario Focus: Google Cloud Marketplace

A proposal lowers cost but increases failure risk. What is the best decision?

A. Ignore telemetry until after first production incident.  
B. Pick only the cheapest service regardless of reliability needs.  
C. Keep architecture opaque to avoid governance overhead.  
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9

Scenario Focus: Google Cloud Marketplace

Which option best reflects optimization for Managed-service-first design with reliability and security by default?

A. Select the design that best meets Managed-service-first design with reliability and security by default while keeping constraints balanced.  
B. Pick only the cheapest service regardless of reliability needs.  
C. Keep architecture opaque to avoid governance overhead.  
D. Start with manual scripts and unrestricted access, then harden later.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10

Scenario Focus: Google Cloud Marketplace

How should you evaluate a design that needs frequent manual interventions?

A. Keep architecture opaque to avoid governance overhead.  
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.  
C. Start with manual scripts and unrestricted access, then harden later.  
D. Use one project for everything to reduce setup effort.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q11

Scenario Focus: Google Cloud Marketplace

Two options have similar latency. Which tie-breaker is best?

A. Start with manual scripts and unrestricted access, then harden later.  
B. Use one project for everything to reduce setup effort.  
C. Pick the option with stronger operability, clearer failure isolation, and simpler incident response.  
D. Ignore telemetry until after first production incident.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q12

Scenario Focus: Google Cloud Marketplace

What is the best way to choose between a custom stack and a managed service?

A. Use one project for everything to reduce setup effort.  
B. Ignore telemetry until after first production incident.  
C. Pick only the cheapest service regardless of reliability needs.  
D. Prefer managed services when they meet requirements with lower long-term maintenance effort.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q13

Scenario Focus: Google Cloud Marketplace

How do you confirm a solution is production-ready for 

A. Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.  
B. Ignore telemetry until after first production incident.  
C. Pick only the cheapest service regardless of reliability needs.  
D. Keep architecture opaque to avoid governance overhead.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q14

Scenario Focus: Google Cloud Marketplace

Which pattern usually wins in ACE scenario tie-breakers?

A. Pick only the cheapest service regardless of reliability needs.  
B. Managed-service-first plus least-privilege access plus clear observability usually wins.  
C. Keep architecture opaque to avoid governance overhead.  
D. Start with manual scripts and unrestricted access, then harden later.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q15

Scenario Focus: Google Cloud Marketplace

What is the best final check before locking the answer?

A. Keep architecture opaque to avoid governance overhead.  
B. Start with manual scripts and unrestricted access, then harden later.  
C. Run a weighted check across security, reliability, cost, performance, and operability.  
D. Use one project for everything to reduce setup effort.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

### Quick Commands
```bash
gcloud config list
gcloud projects describe PROJECT_ID
gcloud services list --enabled --project=PROJECT_ID
gcloud logging read "severity>=WARNING" --project=PROJECT_ID --freshness=2d --limit=20
```

### Fast Recall
- Good cloud design is constraint-driven, not tool-driven.
- Managed services usually improve delivery speed and reliability.
- Security and observability should be built in from day one.
<!-- ACE_DEEP_ENRICHMENT_END -->