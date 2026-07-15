# Filestore — Managed Network File Storage

## What is Filestore?

**Filestore** is a fully managed **NFS (Network File System)** storage service for applications that need a shared file system interface.

- Works natively with **Compute Engine** and **GKE** instances
- Supports any **NFSv3 compatible** client
- Performance and capacity can be tuned **independently** → predictable, fast performance
- No plugins or client-side software required

---

## Key Capabilities

- Scale-out performance
- Hundreds of terabytes of capacity
- **File locking** support
- Native compatibility with existing enterprise applications

---

## Use Cases

| Use Case                               | Why Filestore                                                                            |
| -------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Enterprise app migration**           | Many on-premises apps need a shared file system — Filestore supports lift-and-shift      |
| **Media rendering**                    | VFX artists collaborate on the same file share across fleets of Compute Engine VMs       |
| **EDA (Electronic Design Automation)** | Batch workloads across thousands of cores with large memory needs; universal file access |
| **Data analytics**                     | Low-latency file ops for complex financial models or environmental data analysis         |
| **Genomics / scientific research**     | Handles billions of data points per person; fast, scalable, secure                       |
| **Web content / WordPress hosting**    | Managed shared storage for web developers and hosting providers                          |

---

## When to Use Filestore vs Cloud Storage

| Need                                   | Use               |
| -------------------------------------- | ----------------- |
| Shared file system (NFS mount)         | **Filestore**     |
| Object storage (blobs, backups, media) | **Cloud Storage** |

---

## gcloud Commands

```bash
# List Filestore instances
gcloud filestore instances list

# Create a Filestore instance
gcloud filestore instances create my-filestore \
  --zone=us-central1-c \
  --tier=STANDARD \
  --file-share=name=my-share,capacity=1TB \
  --network=name=default

# Describe a Filestore instance (get NFS mount point)
gcloud filestore instances describe my-filestore --zone=us-central1-c

# Delete a Filestore instance
gcloud filestore instances delete my-filestore --zone=us-central1-c
```

## ACE Exam-Style Practice Questions

### Q1
In a Filestore scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Filestore bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.

<!-- ACE_DEEP_ENRICHMENT_START -->
## ACE Deep Enrichment

### Think Like a Google Engineer
- Primary optimization axis: Latency-resilience balance with private-by-default connectivity.
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
An ecommerce platform serves customers across regions. The team must keep latency low, protect internal services, and survive zonal failures while controlling egress costs.

### Worked Example
- Place internet-facing services behind the correct external load balancer type.
- Keep internal services private with internal load balancers and private IP ranges.
- Use firewall rules by tags or service accounts, not wide open CIDR ranges.
- Add Cloud CDN or regional placement based on traffic profile and content type.

### Flowchart
```mermaid
flowchart TD
    A[Traffic Requirement] --> B{Public or Private Entry?}
    B -->|Public| C[External Load Balancer]
    B -->|Private| D[Internal Load Balancer]
    C --> E{Global Users?}
    E -->|Yes| F[Global Backend + CDN]
    E -->|No| G[Regional Backend]
    D --> H[VPC Segmentation + Firewall]
    F --> I[Observability and SLO Alerts]
    G --> I
    H --> I
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
    participant Client
    participant DNS
    participant LB
    participant Service
    participant Logs
    Client->>DNS: Resolve application endpoint
    DNS-->>Client: Return load balancer IP
    Client->>LB: HTTPS request
    LB->>Service: Forward to healthy backend
    Service-->>LB: Response
    LB-->>Client: Response
    LB->>Logs: Emit latency and error metrics
```

### Extra Exam Practice (15 Questions)
#### Q1

Scenario Focus: Filestore — Managed Network File Storage

A service must be reachable only from internal VMs. Which design is best?

A. Use an internal load balancer with private backend endpoints and private DNS.  
B. Expose the service publicly and rely on app-level passwords.  
C. Use one VM with a static external IP to simplify architecture.  
D. Allow 0.0.0.0/0 ingress to speed up troubleshooting.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2

Scenario Focus: Filestore — Managed Network File Storage

You need to reduce global web latency for static assets. What should you choose?

A. Use one VM with a static external IP to simplify architecture.  
B. Use an external application load balancer with Cloud CDN and cacheable content rules.  
C. Allow 0.0.0.0/0 ingress to speed up troubleshooting.  
D. Disable health checks to avoid accidental failover.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3

Scenario Focus: Filestore — Managed Network File Storage

Which firewall strategy best matches zero-trust network design?

A. Allow 0.0.0.0/0 ingress to speed up troubleshooting.  
B. Disable health checks to avoid accidental failover.  
C. Use least-privilege firewall policies scoped by service accounts or tags.  
D. Route all traffic through manual bastion hops in production.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4

