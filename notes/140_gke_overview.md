# Google Kubernetes Engine (GKE)

## What Is GKE?

> **GKE** is a fully managed Kubernetes service hosted on Google's infrastructure, designed to deploy, manage, and scale Kubernetes environments for containerized applications.

- **Fully managed** — no need to provision underlying resources
- Uses a **container-optimized OS** maintained by Google, optimized to scale quickly with a minimal resource footprint

---

## GKE Autopilot

- A mode of operation that manages your **cluster configuration automatically**
- Covers: nodes, scaling, security, and other preconfigured settings
- Less operational overhead compared to Standard mode

---

## Core GKE Features

| Feature                 | Detail                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------- |
| **Cluster**             | The Kubernetes system GKE creates and sets up for you                                 |
| **Auto-upgrade**        | Clusters are always upgraded to the latest stable version of Kubernetes automatically |
| **Nodes**               | VMs that host containers within a GKE cluster                                         |
| **Node auto-repair**    | Periodic health checks on each node; unhealthy nodes are drained and recreated        |
| **Cluster autoscaling** | GKE can scale the cluster itself, not just the workloads running on it                |

---

## GKE Integrations

| Service                             | Role in GKE                                                                      |
| ----------------------------------- | -------------------------------------------------------------------------------- |
| **Cloud Build + Artifact Registry** | Automates deployment using private container images stored securely              |
| **IAM**                             | Controls access via accounts and role permissions                                |
| **Google Cloud Observability**      | Provides insight into application performance                                    |
| **Virtual Private Cloud (VPC)**     | Supplies network infrastructure including load balancers and ingress access      |
| **Google Cloud Console**            | Dashboard for viewing, inspecting, and deleting GKE clusters and their resources |

---

## Google Cloud Console vs. Open-Source Kubernetes Dashboard

- Open-source Kubernetes provides a dashboard, but it requires **significant effort to set up securely**
- The **Google Cloud Console** offers a more powerful, managed dashboard for GKE clusters and workloads — no setup or management required
