# Cloud Interconnect — Dedicated, Partner, and Cross-Cloud

## Dedicated Interconnect

- **Direct physical connection** between your on-premises network and Google's network
- More cost-effective than buying extra public internet bandwidth for large data transfers
- Requires provisioning a **cross connect** between the Google network and your router at a **common colocation facility**
- BGP session configured between **Cloud Router** and your on-premises router to exchange routes
- SLA options: **99.9% or 99.99%** uptime (depends on redundancy configuration)
- Your network must physically meet Google's network at a [supported colocation facility](https://cloud.google.com/interconnect/docs/concepts/colocation-facilities)

---

## Partner Interconnect

- Connectivity between your on-premises network and VPC through a **supported service provider**
- Use when: your data center can't reach a Dedicated Interconnect colocation facility, or your bandwidth needs don't justify Dedicated Interconnect
- Service providers have existing physical connections to Google's network
- You establish a BGP session between your Cloud Router and on-premises router via the provider's network
- SLA options: **99.9% or 99.99%** uptime between Google and the service provider
- Full list of providers: [Partner Interconnect service providers](https://cloud.google.com/interconnect/docs/concepts/service-providers)

---

## Cross-Cloud Interconnect

- **Dedicated physical connection** between Google Cloud and another cloud service provider
- Lets you peer your GCP VPC with networks hosted by supported providers
- Supported providers: **AWS, Microsoft Azure, Oracle Cloud Infrastructure, Alibaba Cloud**
- Benefits: reduced complexity, site-to-site data transfer, encryption, multi-cloud strategy support
- Available in two sizes: **10 Gbps or 100 Gbps**
- Process: choose supported locations → purchase primary + redundant ports from Google → purchase primary + redundant ports from the other provider
- Google supports the connection **up to the other provider's network boundary** — does not guarantee uptime beyond that point

---

## Interconnect Options Comparison

| Option                   | Capacity                                                           | Requirement                              | Best For                                             |
| ------------------------ | ------------------------------------------------------------------ | ---------------------------------------- | ---------------------------------------------------- |
| Cloud VPN                | 1.5–3 Gbps per tunnel (scalable with multiple tunnels)             | VPN device on-premises                   | Low cost, lower bandwidth, experimentation/migration |
| Dedicated Interconnect   | 10 Gbps or 100 Gbps per link (up to 8×10 Gbps or 2×100 Gbps links) | Connection at Google colocation facility | Enterprise-grade, high throughput                    |
| Partner Interconnect     | 50 Mbps – 50 Gbps per connection                                   | Depends on service provider              | No nearby colocation facility; moderate bandwidth    |
| Cross-Cloud Interconnect | 10 Gbps or 100 Gbps                                                | Supported multi-cloud location           | Connecting to another cloud provider                 |

> **Note on Cloud VPN capacity:** 1.5 Gbps applies to traffic over the public internet; 3 Gbps applies to traffic over a direct peering link.

---

## Choosing the Right Option

- **Cloud VPN** — lower cost, lower bandwidth, or migrating/experimenting
- **Dedicated or Partner Interconnect** — enterprise-grade, higher throughput
- **Cross-Cloud Interconnect** — connecting to another cloud service provider
- Google recommends **Cloud Interconnect over Direct Peering or Carrier Peering** in most cases

## ACE Exam-Style Practice Questions

### Q1
For Cloud Interconnect Dedicated Partner Crosscloud, you need highly available hybrid connectivity with dynamic route exchange. What should you choose?

A. HA VPN with Cloud Router
B. Static routes only over one tunnel
C. Cloud NAT only
D. Cloud CDN

Answer: A
Trap: Dynamic routing and high availability requirements usually indicate HA VPN plus BGP.

### Q2
In a Cloud Interconnect Dedicated Partner Crosscloud design, multiple projects in one org need centralized networking administration. What is best?

A. Shared VPC
B. Separate isolated VPCs with no governance
C. One service account for every project owner
D. DNS forwarding only

Answer: A
Trap: Shared VPC centralizes subnet and firewall control across service projects.

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
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
A service must be reachable only from internal VMs. Which design is best?

A. Use an internal load balancer with private backend endpoints and private DNS.
B. Expose the service publicly and rely on app-level passwords.
C. Use one VM with a static external IP to simplify architecture.
D. Allow 0.0.0.0/0 ingress to speed up troubleshooting.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
You need to reduce global web latency for static assets. What should you choose?

A. Use one VM with a static external IP to simplify architecture.
B. Use an external application load balancer with Cloud CDN and cacheable content rules.
C. Allow 0.0.0.0/0 ingress to speed up troubleshooting.
D. Disable health checks to avoid accidental failover.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
Which firewall strategy best matches zero-trust network design?

A. Allow 0.0.0.0/0 ingress to speed up troubleshooting.
B. Disable health checks to avoid accidental failover.
C. Use least-privilege firewall policies scoped by service accounts or tags.
D. Route all traffic through manual bastion hops in production.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
A backend fails health checks in one zone. What architecture is best practice?

A. Disable health checks to avoid accidental failover.
B. Route all traffic through manual bastion hops in production.
C. Expose the service publicly and rely on app-level passwords.
D. Run multi-zone backends with health checks and automatic failover.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
You need private hybrid connectivity between on-prem and GCP. Which path is preferred?

A. Use HA VPN or Interconnect based on throughput and SLA requirements.
B. Route all traffic through manual bastion hops in production.
C. Expose the service publicly and rely on app-level passwords.
D. Use one VM with a static external IP to simplify architecture.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
Two designs both satisfy the happy path for Cloud Interconnect — Dedicated, Partner, and Cross-Cloud. Which choice is most correct?

A. Expose the service publicly and rely on app-level passwords.
B. Choose the option that preserves reliability and security while reducing operational burden.
C. Use one VM with a static external IP to simplify architecture.
D. Allow 0.0.0.0/0 ingress to speed up troubleshooting.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
What should you validate first before choosing an architecture for Cloud Interconnect — Dedicated, Partner, and Cross-Cloud?

A. Use one VM with a static external IP to simplify architecture.
B. Allow 0.0.0.0/0 ingress to speed up troubleshooting.
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.
D. Disable health checks to avoid accidental failover.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
A proposal lowers cost but increases failure risk. What is the best decision?

A. Allow 0.0.0.0/0 ingress to speed up troubleshooting.
B. Disable health checks to avoid accidental failover.
C. Route all traffic through manual bastion hops in production.
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
Which option best reflects optimization for Latency-resilience balance with private-by-default connectivity?

A. Select the design that best meets Latency-resilience balance with private-by-default connectivity while keeping constraints balanced.
B. Disable health checks to avoid accidental failover.
C. Route all traffic through manual bastion hops in production.
D. Expose the service publicly and rely on app-level passwords.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
How should you evaluate a design that needs frequent manual interventions?

A. Route all traffic through manual bastion hops in production.
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.
C. Expose the service publicly and rely on app-level passwords.
D. Use one VM with a static external IP to simplify architecture.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q11
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
Two options have similar latency. Which tie-breaker is best?

A. Expose the service publicly and rely on app-level passwords.
B. Use one VM with a static external IP to simplify architecture.
C. Pick the option with stronger operability, clearer failure isolation, and simpler incident response.
D. Allow 0.0.0.0/0 ingress to speed up troubleshooting.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q12
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
What is the best way to choose between a custom stack and a managed service?

A. Use one VM with a static external IP to simplify architecture.
B. Allow 0.0.0.0/0 ingress to speed up troubleshooting.
C. Disable health checks to avoid accidental failover.
D. Prefer managed services when they meet requirements with lower long-term maintenance effort.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q13
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
How do you confirm a solution is production-ready for 

A. Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.
B. Allow 0.0.0.0/0 ingress to speed up troubleshooting.
C. Disable health checks to avoid accidental failover.
D. Route all traffic through manual bastion hops in production.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q14
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
Which pattern usually wins in ACE scenario tie-breakers?

A. Disable health checks to avoid accidental failover.
B. Managed-service-first plus least-privilege access plus clear observability usually wins.
C. Route all traffic through manual bastion hops in production.
D. Expose the service publicly and rely on app-level passwords.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q15
Scenario Focus: Cloud Interconnect — Dedicated, Partner, and Cross-Cloud
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