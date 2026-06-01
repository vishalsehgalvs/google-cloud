# Dataproc — Demo Walkthrough

## What This Demo Covers

- Create a Dataproc cluster with default settings
- Resize the cluster (add a worker node)
- Submit an Apache Spark job to estimate the value of pi
- Delete the cluster when done

---

## Step 1 — Create a Cluster

1. Navigate to **Dataproc** in the GCP Console (under Big Data)
2. Click **Create Cluster**
3. Set a name (e.g., `example-cluster`)
4. Review the default settings (no need to change for this demo):

| Setting         | Default                                    |
| --------------- | ------------------------------------------ |
| Region / Zone   | Default                                    |
| Mode            | Standard (1 master + N workers)            |
| Master node     | 4 vCPUs                                    |
| Worker nodes    | 2 × 4 vCPUs = 8 vCPUs total across workers |
| **Total vCPUs** | **12**                                     |

**Advanced options** (available but not changed here):

- Make worker nodes preemptible
- Network and firewall tags
- Internal IP only
- Cloud Storage staging bucket
- Custom image and encryption

5. Click **Create** — Dataproc provisions the VMs and installs Spark/Hadoop software in the background

> You can verify the VMs by navigating to **Compute Engine** — you'll see the master (`-m`) and workers (`-w-0`, `-w-1`) using the cluster name as a prefix.

---

## Step 2 — Resize the Cluster

Once the cluster status shows **Running**:

1. Click on the cluster name → **Configuration** tab
2. You'll see `Workers: 2`
3. Click **Edit** → change workers to `3` → **Save**
4. Dataproc provisions a new worker VM and notifies the master so all workers are used for future jobs

> The new worker appears in Compute Engine almost immediately. The cluster update takes ~1–2 minutes.

---

## Step 3 — Submit a Spark Job

1. Go to the cluster → **Jobs** tab → **Submit Job**
2. Fill in the job details:

| Field      | Value                                           |
| ---------- | ----------------------------------------------- |
| Job ID     | (auto-generated, leave as-is)                   |
| Region     | (same as cluster)                               |
| Cluster    | Select your cluster                             |
| Job type   | **Spark**                                       |
| Main class | `org.apache.spark.examples.SparkPi`             |
| Arguments  | `1000` (number of iterations for pi estimation) |
| JAR file   | Path to the Spark examples JAR                  |

3. Click **Submit**
4. Click on the running job to view live output
5. Once complete, the output shows: `Pi is roughly 3.14159...`

---

## Step 4 — Delete the Cluster

When you no longer need the cluster:

1. Go back to the cluster list
2. Select the cluster → click **Delete**
3. Confirm — this deletes the cluster and all its data (irreversible)

> Verify in **Compute Engine** — all instances are stopped and deleted within ~1–2 minutes.

**Key point:** Delete clusters when not in use — you are only charged while the cluster is running.

---

## Key Takeaways

- Dataproc cluster creation, scaling, and deletion each take **~90 seconds or less**
- Even though Dataproc is a managed service, the underlying **Compute Engine VMs are visible** and accessible
- **Resize clusters on demand** — add or remove workers at any time
- **Delete clusters when idle** to avoid paying for unused compute
- Submit standard Spark, Hadoop, Pig, or Hive jobs without changing your existing code
