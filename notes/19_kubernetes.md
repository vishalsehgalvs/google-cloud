# ☸️ Kubernetes

## What is Kubernetes?

Kubernetes is an **open-source platform** for managing and scaling containerized applications.

Think of it as a supervisor for your containers — it decides where to run them, keeps them healthy, and scales them up or down as needed.

- Runs containers across many machines at once
- Handles scaling, restarts, and traffic routing automatically
- Works with microservices and large distributed apps

---

## Key Concepts

### Cluster

A **cluster** is the whole system — a group of machines (nodes) that Kubernetes manages together.

### Node

A **node** is a single machine in the cluster. It's where your containers actually run.

> Note: In Google Cloud, nodes are virtual machines running in Compute Engine — but in Kubernetes, "node" just means any computing instance.

### Pod

A **Pod** is the smallest unit you can deploy in Kubernetes. It wraps one or more containers together.

- Usually **one container per Pod**
- If two containers are tightly linked, you can put them in the same Pod — they share network and storage
- Each Pod gets its own **IP address and ports**
- A Pod represents a running process on your cluster

### Deployment

A **Deployment** is a group of identical Pods (called replicas).

- Keeps your Pods running even if a node crashes
- Can represent one part of your app or the entire app
- You tell it how many copies (replicas) to run

### Service

A **Service** gives your Pods a **stable, fixed IP address** so other parts of the app (or outside users) can reach them reliably.

- Pods can come and go, but the Service IP stays the same
- In GKE, a Service with external access gets a **network load balancer** with a public IP
- Example: your frontend always talks to the backend Service — even if backend Pods are replaced, the frontend doesn't notice

---

## Control Plane

The **control plane** is the brain of the cluster. It runs the primary Kubernetes components that manage everything — scheduling, scaling, monitoring — so you don't have to.

---

## Common Commands

| Command                        | What it does                                   |
| ------------------------------ | ---------------------------------------------- |
| `kubectl run`                  | Start a Deployment with a container in a Pod   |
| `kubectl get pods`             | List all running Pods                          |
| `kubectl get deployments`      | List all Deployments                           |
| `kubectl describe deployments` | Show details about your Deployments            |
| `kubectl scale`                | Change the number of Pod replicas              |
| `kubectl get services`         | List Services and their external IPs           |
| `kubectl apply`                | Apply a config file to create/update resources |
| `kubectl rollout`              | Roll out a new version of your app             |

---

## Imperative vs Declarative

### Imperative (command by command)

You tell Kubernetes what to do step by step — good for learning and testing.

```bash
kubectl scale deployment my-app --replicas=3
```

### Declarative (config file)

You write a file describing what you **want** the final state to look like, and Kubernetes figures out how to get there. This is the recommended approach for real apps.

```bash
kubectl apply -f deployment.yaml
```

- Update the config file → run `kubectl apply` → Kubernetes handles the rest
- Easier to version control and repeat

---

## Scaling

- Run `kubectl scale` to manually set the number of replicas
- Or set up **autoscaling** — e.g., "add more Pods when CPU goes above 80%"
- Kubernetes places Pods behind the Service automatically — traffic is load balanced across all replicas

---

## Rolling Updates (Updating Your App)

When you push a new version, you don't want all Pods to restart at once — that causes downtime.

Kubernetes handles this with a **rolling update** strategy:

1. Create one new Pod with the updated version
2. Wait until it's healthy
3. Remove one old Pod
4. Repeat until all Pods are updated

You trigger this with `kubectl rollout` or by updating your deployment config and running `kubectl apply`.

---

## GKE — Google Kubernetes Engine

Running Kubernetes yourself is complex. **GKE (Google Kubernetes Engine)** is Google's managed Kubernetes service — it sets up and maintains the cluster for you so you can focus on your app.

---

## Key Takeaway

Kubernetes lets you:

- **Run containers at scale** across many machines
- **Keep apps running** even when individual machines fail
- **Deploy updates safely** without downtime
- **Scale automatically** based on real traffic or resource usage

---

## gcloud Commands (GKE)

```bash
# Create a GKE cluster
gcloud container clusters create my-cluster \
  --zone=us-central1-a --num-nodes=3

# Get credentials (sets up kubectl access)
gcloud container clusters get-credentials my-cluster --zone=us-central1-a

# List GKE clusters
gcloud container clusters list

# Delete a cluster
gcloud container clusters delete my-cluster --zone=us-central1-a
```

---

## Additional Workload Types

Beyond Deployments, Kubernetes has specialised controllers:

