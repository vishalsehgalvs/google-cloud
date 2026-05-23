# 🏗️ Architecting with Google Compute Engine — Course Introduction

## What is Google Cloud?

Google Cloud is more than just a set of tools — it's part of a larger ecosystem that includes:

- Open-source software
- Third-party developers and partners
- Other cloud providers

Google is a strong supporter of open-source, and the same infrastructure that runs Gmail, Google Maps, Google Search, and Gemini is what Google Cloud is built on.

---

## Three Core Features of Google Cloud

1. **Infrastructure** — the physical and virtual foundation (servers, networking, storage)
2. **Platform** — services to build and run applications on top of that infrastructure
3. **Software** — ready-made tools and apps for end users

---

## Google Cloud's Global Network

Google Cloud is spread across the world with:

- **Regions** — geographic areas containing data centers
- **Zones** — isolated locations within a region
- **Points of presence** — network entry points

All connected via high-speed **fiber optic cables**.

> For the latest info on locations: [cloud.google.com/about/locations](https://cloud.google.com/about/locations)

---

## IaaS → PaaS → SaaS: A Spectrum of Control

Google Cloud spans the full range from full infrastructure control to fully managed software:

|          | What you manage               | Example               |
| -------- | ----------------------------- | --------------------- |
| **IaaS** | Everything (OS, runtime, app) | Compute Engine        |
| **PaaS** | Just your app                 | App Engine, Cloud Run |
| **SaaS** | Nothing — just use it         | Google Workspace      |

You can mix and match. For example:

- Spin up a VM with Compute Engine and install MySQL yourself (full control)
- Use Cloud SQL instead and let Google handle backups and patches
- Or go fully serverless with a NoSQL database that scales on its own

---

## IT Infrastructure: A City Analogy

Think of IT infrastructure like a city:

- The **roads, power, water, and communication networks** = the infrastructure
- The **people** = the users
- The **cars, buildings, and bikes** = the applications

Everything that supports and connects the applications to the users is infrastructure. That's what these courses focus on.

---

## Google Cloud Compute Services (Quick Overview)

### Compute Engine (IaaS)

Run virtual machines on demand. Maximum flexibility — you manage the OS and everything on it.

### Google Kubernetes Engine (GKE)

Run containerized apps on a Google-managed Kubernetes cluster. You stay in control, but Google handles the cluster.

### Cloud Run

Run stateless containers triggered by web requests or Pub/Sub events. Fully serverless — built on Knative.

### Cloud Run Functions

Write individual functions that run only when triggered by events. Serverless, auto-scales, pay only when your code runs.

---

## Course Series: Architecting with Google Compute Engine

This series is part of the **Cloud Engineer learning path**, meant for IT professionals who build, deploy, and maintain cloud applications.

### Course 1 — Essential Cloud Infrastructure: Foundation

- How to use the Google Cloud Console and Cloud Shell
- Creating VPC networks and networking objects
- Creating virtual machines with Compute Engine

### Course 2 — Essential Cloud Infrastructure: Core Services

- IAM (Identity and Access Management)
- Data storage services
- Resource management and billing
- Resource monitoring with Google Cloud Monitoring

### Course 3 — Elastic Cloud Infrastructure: Scaling and Automation

- Network interconnect options
- Load balancing and autoscaling
- Infrastructure automation with Terraform
- Other managed Google Cloud services

---

## What You Will Learn to Do

By the end of this series, you should be able to:

- Understand what different Google Cloud services do and when to use them
- Apply knowledge to real-world requirements
- Evaluate different options and choose the right one
- Build your own cloud solutions using Google Cloud building blocks

---

## Hands-On Labs

All courses include labs through the **Google Skills platform**, which gives you a real Google Cloud account with no cost to practice directly in the console.

---

## gcloud Commands

```bash
# Authenticate with Google Cloud
gcloud auth login

# Set default project
gcloud config set project PROJECT_ID

# Set default region and zone
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-a

# View current configuration
gcloud config list
```
