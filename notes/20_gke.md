# ☁️ Google Kubernetes Engine (GKE)

## What is GKE?

**GKE (Google Kubernetes Engine)** is Google's fully managed Kubernetes service. Instead of setting up and running Kubernetes yourself, Google does most of the heavy lifting for you.

- Runs on **Compute Engine** virtual machines grouped into a cluster
- You still use standard Kubernetes commands and APIs
- Google manages the infrastructure behind the scenes

---

## GKE vs Kubernetes (Self-managed)

|                     | Self-managed Kubernetes | GKE                   |
| ------------------- | ----------------------- | --------------------- |
| Control plane setup | You do it               | Google handles it     |
| Node management     | You do it               | Depends on mode       |
| Upgrades & patching | Manual                  | Automatic (Autopilot) |
| Complexity          | High                    | Much simpler          |

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

---

## GKE Networking

- **VPC-native clusters** (recommended) — Pods get IPs from a subnet secondary range; enables VPC firewall rules and VPC peering for Pods
- **Network policies** — control Pod-to-Pod traffic (requires enabling at cluster creation)
- **GKE Ingress** — automatically creates a Google Cloud HTTP(S) Load Balancer for external traffic
- **Internal Ingress** — creates an Internal Load Balancer for traffic inside your VPC

```bash
# Create cluster with network policy support
gcloud container clusters create my-cluster \
  --zone=us-central1-a \
  --enable-network-policy
```

---

## Workload Identity

The recommended way to let GKE workloads access Google Cloud APIs **without service account key files**:

- Maps a Kubernetes ServiceAccount → GCP Service Account
- Pods automatically receive short-lived credentials
- No key file to rotate, store, or leak

```bash
# Enable Workload Identity on a cluster
gcloud container clusters update my-cluster \
  --zone=us-central1-a \
  --workload-pool=PROJECT_ID.svc.id.goog

# Bind K8s SA to GCP SA
gcloud iam service-accounts add-iam-policy-binding gcp-sa@PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/iam.workloadIdentityUser \
  --member="serviceAccount:PROJECT_ID.svc.id.goog[NAMESPACE/KSA_NAME]"
```

---

## Node Pools

A **node pool** is a group of nodes within a cluster that all have the same configuration:

- Different pools can have different machine types, disk sizes, labels, taints
- Useful for separating GPU nodes from CPU nodes, or spot from regular nodes

```bash
# Add a node pool
gcloud container node-pools create gpu-pool \
  --cluster=my-cluster --zone=us-central1-a \
  --machine-type=n1-standard-4 --accelerator=type=nvidia-tesla-t4,count=1
```

---

## Cluster Upgrades

| Setting                 | Detail                                                            |
| ----------------------- | ----------------------------------------------------------------- |
| **Auto-upgrade**        | Enabled by default; keeps nodes on a supported version            |
| **Release channels**    | `rapid`, `regular` (default), `stable` — controls upgrade cadence |
| **Surge upgrades**      | Controls how many extra nodes are created during rolling upgrade  |
| **Maintenance windows** | Restrict upgrade times to off-peak hours                          |

```bash
# Set release channel
gcloud container clusters update my-cluster \
  --zone=us-central1-a \
  --release-channel=regular
```

---

## Cluster Autoscaler

Automatically adds/removes **nodes** (not Pods) based on pending Pod resource requests:

```bash
gcloud container clusters update my-cluster \
  --zone=us-central1-a \
  --enable-autoscaling \
  --min-nodes=1 --max-nodes=10 \
  --node-pool=default-pool
```

- Works alongside HPA (which scales Pods) — cluster autoscaler adds nodes when Pods can't be scheduled

---

## Binary Authorization

Enforces that only **trusted container images** are deployed to GKE:

- Requires images to have an attestation (cryptographic signature) from a trusted authority
- Blocks unverified images at deploy time
- Integrates with Cloud Build and Artifact Registry

---

## Key Takeaways — GKE

| Topic                  | Key Point                                                         |
| ---------------------- | ----------------------------------------------------------------- |
| **Autopilot**          | Google manages nodes, scaling, security — best for most workloads |
| **Workload Identity**  | Always use instead of service account key files                   |
| **VPC-native**         | Use alias IP clusters for full VPC integration                    |
| **Node pools**         | Separate workloads by hardware requirements                       |
| **Release channels**   | Use `regular` for production stability                            |
| **Cluster autoscaler** | Scales nodes; HPA scales Pods — use both together                 |

## ACE Exam-Style Practice Questions

### Q1
In a Gke cluster, one microservice is CPU-heavy while others are general purpose. How should you optimize?

A. Keep one node pool and only increase pod priority
B. Create dedicated compute-optimized node pool for CPU-heavy workload and keep general-purpose pool for others
C. Disable autoscaling
D. Move workload to Cloud Storage

Answer: B
Trap: Node pools allow workload-specific machine-family optimization.

### Q2
A Gke deployment must be updated with minimal downtime. Which command pattern is best?

A. Delete and recreate service and deployment
B. kubectl set image deployment/NAME CONTAINER=NEW_IMAGE
C. Restart all cluster nodes
D. Create a new project for each version

Answer: B
Trap: Rolling image update is safer and faster than destructive redeploy patterns.
