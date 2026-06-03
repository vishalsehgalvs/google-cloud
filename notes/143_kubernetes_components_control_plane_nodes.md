# Kubernetes Components — Control Plane and Nodes

## Cluster Structure

```
┌──────────────────────────────────────────────┐
│              Control Plane                   │  ← coordinates the entire cluster
│  kube-APIserver │ etcd │ kube-scheduler       │
│  kube-controller-manager │ kube-cloud-manager │
└──────────────────────────────────────────────┘
        │              │              │
   ┌────┴────┐    ┌────┴────┐   ┌────┴────┐
   │  Node   │    │  Node   │   │  Node   │   ← run Pods
   │ kubelet │    │ kubelet │   │ kubelet │
   │kube-proxy│  │kube-proxy│  │kube-proxy│
   └─────────┘    └─────────┘   └─────────┘
```

- Computers are usually VMs (always in GKE, but can be physical)
- **Control plane** — coordinates the cluster
- **Nodes** — run Pods

---

## Control Plane Components

### kube-APIserver

- The **only component you interact with directly**
- Accepts commands that view or change cluster state (including launching Pods)
- Authenticates, authorizes, and validates incoming requests
- Manages **admission control**
- All queries and changes to cluster state must go through it

### kubectl

- Command-line tool that connects to `kube-APIserver`
- Communicates via the Kubernetes API

### etcd

- The cluster's **database**
- Reliably stores all cluster state:
  - Cluster configuration
  - Which nodes are in the cluster
  - Which Pods should be running and where
- You never interact with etcd directly — `kube-APIserver` does on behalf of the system

### kube-scheduler

- **Schedules Pods onto nodes** (selects the best node; does not launch the Pod)
- Evaluates each Pod's requirements and writes the chosen node name into the Pod object
- Scheduling considers:
  - Hardware, software, and policy constraints
  - **Affinity** — groups of Pods that should run on the same node
  - **Anti-affinity** — Pods that must not run on the same node

### kube-controller-manager

- Continuously monitors cluster state via `kube-APIserver`
- When current state ≠ desired state, it attempts to remediate
- Many Kubernetes objects are managed by **controllers** — loops of code that handle remediation
- Example: a **Deployment** controller object keeps 3 nginx Pods running, scales them, and exposes them behind a front end
- **Node Controller** — monitors and responds when a node goes offline

### kube-cloud-manager

- Manages controllers that interact with the **underlying cloud provider**
- On Compute Engine: responsible for Google Cloud features like load balancers and storage volumes

---

## Node Components

### kubelet

- Kubernetes's **agent on each node**
- `kube-APIserver` connects to the kubelet to start a Pod on that node
- Uses the **container runtime** to start the Pod
- Monitors Pod lifecycle (readiness and liveness probes)
- Reports back to `kube-APIserver`

### Container runtime

- Software used to launch a container from a container image
- Kubernetes supports several runtimes
- GKE nodes use **containerd** (the runtime component of Docker)

### kube-proxy

- Maintains **network connectivity** among Pods in the cluster
- In open-source Kubernetes, uses **iptables** firewalling built into the Linux kernel

---

## GKE vs. Self-Managed Kubernetes

| Concern                       | Self-managed Kubernetes | GKE                                                       |
| ----------------------------- | ----------------------- | --------------------------------------------------------- |
| Control plane provisioning    | You manage it           | GKE manages it entirely                                   |
| API endpoint                  | You configure           | GKE exposes an IP; you send Kubernetes API requests to it |
| Control plane infrastructure  | You maintain            | GKE provisions and manages it                             |
| Separate control plane needed | Yes                     | No — eliminated                                           |

### GKE Modes

| Mode                          | Who manages nodes & infrastructure                                                              |
| ----------------------------- | ----------------------------------------------------------------------------------------------- |
| **Autopilot** _(recommended)_ | GKE manages node config, autoscaling, auto-upgrades, baseline security, and baseline networking |
| **Standard**                  | You manage underlying infrastructure, including individual node configuration                   |
