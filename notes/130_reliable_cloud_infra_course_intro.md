# Reliable Cloud Infrastructure: Design and Process — Course Introduction

## What This Course Is About

- **Architecture, design, and process** — not about implementing specific Cloud features
- Simulates the real process of designing a system that runs on Google Cloud
- A Cloud Architect's job: determine which Cloud services to use to most effectively implement applications and services

> "The job of an architect is to draw rectangles and point arrows at them." — and that is an important step in designing complex systems.

---

## Course Modules (9 total, plus this introduction)

1. **Case study analysis and design** — using a microservice architecture
2. **DevOps and automation** — Google Cloud tools
3. **Storage service selection** — choosing the right storage for each microservice
4. **Network design** — for Cloud and Hybrid applications
5. **Deployment service selection** — VMs, Kubernetes, or App Engine
6. **Reliability design** — availability, durability, disaster recovery, cost
7. **Security design** — baking security into the architecture
8. **Monitoring** — dashboards, logs, error reporting, tracing
9. _(Additional modules)_

---

## Key Topics Covered

### Requirements Gathering

- The starting point for any software development
- Figure out what the software does, who the users are, and why it matters

### Microservices Architecture

- **Microservices**: an architectural style where a large application is broken into independent parts, each with its own area of responsibility
- A single user request may call many internal microservices to compose a response
- Effects on: **development speed**, **deployment**, **monitoring**, and **agility**
- Course covers both the **advantages and disadvantages** of this style

### Storage Selection

- Relational database vs NoSQL database vs data warehouse
- Objective criteria to choose the right storage for each use case

### Compute Platform Selection

- Virtual machines (Compute Engine)
- Kubernetes cluster (GKE)
- Automated platform (App Engine)

### Reliability

- Availability, durability, cost, disaster recovery
- Choose Google Cloud services that meet your reliability goals while optimizing costs

### Security

> "Security is not icing on the cake. It is baked into the cake."

- Security is a **shared responsibility**
- Google secures physical hardware; you configure networks, storage, and machines securely
- Security requirements must be considered from the start, not added later

### Monitoring

- Define application requirements up front
- Use monitoring tools to measure how well you meet your goals
- Tools: dashboards, logs, error reporting, tracing

---

## Course Format

- **Lectures** — concepts and design principles
- **Design activities** — architect a case study application; no single right answer
- **Hands-on labs** — practical implementation

> The more effort you put into design activities, the more you'll learn.

---

## Prerequisites and Audience

- Intended for **IT professionals** responsible for implementing, deploying, migrating, and maintaining Cloud applications
- Part of the **Cloud Infrastructure learning path**
- Prerequisite: completion of either:
  - _Architecting with Google Compute Engine_, or
  - _Architecting with Google Kubernetes Engine_
- **Not** intended as a first exposure to Google Cloud

## ACE Exam-Style Practice Questions

### Q1
In a Reliable Cloud Infra Course Intro scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Reliable Cloud Infra Course Intro, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
