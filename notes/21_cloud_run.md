# 🚀 Cloud Run

## What is Cloud Run?

**Cloud Run** is a fully managed compute platform that runs your containerized apps — no servers to set up or maintain.

- Runs **stateless containers** triggered by web requests or Pub/Sub events
- Built on **Knative** (an open-source runtime built on top of Kubernetes)
- Can run on Google Cloud (fully managed), on GKE, or anywhere Knative runs
- **Serverless** — you focus on your app, Google handles the infrastructure

---

## Why Cloud Run?

- **No infrastructure to manage** — no VMs, no clusters, no patching
- **Scales from zero instantly** — if no requests come in, no containers run (and you pay nothing)
- **Pay only for what you use** — billed per 100 milliseconds of actual request handling
- **Any language** — runs any binary compiled for Linux 64-bit

---

## How It Works (3-Step Workflow)

1. **Write your app** — in any language, just make sure it starts a server that listens for HTTP requests
2. **Build a container image** — package your app into a container
3. **Deploy to Cloud Run** — push your image to Artifact Registry, and Cloud Run deploys it

After deployment, you get back a unique **HTTPS URL**. Cloud Run handles incoming traffic by spinning containers up and down automatically.

---

## Two Ways to Deploy

### Container-based workflow
You build and manage the container image yourself — more control and transparency.

### Source-based workflow
You push your **source code directly** — Cloud Run builds it into a container for you using **Buildpacks** (an open-source project). Good when you just want an HTTPS endpoint without worrying about containers.

---

## HTTPS Out of the Box

Cloud Run handles **HTTPS and encryption automatically**. You only need to handle the web request logic in your code — Cloud Run takes care of the rest.

---

## Pricing

- You pay **only when your container is handling requests**
- Billing granularity: **per 100 milliseconds**
- If no requests come in → **you pay nothing**
- Small fee per **1 million requests** served
- More vCPU and memory = higher cost per container

No over-provisioning, no idle costs.

---

## Supported Languages

Cloud Run can run **any binary compiled for Linux 64-bit**, which means:

**Popular languages:**
- Java, Python, Node.js, PHP, Go, C++

**Less common languages (also work fine):**
- Cobol, Haskell, Perl

As long as your app can handle web requests, Cloud Run can run it.

---

## Key Takeaway

Cloud Run is ideal when you want to:
- **Deploy containers without managing servers**
- **Scale automatically** — including down to zero
- **Pay only for actual usage**
- **Go from code to a live HTTPS endpoint** as quickly as possible
