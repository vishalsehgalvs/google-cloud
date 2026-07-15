# Managed Services — Module Introduction

## What Are Managed Services?

- **Partial or complete solutions offered as a service** — you use them without building or maintaining the underlying infrastructure
- Exist on a continuum between **PaaS and SaaS**, depending on how much of the internal methods and controls are exposed
- Allow you to **outsource administrative and maintenance overhead to Google** when your application fits within the service offering

---

## Managed Services vs Infrastructure Automation

| Approach                                        | Description                                                                  |
| ----------------------------------------------- | ---------------------------------------------------------------------------- |
| **Infrastructure automation** (e.g., Terraform) | You define and manage the infrastructure; automation handles provisioning    |
| **Managed services**                            | You eliminate the need to create infrastructure entirely — Google manages it |

---

## Data Analytics Managed Services Covered in This Module

| Service                  | Purpose                                                                       |
| ------------------------ | ----------------------------------------------------------------------------- |
| **BigQuery**             | Fully managed, serverless data warehouse for large-scale analytics            |
| **Dataflow**             | Fully managed stream and batch data processing (Apache Beam)                  |
| **Dataprep by Trifacta** | Intelligent data service for visually exploring, cleaning, and preparing data |
| **Dataproc**             | Managed Spark and Hadoop service for big data processing                      |

> These services are all for **data analytics** purposes. This module provides an overview and a demo — no hands-on labs.

## ACE Exam-Style Practice Questions

### Q1
In a Managed Services Intro scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Managed Services Intro, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
