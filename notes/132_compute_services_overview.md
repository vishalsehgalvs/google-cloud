# Google Cloud Compute Services Overview

## The Five Compute Options

| Service                 | Type                          | Best For                                  |
| ----------------------- | ----------------------------- | ----------------------------------------- |
| **Compute Engine**      | IaaS                          | Full control, lift-and-shift, custom OS   |
| **GKE**                 | Managed containers            | Containerized apps in a cloud environment |
| **App Engine**          | PaaS                          | Focus on code, not infrastructure         |
| **Cloud Run**           | Serverless containers         | Stateless containers via HTTP or Pub/Sub  |
| **Cloud Run Functions** | FaaS (Functions as a Service) | Single-purpose event-driven functions     |

---

## Compute Engine (IaaS)

- Provides **compute, storage, and network** similar to physical data centers
- Predefined and customized VM configurations (up to 416 vCPUs, 12+ TB memory)

### Storage Options

| Type                 | Details                                                                   |
| -------------------- | ------------------------------------------------------------------------- |
| **Persistent disks** | Network storage, up to 257 TB; supports snapshots for backup and mobility |
| **Local SSDs**       | High IOPS; data is ephemeral                                              |

### Key Features

- **Global load balancers** with autoscaling support
- **Managed instance groups** — automatically deploy resources to meet demand
- **Per-second billing** — keeps costs low for short-lived workloads (e.g., batch jobs)
- **Preemptible VMs** — significantly cheaper for workloads that can be safely interrupted

### When to Choose Compute Engine

- Need **complete control** over infrastructure (custom OS, mixed OS environments)
- **Lifting and shifting** on-premises workloads without rewriting applications
- Other compute options don't support your requirements

---

## Google Kubernetes Engine (GKE)

- Runs **containerized applications** in a cloud environment (not on individual VMs)
- A container = code packaged with all its dependencies
- Focus of the GKE course — covered in detail in later modules

---

## App Engine (PaaS)

- **Fully managed** — just upload code; App Engine deploys the required infrastructure
- Binds code to libraries that provide access to the infrastructure the app needs
- Frees developers to focus on **application logic instead of deployment**

### Supported Languages

Java, Node.js, Python, PHP, C#, .NET, Ruby, Go — and can also run container workloads

### Integrations

Cloud Monitoring, Cloud Logging, Cloud Profiler, Error Reporting

### Additional Features

- Version control and **traffic splitting**

### When to Choose App Engine

- Want to focus on **writing code**, not managing environments
- Don't need to build a highly customized, reliable infrastructure yourself

### Common Use Cases

- Websites
- Mobile app and gaming backends
- Exposing a **RESTful API** to the internet

---

## Cloud Run (Serverless Containers)

- Managed compute platform for **stateless containers** triggered via HTTP requests or **Pub/Sub** events
- **Serverless** — no infrastructure management; focus entirely on developing applications
- Built on **Knative** — open API and runtime built on Kubernetes; workloads are portable across environments
- Can run: fully managed on Google Cloud, on GKE, or anywhere Knative runs

### Key Features

- **Autoscales from zero** almost instantaneously
- Billing: charged only for resources used, calculated to the nearest **100 milliseconds**
- Never pay for over-provisioned resources

---

## Cloud Run Functions (FaaS)

- Lightweight, **event-based, asynchronous** compute for small, single-purpose functions
- Executes code in response to cloud events (e.g., a new file uploaded to Cloud Storage)
- **Fully serverless** — no server or runtime environment to manage

### Supported Languages

Node.js, Python, Go, Java, .NET Core, Ruby, PHP

### Billing

- To the nearest **100 milliseconds**, only while code is running
- **Perpetual free tier** — many use cases are free of charge

### Common Use Cases

- Part of a **microservices** application architecture
- Serverless **mobile or IoT backends**
- Integrating with **third-party services and APIs**
- Real-time processing of files uploaded to Cloud Storage
- **ETL pipelines** — extract, transform, load for querying and analysis
- Intelligent applications: virtual assistants, video/image analysis, sentiment analysis

## ACE Exam-Style Practice Questions

### Q1
In a Compute Services Overview scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Compute Services Overview, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.

<!-- ACE_DEEP_ENRICHMENT_START -->
## ACE Deep Enrichment

### Think Like a Google Engineer
- Primary optimization axis: Elastic performance with minimum operational toil.
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
A media startup has unpredictable traffic spikes during launches. They need faster releases, automatic scaling, and strong reliability without overpaying for idle capacity.

### Worked Example
- Choose managed compute first when operations overhead is a concern.
- For VM workloads, use managed instance groups with autoscaling and autohealing.
- For container workloads, use GKE node pools and rolling updates.
- For event-driven workloads, prefer Cloud Run or functions with concurrency controls.

### Flowchart
```mermaid
flowchart TD
    A[Workload Requirement] --> B{Need Full VM Control?}
    B -->|Yes| C[Compute Engine + MIG]
    B -->|No| D{Containerized?}
    D -->|Yes| E[GKE or Cloud Run]
    D -->|No| F[Cloud Run Functions]
    C --> G[Autoscaling + Health Checks]
    E --> G
    F --> G
    G --> H[Monitoring + Error Budgets]
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
    participant Ingress
    participant Compute
    participant Autoscaler
    participant Monitor
    User->>Ingress: Send request
    Ingress->>Compute: Route to healthy instance
    Compute-->>User: Return response
    Monitor->>Autoscaler: Report utilization metrics
    Autoscaler->>Compute: Scale out or in
```

### Extra Exam Practice (15 Questions)
#### Q1

