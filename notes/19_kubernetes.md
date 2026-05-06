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

| Command | What it does |
|---|---|
| `kubectl run` | Start a Deployment with a container in a Pod |
| `kubectl get pods` | List all running Pods |
| `kubectl get deployments` | List all Deployments |
| `kubectl describe deployments` | Show details about your Deployments |
| `kubectl scale` | Change the number of Pod replicas |
| `kubectl get services` | List Services and their external IPs |
| `kubectl apply` | Apply a config file to create/update resources |
| `kubectl rollout` | Roll out a new version of your app |

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
