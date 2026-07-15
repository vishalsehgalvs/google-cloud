# Kubernetes Operations — Introduction

## What is kubectl?

- `kubectl` is the **command-line tool** for interacting with GKE (and any Kubernetes) clusters
- Lets you manage Kubernetes resources from the command line
- Makes it easy to **automate tasks** and **troubleshoot problems**

---

## What This Section Covers

| Topic | Description |
| --- | --- |
| **kubectl configuration** | How to set up and configure kubectl to talk to a cluster |
| **Introspection** | What it means and how to use it to troubleshoot a cluster |
| **Hands-on practice** | Deploying GKE clusters from Cloud Shell |

---

## Key Questions Answered

- How does kubectl work?
- Does it need special configuration?
- How can it gather information about containers, Pods, services, and other resources running in a cluster?

## ACE Exam-Style Practice Questions

### Q1
In a Kubernetes Operations Intro cluster, one microservice is CPU-heavy while others are general purpose. How should you optimize?

A. Keep one node pool and only increase pod priority
B. Create dedicated compute-optimized node pool for CPU-heavy workload and keep general-purpose pool for others
C. Disable autoscaling
D. Move workload to Cloud Storage

Answer: B
Trap: Node pools allow workload-specific machine-family optimization.

### Q2
A Kubernetes Operations Intro deployment must be updated with minimal downtime. Which command pattern is best?

A. Delete and recreate service and deployment
B. kubectl set image deployment/NAME CONTAINER=NEW_IMAGE
C. Restart all cluster nodes
D. Create a new project for each version

Answer: B
Trap: Rolling image update is safer and faster than destructive redeploy patterns.
