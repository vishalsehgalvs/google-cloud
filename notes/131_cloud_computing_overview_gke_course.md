# Cloud Computing Overview

## The Five Traits of Cloud Computing

1. **On-demand and self-service** — customers get computing resources (processing power, storage, network) through a web interface with no human intervention needed
2. **Accessible over the internet** — resources are available from anywhere with a connection
3. **Large pooled resources** — the provider buys in bulk and allocates from a shared pool; customers don't need to know the physical location of their resources
4. **Elastic** — resources are flexible; scale up quickly when you need more, scale back when you need less
5. **Pay as you go** — customers pay only for what they use or reserve; stop using, stop paying

---

## Google Cloud Services for Architects and Developers

Google Cloud offers a range of services to build solutions on:

- Some are familiar concepts — e.g., **virtual machines**
- Some represent new paradigms — e.g., **Google Kubernetes Engine**

### Common Starting Point: Running Code in the Cloud

Organizations often begin by wanting to run code in the cloud. Google offers a range of **compute services** to fulfill that — covered in the next section.

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Computing Overview Gke Course cluster, one microservice is CPU-heavy while others are general purpose. How should you optimize?

A. Keep one node pool and only increase pod priority
B. Create dedicated compute-optimized node pool for CPU-heavy workload and keep general-purpose pool for others
C. Disable autoscaling
D. Move workload to Cloud Storage

Answer: B
Trap: Node pools allow workload-specific machine-family optimization.

### Q2
A Cloud Computing Overview Gke Course deployment must be updated with minimal downtime. Which command pattern is best?

A. Delete and recreate service and deployment
B. kubectl set image deployment/NAME CONTAINER=NEW_IMAGE
C. Restart all cluster nodes
D. Create a new project for each version

Answer: B
Trap: Rolling image update is safer and faster than destructive redeploy patterns.
