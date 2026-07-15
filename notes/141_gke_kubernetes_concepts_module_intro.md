# GKE — Kubernetes Concepts Module Intro

## Module Overview

This section covers how to describe and manage workloads in Kubernetes and GKE.

### Topics

- **Kubernetes concepts** — object model and the principle of declarative management
- **Kubernetes components** — overview of the key building blocks
- **GKE concepts** — Autopilot mode vs. Standard mode
- **Kubernetes object management** — how to create and manage objects
- **Hands-on** — deploying a sample pod in GKE

## ACE Exam-Style Practice Questions

### Q1
In a Gke Kubernetes Concepts Module Intro cluster, one microservice is CPU-heavy while others are general purpose. How should you optimize?

A. Keep one node pool and only increase pod priority
B. Create dedicated compute-optimized node pool for CPU-heavy workload and keep general-purpose pool for others
C. Disable autoscaling
D. Move workload to Cloud Storage

Answer: B
Trap: Node pools allow workload-specific machine-family optimization.

### Q2
A Gke Kubernetes Concepts Module Intro deployment must be updated with minimal downtime. Which command pattern is best?

A. Delete and recreate service and deployment
B. kubectl set image deployment/NAME CONTAINER=NEW_IMAGE
C. Restart all cluster nodes
D. Create a new project for each version

Answer: B
Trap: Rolling image update is safer and faster than destructive redeploy patterns.
