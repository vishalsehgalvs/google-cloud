# ☁️ Google Kubernetes Engine (GKE)

## What is GKE?

**GKE (Google Kubernetes Engine)** is Google's fully managed Kubernetes service. Instead of setting up and running Kubernetes yourself, Google does most of the heavy lifting for you.

- Runs on **Compute Engine** virtual machines grouped into a cluster
- You still use standard Kubernetes commands and APIs
- Google manages the infrastructure behind the scenes

---

## GKE vs Kubernetes (Self-managed)

| | Self-managed Kubernetes | GKE |
|---|---|---|
| Control plane setup | You do it | Google handles it |
| Node management | You do it | Depends on mode |
| Upgrades & patching | Manual | Automatic (Autopilot) |
| Complexity | High | Much simpler |

With GKE, you still get a single IP address to send all your Kubernetes API requests to — but Google manages everything behind that address for you.

---

## Two Modes: Autopilot vs Standard

### Autopilot Mode (Recommended)
Google manages almost everything for you:
- Node configuration
- Autoscaling
- Auto-upgrades
- Security settings
- Networking config

Best for: **most production workloads** where you want simplicity and reliability.

### Standard Mode
You manage the underlying infrastructure:
- Configure individual nodes yourself
- More control, but more work

Best for: teams that need **very specific configuration control** that Autopilot doesn't allow.

> Unless you have a specific reason to use Standard, stick with **Autopilot**.

---

## What GKE Manages For You

- **Load balancing** — automatically routes traffic across your Compute Engine instances
- **Node pools** — lets you group nodes with different specs within the same cluster
- **Auto-scaling** — adds or removes nodes based on demand
- **Auto-upgrades** — keeps your node software up to date
- **Node auto-repair** — detects and fixes unhealthy nodes automatically
- **Logging & monitoring** — built-in visibility via Google Cloud Observability

---

## How to Create a GKE Cluster

### Option 1 — Google Cloud Console
Use the web UI to point and click your way to a cluster.

### Option 2 — gcloud command

```bash
gcloud container clusters create k1
```

That single command spins up a full Kubernetes cluster on GKE named `k1`.

---

## Customizing Your Cluster

GKE clusters are flexible — you can configure:
- **Machine types** (how powerful each node is)
- **Number of nodes**
- **Network settings**

Once the cluster is running, you use standard Kubernetes commands (`kubectl`) to deploy apps, manage workloads, set policies, and check health.

---

## Key Takeaway

GKE lets you use Kubernetes without the pain of managing it yourself:
- **Autopilot mode** = Google manages everything
- **Standard mode** = you manage the nodes
- Built-in scaling, upgrades, load balancing, and monitoring
- Get a cluster running with a single `gcloud` command
