# GKE Course — Google Cloud Core Concepts Introduction

## What This Section Covers

- Definition of **cloud computing**
- Google Cloud **services** available to architects and developers for building solutions
- How Google's **global network** powers Google Cloud services
- How Google Cloud **resources are structured and managed**
- Tools to **control costs** and avoid unexpected bills
- Four different ways to **interact with Google Cloud**

## Hands-on Practice

- Accessing the **Cloud Console**
- Using **Cloud Shell**

## ACE Exam-Style Practice Questions

### Q1
In a Gke Course Cloud Intro cluster, one microservice is CPU-heavy while others are general purpose. How should you optimize?

A. Keep one node pool and only increase pod priority
B. Create dedicated compute-optimized node pool for CPU-heavy workload and keep general-purpose pool for others
C. Disable autoscaling
D. Move workload to Cloud Storage

Answer: B
Trap: Node pools allow workload-specific machine-family optimization.

### Q2
A Gke Course Cloud Intro deployment must be updated with minimal downtime. Which command pattern is best?

A. Delete and recreate service and deployment
B. kubectl set image deployment/NAME CONTAINER=NEW_IMAGE
C. Restart all cluster nodes
D. Create a new project for each version

Answer: B
Trap: Rolling image update is safer and faster than destructive redeploy patterns.
