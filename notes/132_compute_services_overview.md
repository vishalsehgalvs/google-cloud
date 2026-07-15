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
