# Getting Started with Google Kubernetes Engine — Course Introduction

## What This Course Covers

- Basics of **Google Kubernetes Engine (GKE)** — Kubernetes as a managed service on Google Cloud
- How to get applications **containerized and running** in Google Cloud
- Taught through videos, quizzes, and hands-on labs

## Course Modules

1. Basic introduction to Google Cloud
2. Overview of containers and Kubernetes
3. Kubernetes architecture
4. Kubernetes operations

---

## What Is Kubernetes?

- A **software layer that sits between your applications and your hardware infrastructure**
- GKE brings Kubernetes as a **managed service** on Google Cloud

---

## Intended Audience

You'll get the most from this course if you have:

- Basic proficiency with **command-line tools**
- Familiarity with **Linux operating system environments**
- Experience with **web server technologies** (e.g., Nginx)
- Systems operations experience — deploying and managing applications on-premises or in a public cloud

## ACE Exam-Style Practice Questions

### Q1
In a Gke Course Intro cluster, one microservice is CPU-heavy while others are general purpose. How should you optimize?

A. Keep one node pool and only increase pod priority
B. Create dedicated compute-optimized node pool for CPU-heavy workload and keep general-purpose pool for others
C. Disable autoscaling
D. Move workload to Cloud Storage

Answer: B
Trap: Node pools allow workload-specific machine-family optimization.

### Q2
A Gke Course Intro deployment must be updated with minimal downtime. Which command pattern is best?

A. Delete and recreate service and deployment
B. kubectl set image deployment/NAME CONTAINER=NEW_IMAGE
C. Restart all cluster nodes
D. Create a new project for each version

Answer: B
Trap: Rolling image update is safer and faster than destructive redeploy patterns.
