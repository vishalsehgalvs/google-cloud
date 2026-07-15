# Dataproc

## What Is Dataproc?

- A **fast, easy-to-use, fully managed cloud service** for running **Apache Spark** and **Apache Hadoop** clusters
- Designed to make big data processing simpler and cheaper than managing clusters yourself
- **Per-second billing** — pay only for resources you use
- Use **preemptible instances** in your cluster to reduce costs further

---

## Speed

| Operation         | Traditional (on-prem or other IaaS) | Dataproc            |
| ----------------- | ----------------------------------- | ------------------- |
| Create cluster    | 5–30 minutes                        | ~90 seconds or less |
| Scale cluster     | Minutes                             | ~90 seconds or less |
| Shut down cluster | Minutes                             | ~90 seconds or less |

> Fast cluster lifecycle means less waiting and more time working with your data.

---

## Key Features

- **Fully managed** — create clusters quickly, manage them easily, and shut them down when not needed (no idle cost)
- **Built-in integrations** with:
  - **BigQuery** — query and analyze data
  - **Cloud Storage** — persistent data storage
  - **Bigtable** — NoSQL data access
  - **Cloud Logging and Cloud Monitoring** — observability
- **No new tools needed** — if you already use Spark, Hadoop, Pig, or Hive, you can migrate existing projects without redevelopment

---

## Dataproc vs Dataflow

Both services support batch and streaming data processing — here's how to choose:

| Question                                                                     | Answer → Use       |
| ---------------------------------------------------------------------------- | ------------------ |
| Do you have dependencies on Apache Hadoop/Spark ecosystem tools or packages? | **Yes → Dataproc** |
| Do you prefer a hands-on / DevOps approach to cluster management?            | **Yes → Dataproc** |
| Do you prefer a hands-off / serverless approach?                             | **Yes → Dataflow** |

> In short: **Dataproc** for Hadoop/Spark workloads and DevOps control; **Dataflow** for serverless, fully managed pipelines.

## ACE Exam-Style Practice Questions

### Q1
A Dataproc migration requires moving existing Spark jobs with minimal code changes. What should you choose?

A. Dataproc
B. Cloud Run Functions
C. App Engine Standard
D. Compute Engine single VM only

Answer: A
Trap: Existing Spark and Hadoop workloads map directly to Dataproc.

### Q2
For Dataproc cost optimization on intermittent jobs, what is best?

A. Keep a large cluster running 24x7
B. Create ephemeral clusters per job and delete after completion
C. Disable autoscaling and logging
D. Move all jobs to Cloud DNS

Answer: B
Trap: Ephemeral clusters reduce idle cost while preserving Spark compatibility.
