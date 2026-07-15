# Interacting with Google Cloud — Four Ways

## Overview

| Method                             | Best For                                                   |
| ---------------------------------- | ---------------------------------------------------------- |
| **Google Cloud Console**           | GUI-based management, quick resource access                |
| **Google Cloud SDK + Cloud Shell** | Command-line management, scripting, GKE administration     |
| **APIs**                           | Programmatic control from application code                 |
| **Google Cloud App**               | Mobile management of Compute Engine, Cloud SQL, App Engine |

---

## 1. Google Cloud Console

- Google Cloud's **graphical user interface (GUI)** — accessed at [console.cloud.google.com](https://console.cloud.google.com)
- Deploy, scale, and diagnose production issues from a simple web-based interface
- Features:
  - Find and check health of resources
  - Full management control
  - Set budgets
  - Search facility to quickly find resources
  - Connect to instances via **SSH in the browser**

---

## 2. Google Cloud SDK and Cloud Shell

### Google Cloud SDK

- A set of command-line tools you can **download and install locally**
- Tools included:

| Tool             | Purpose                                         |
| ---------------- | ----------------------------------------------- |
| `gcloud`         | Main CLI for Google Cloud products and services |
| `gcloud storage` | Access Cloud Storage from the command line      |
| `bq`             | Command-line tool for BigQuery                  |

- All tools are located under the **`bin` directory** when installed

### Cloud Shell

- **Browser-based command-line access** to cloud resources — no local install needed
- Debian-based VM with a **persistent 5 GB home directory**
- Each Cloud Shell VM is **ephemeral** — stopped when idle, restarted when you return
- Always has the latest Google Cloud SDK installed, up to date, and **fully authenticated**
- Features:
  - Web preview functionality
  - Built-in authorization for GCP projects and resources (including GKE)
  - Launch point for `gcloud` commands and `kubectl` (Kubernetes CLI)

> For GKE: the GCP Console provides a web UI for GKE resources; Cloud Shell is where you run commands to administer them.

---

## 3. APIs

- Every Google Cloud service exposes **APIs** so application code can control it
- **Google APIs Explorer** (in the Cloud Console) shows available APIs and their versions
- APIs can be tested interactively, even those requiring user authentication
- Developers use APIs to build applications that allocate and manage GCP resources
- In the context of this GKE course: Kubernetes manages resources for us, so APIs are less of a focus

---

## 4. Google Cloud App (Mobile)

- Mobile app for managing Google Cloud on the go
- Capabilities:
  - Start, stop, and SSH into **Compute Engine** instances; view logs
  - Start and stop **Cloud SQL** instances
  - Manage **App Engine** apps: view errors, roll back deployments, change traffic splitting

> Not relevant for the GKE course — listed here for completeness.

## ACE Exam-Style Practice Questions

### Q1
In a Interacting With Google Cloud scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Interacting With Google Cloud, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