| Type | Purpose |
|---|---|
| **Deployment** | Stateless apps — web servers, APIs |
| **StatefulSet** | Stateful apps — databases, Kafka; stable network identity and persistent storage |
| **DaemonSet** | Run one Pod per node — log collectors, monitoring agents |
| **Job** | Run to completion — batch processing |
| **CronJob** | Run on a schedule — nightly reports, cleanup tasks |

---

## Namespaces

Namespaces partition a cluster into virtual sub-clusters — useful for multi-team environments.

```bash
kubectl get namespaces
kubectl create namespace my-team
kubectl get pods --namespace=my-team
```

- Default namespaces: `default`, `kube-system`, `kube-public`
- Resource quotas can be set per namespace to limit CPU/memory usage

---

## ConfigMaps and Secrets

### ConfigMap — non-sensitive configuration

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DB_HOST: "db.example.com"
  DB_PORT: "5432"
```

### Secret — sensitive data (base64-encoded at rest)

```bash
kubectl create secret generic db-secret \
  --from-literal=password=mysecretpassword
```

- Secrets should be stored in a secret manager (e.g. Secret Manager) for production; K8s Secrets are only base64, not encrypted by default unless ETCD encryption is enabled

---

## Persistent Volumes (Storage)

For stateful apps that need data to survive Pod restarts:

| Object | Role |
|---|---|
| **PersistentVolume (PV)** | A piece of storage provisioned in the cluster |
| **PersistentVolumeClaim (PVC)** | A request for storage by a Pod |
| **StorageClass** | Defines the type of storage (SSD, HDD) and provisioner |

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes: [ReadWriteOnce]
  resources:
    requests:
      storage: 10Gi
```

- In GKE, the default StorageClass provisions **Google Persistent Disks** automatically

---

## Resource Requests and Limits

```yaml
resources:
  requests:
    cpu: "250m"      # 0.25 vCPU guaranteed
    memory: "128Mi"
  limits:
    cpu: "500m"      # Max 0.5 vCPU
    memory: "256Mi"
```

- **Request** = minimum guaranteed; used for scheduling decisions
- **Limit** = hard cap; container is throttled (CPU) or killed (memory) if exceeded
- `m` = millicores (1000m = 1 vCPU)

---

## Horizontal Pod Autoscaler (HPA)

Automatically scales the number of Pods based on metrics:

```bash
kubectl autoscale deployment my-app \
  --cpu-percent=70 --min=2 --max=10
```

- Scales based on CPU, memory, or custom metrics
- Works alongside MIG autoscaling in GKE (node-level)

---

## Network Policies

Control which Pods can talk to which other Pods:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
spec:
  podSelector: {}
  policyTypes: [Ingress, Egress]
```

- Default: all Pods can talk to all other Pods
- Network policies require a CNI plugin that supports them (e.g. Calico, used in GKE)

---

## Ingress

An **Ingress** routes external HTTP/HTTPS traffic to Services based on path or hostname — a single IP for multiple services:

```
example.com/api  → api-service
example.com/web  → web-service
```

- In GKE, an Ingress creates a **Google Cloud HTTP(S) Load Balancer** automatically
- Supports SSL termination, path-based routing, host-based routing

---

## RBAC (Role-Based Access Control)

Controls who can do what inside the cluster:

| Object | Scope |
|---|---|
| **Role** | Permissions within a single namespace |
| **ClusterRole** | Permissions across the whole cluster |
| **RoleBinding** | Grants a Role to a user/service account in a namespace |
| **ClusterRoleBinding** | Grants a ClusterRole cluster-wide |

```bash
# View current permissions
kubectl auth can-i list pods --namespace=default
```

---

## Labels and Selectors

Labels are key-value pairs attached to any object — used by Services and Deployments to find their Pods:

```yaml
metadata:
  labels:
    app: web
    env: production
```

```bash
# Filter resources by label
kubectl get pods -l app=web,env=production
```

---

## Key Takeaways

- **Deployment** for stateless; **StatefulSet** for stateful; **DaemonSet** for per-node agents
- **ConfigMaps** for config; **Secrets** for sensitive data
- **PVCs** request persistent storage; GKE provisions Persistent Disks automatically
- Set **resource requests/limits** to prevent noisy-neighbour issues and enable scheduling
- **HPA** scales Pods horizontally; configure alongside node autoscaling in GKE
- **Ingress** replaces multiple LoadBalancer Services with a single HTTP(S) LB
- **RBAC** restricts access inside the cluster — always follow least-privilege

