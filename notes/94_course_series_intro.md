# Architecting with Google Compute Engine — Course Series Intro

## What Is Google Cloud?

- Part of a larger ecosystem: open-source software, partners, developers, third-party software, other cloud providers
- Google is a strong supporter of open source
- Powers: Chrome, Google devices, Maps, Gmail, Analytics, Google Workspace, Gemini
- Three core features: **Infrastructure**, **Platform**, **Software**

---

## Service Continuum (IaaS → SaaS)

| Model | Example | Control Level |
|---|---|---|
| IaaS | Compute Engine (VM + self-managed MySQL) | Full control, you manage everything |
| Managed service | Cloud SQL (MySQL with automated backups/patching) | Google handles operations |
| Serverless/NoSQL | Firestore (autoscaling, no server management) | Zero infrastructure management |

> You can build global, autoscaling, assistive applications where infrastructure is invisible to users.

---

## Compute Services Overview

| Service | Description | Model |
|---|---|---|
| Compute Engine | Run VMs on demand; maximum flexibility | IaaS |
| Google Kubernetes Engine (GKE) | Run containerized apps; Google manages the cluster | Managed containers |
| Cloud Run | Run stateless containers via HTTP/Pub/Sub; built on Knative | Serverless containers |
| Cloud Run Functions | Event-driven serverless execution; pay only while code runs | FaaS |

---

## Infrastructure Analogy

> IT infrastructure is like a city's infrastructure — transport, power, water, communication. Users = people; apps = cars and buildings. Everything supporting those apps for the user = infrastructure.

---

## Course Series Structure

### Course 1 — Essential Cloud Infrastructure: Foundation
- Intro to Google Cloud and the Console / Cloud Shell
- Virtual networks: create VPC networks and networking objects
- Virtual machines: create VMs with Compute Engine

### Course 2 — Essential Cloud Infrastructure: Core Services
- IAM: administer identity and access management
- Storage services: implement Cloud storage services
- Resource management: manage and examine billing
- Resource monitoring: monitor resources with Cloud Monitoring

### Course 3 — Elastic Cloud Infrastructure: Scaling and Automation
- Network interconnect options
- Load balancing and autoscaling
- Infrastructure automation with Terraform
- Other managed services in Google Cloud

---

## Learning Goals

- **Remember and understand** Google Cloud services and features
- **Apply** knowledge to real scenarios
- **Analyze** requirements and evaluate options
- **Create** your own services

> Labs are provided via **Google Skills** platform — includes a real Google Cloud account at no cost.