Scenario Focus: Google Cloud Compute Services Overview

Traffic triples during business hours and falls overnight. Which compute pattern is best?

A. Use autoscaling with target utilization and baseline minimum capacity.  
B. Pin capacity to peak traffic all day for safety.  
C. Restart failed instances manually as incidents occur.  
D. Use one large VM because horizontal scaling is complex.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2

Scenario Focus: Google Cloud Compute Services Overview

A VM app must self-heal when instances fail health checks. What should you use?

A. Restart failed instances manually as incidents occur.  
B. Use a managed instance group with health checks and autohealing enabled.  
C. Use one large VM because horizontal scaling is complex.  
D. Deploy all changes at once without canary checks.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3

Scenario Focus: Google Cloud Compute Services Overview

A team wants to deploy containers without managing nodes. Which platform fits best?

A. Use one large VM because horizontal scaling is complex.  
B. Deploy all changes at once without canary checks.  
C. Use Cloud Run for containerized services when node management is not required.  
D. Ignore utilization metrics and optimize only by guesswork.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4

Scenario Focus: Google Cloud Compute Services Overview

Which update strategy minimizes user impact during releases?

A. Deploy all changes at once without canary checks.  
B. Ignore utilization metrics and optimize only by guesswork.  
C. Pin capacity to peak traffic all day for safety.  
D. Use rolling or blue-green deployment with health-based rollout checks.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5

Scenario Focus: Google Cloud Compute Services Overview

How do you avoid overprovisioning while keeping performance stable?

A. Right-size resources and monitor saturation, latency, and error rates continuously.  
B. Ignore utilization metrics and optimize only by guesswork.  
C. Pin capacity to peak traffic all day for safety.  
D. Restart failed instances manually as incidents occur.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6

Scenario Focus: Google Cloud Compute Services Overview

Two designs both satisfy the happy path for Google Cloud Compute Services Overview. Which choice is most correct?

A. Pin capacity to peak traffic all day for safety.  
B. Choose the option that preserves reliability and security while reducing operational burden.  
C. Restart failed instances manually as incidents occur.  
D. Use one large VM because horizontal scaling is complex.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7

Scenario Focus: Google Cloud Compute Services Overview

What should you validate first before choosing an architecture for Google Cloud Compute Services Overview?

A. Restart failed instances manually as incidents occur.  
B. Use one large VM because horizontal scaling is complex.  
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.  
D. Deploy all changes at once without canary checks.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8

Scenario Focus: Google Cloud Compute Services Overview

A proposal lowers cost but increases failure risk. What is the best decision?

A. Use one large VM because horizontal scaling is complex.  
B. Deploy all changes at once without canary checks.  
C. Ignore utilization metrics and optimize only by guesswork.  
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9

Scenario Focus: Google Cloud Compute Services Overview

Which option best reflects optimization for Elastic performance with minimum operational toil?

A. Select the design that best meets Elastic performance with minimum operational toil while keeping constraints balanced.  
B. Deploy all changes at once without canary checks.  
C. Ignore utilization metrics and optimize only by guesswork.  
D. Pin capacity to peak traffic all day for safety.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10

Scenario Focus: Google Cloud Compute Services Overview

How should you evaluate a design that needs frequent manual interventions?

A. Ignore utilization metrics and optimize only by guesswork.  
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.  
C. Pin capacity to peak traffic all day for safety.  
D. Restart failed instances manually as incidents occur.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q11

Scenario Focus: Google Cloud Compute Services Overview

Two options have similar latency. Which tie-breaker is best?

A. Pin capacity to peak traffic all day for safety.  
B. Restart failed instances manually as incidents occur.  
C. Pick the option with stronger operability, clearer failure isolation, and simpler incident response.  
D. Use one large VM because horizontal scaling is complex.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q12

Scenario Focus: Google Cloud Compute Services Overview

What is the best way to choose between a custom stack and a managed service?

A. Restart failed instances manually as incidents occur.  
B. Use one large VM because horizontal scaling is complex.  
C. Deploy all changes at once without canary checks.  
D. Prefer managed services when they meet requirements with lower long-term maintenance effort.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q13

Scenario Focus: Google Cloud Compute Services Overview

How do you confirm a solution is production-ready for 

A. Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.  
B. Use one large VM because horizontal scaling is complex.  
C. Deploy all changes at once without canary checks.  
D. Ignore utilization metrics and optimize only by guesswork.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q14

Scenario Focus: Google Cloud Compute Services Overview

Which pattern usually wins in ACE scenario tie-breakers?

A. Deploy all changes at once without canary checks.  
B. Managed-service-first plus least-privilege access plus clear observability usually wins.  
C. Ignore utilization metrics and optimize only by guesswork.  
D. Pin capacity to peak traffic all day for safety.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q15

Scenario Focus: Google Cloud Compute Services Overview

What is the best final check before locking the answer?

A. Ignore utilization metrics and optimize only by guesswork.  
B. Pin capacity to peak traffic all day for safety.  
C. Run a weighted check across security, reliability, cost, performance, and operability.  
D. Restart failed instances manually as incidents occur.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

### Quick Commands
```bash
gcloud compute instance-groups managed list --project=PROJECT_ID
gcloud compute instance-groups managed describe MIG_NAME --zone=ZONE --project=PROJECT_ID
gcloud run services list --region=REGION --project=PROJECT_ID
kubectl get pods -A
```

### Fast Recall
- Autoscaling is useful only with valid signals and guardrails.
- Managed offerings usually reduce operational burden.
- Deployment safety needs health checks and staged rollout.
<!-- ACE_DEEP_ENRICHMENT_END -->