Scenario Focus: Filestore — Managed Network File Storage

A backend fails health checks in one zone. What architecture is best practice?

A. Disable health checks to avoid accidental failover.  
B. Route all traffic through manual bastion hops in production.  
C. Expose the service publicly and rely on app-level passwords.  
D. Run multi-zone backends with health checks and automatic failover.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5

Scenario Focus: Filestore — Managed Network File Storage

You need private hybrid connectivity between on-prem and GCP. Which path is preferred?

A. Use HA VPN or Interconnect based on throughput and SLA requirements.  
B. Route all traffic through manual bastion hops in production.  
C. Expose the service publicly and rely on app-level passwords.  
D. Use one VM with a static external IP to simplify architecture.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6

Scenario Focus: Filestore — Managed Network File Storage

Two designs both satisfy the happy path for Filestore — Managed Network File Storage. Which choice is most correct?

A. Expose the service publicly and rely on app-level passwords.  
B. Choose the option that preserves reliability and security while reducing operational burden.  
C. Use one VM with a static external IP to simplify architecture.  
D. Allow 0.0.0.0/0 ingress to speed up troubleshooting.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7

Scenario Focus: Filestore — Managed Network File Storage

What should you validate first before choosing an architecture for Filestore — Managed Network File Storage?

A. Use one VM with a static external IP to simplify architecture.  
B. Allow 0.0.0.0/0 ingress to speed up troubleshooting.  
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.  
D. Disable health checks to avoid accidental failover.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8

Scenario Focus: Filestore — Managed Network File Storage

A proposal lowers cost but increases failure risk. What is the best decision?

A. Allow 0.0.0.0/0 ingress to speed up troubleshooting.  
B. Disable health checks to avoid accidental failover.  
C. Route all traffic through manual bastion hops in production.  
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9

Scenario Focus: Filestore — Managed Network File Storage

Which option best reflects optimization for Latency-resilience balance with private-by-default connectivity?

A. Select the design that best meets Latency-resilience balance with private-by-default connectivity while keeping constraints balanced.  
B. Disable health checks to avoid accidental failover.  
C. Route all traffic through manual bastion hops in production.  
D. Expose the service publicly and rely on app-level passwords.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10

Scenario Focus: Filestore — Managed Network File Storage

How should you evaluate a design that needs frequent manual interventions?

A. Route all traffic through manual bastion hops in production.  
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.  
C. Expose the service publicly and rely on app-level passwords.  
D. Use one VM with a static external IP to simplify architecture.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q11

Scenario Focus: Filestore — Managed Network File Storage

Two options have similar latency. Which tie-breaker is best?

A. Expose the service publicly and rely on app-level passwords.  
B. Use one VM with a static external IP to simplify architecture.  
C. Pick the option with stronger operability, clearer failure isolation, and simpler incident response.  
D. Allow 0.0.0.0/0 ingress to speed up troubleshooting.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q12

Scenario Focus: Filestore — Managed Network File Storage

What is the best way to choose between a custom stack and a managed service?

A. Use one VM with a static external IP to simplify architecture.  
B. Allow 0.0.0.0/0 ingress to speed up troubleshooting.  
C. Disable health checks to avoid accidental failover.  
D. Prefer managed services when they meet requirements with lower long-term maintenance effort.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q13

Scenario Focus: Filestore — Managed Network File Storage

How do you confirm a solution is production-ready for 

A. Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.  
B. Allow 0.0.0.0/0 ingress to speed up troubleshooting.  
C. Disable health checks to avoid accidental failover.  
D. Route all traffic through manual bastion hops in production.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q14

Scenario Focus: Filestore — Managed Network File Storage

Which pattern usually wins in ACE scenario tie-breakers?

A. Disable health checks to avoid accidental failover.  
B. Managed-service-first plus least-privilege access plus clear observability usually wins.  
C. Route all traffic through manual bastion hops in production.  
D. Expose the service publicly and rely on app-level passwords.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q15

Scenario Focus: Filestore — Managed Network File Storage

What is the best final check before locking the answer?

A. Route all traffic through manual bastion hops in production.  
B. Expose the service publicly and rely on app-level passwords.  
C. Run a weighted check across security, reliability, cost, performance, and operability.  
D. Use one VM with a static external IP to simplify architecture.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

### Quick Commands
```bash
gcloud compute firewall-rules list --project=PROJECT_ID
gcloud compute forwarding-rules list --global --project=PROJECT_ID
gcloud compute backend-services get-health BACKEND_NAME --global --project=PROJECT_ID
gcloud compute routes list --project=PROJECT_ID
```

### Fast Recall
- Pick load balancer type by traffic pattern, not preference.
- Private services should stay private end to end.
- Health checks and multi-zone design are core reliability controls.
<!-- ACE_DEEP_ENRICHMENT_END -->