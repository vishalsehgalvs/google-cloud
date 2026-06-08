# 🚀 Cloud Run

## What is Cloud Run?

**Cloud Run** is a fully managed compute platform that runs your containerized apps — no servers to set up or maintain.

- Runs **stateless containers** triggered by web requests or Pub/Sub events
- Built on **Knative** (an open-source runtime built on top of Kubernetes)
- Can run on Google Cloud (fully managed), on GKE, or anywhere Knative runs
- **Serverless** — you focus on your app, Google handles the infrastructure

---

## Why Cloud Run?

- **No infrastructure to manage** — no VMs, no clusters, no patching
- **Scales from zero instantly** — if no requests come in, no containers run (and you pay nothing)
- **Pay only for what you use** — billed per 100 milliseconds of actual request handling
- **Any language** — runs any binary compiled for Linux 64-bit

---

## How It Works (3-Step Workflow)

1. **Write your app** — in any language, just make sure it starts a server that listens for HTTP requests
2. **Build a container image** — package your app into a container
3. **Deploy to Cloud Run** — push your image to Artifact Registry, and Cloud Run deploys it

After deployment, you get back a unique **HTTPS URL**. Cloud Run handles incoming traffic by spinning containers up and down automatically.

---

## Two Ways to Deploy

### Container-based workflow

You build and manage the container image yourself — more control and transparency.

### Source-based workflow

You push your **source code directly** — Cloud Run builds it into a container for you using **Buildpacks** (an open-source project). Good when you just want an HTTPS endpoint without worrying about containers.

---

## HTTPS Out of the Box

Cloud Run handles **HTTPS and encryption automatically**. You only need to handle the web request logic in your code — Cloud Run takes care of the rest.

---

## Pricing

- You pay **only when your container is handling requests**
- Billing granularity: **per 100 milliseconds**
- If no requests come in → **you pay nothing**
- Small fee per **1 million requests** served
- More vCPU and memory = higher cost per container

No over-provisioning, no idle costs.

---

## Supported Languages

Cloud Run can run **any binary compiled for Linux 64-bit**, which means:

**Popular languages:**

- Java, Python, Node.js, PHP, Go, C++

**Less common languages (also work fine):**

- Cobol, Haskell, Perl

As long as your app can handle web requests, Cloud Run can run it.

---

## Key Takeaway

Cloud Run is ideal when you want to:

- **Deploy containers without managing servers**
- **Scale automatically** — including down to zero
- **Pay only for actual usage**
- **Go from code to a live HTTPS endpoint** as quickly as possible

---

## gcloud Commands

```bash
# Deploy a container to Cloud Run
gcloud run deploy my-service \
  --image=gcr.io/PROJECT_ID/my-image --platform=managed --region=us-central1

# Deploy directly from source code
gcloud run deploy my-service --source . --region=us-central1

# List Cloud Run services
gcloud run services list --region=us-central1

# Delete a service
gcloud run services delete my-service --region=us-central1
```

---

## Configuration Options

```bash
gcloud run deploy my-service \
  --image=gcr.io/PROJECT_ID/my-image \
  --region=us-central1 \
  --memory=512Mi \
  --cpu=1 \
  --concurrency=80 \
  --timeout=300 \
  --max-instances=10 \
  --min-instances=0 \
  --service-account=my-sa@PROJECT_ID.iam.gserviceaccount.com
```

| Setting | Default | Notes |
|---|---|---|
| `--memory` | 512Mi | Up to 32Gi |
| `--cpu` | 1 | Up to 8 vCPUs; can set fractional (0.08–8) |
| `--concurrency` | 80 | Max simultaneous requests per container instance |
| `--timeout` | 300s | Max 3600s (1 hour) |
| `--min-instances` | 0 | Set >0 to avoid cold starts |
| `--max-instances` | 1000 | Caps autoscaling |

---

## Cold Starts

When `min-instances=0` and no container is running, the first request must wait for a new container to start — called a **cold start**:

- Cold starts typically add 1–5 seconds of latency
- Mitigation: set `--min-instances=1` (keeps one warm instance; adds cost)
- Keep container image small and startup logic minimal

---

## Authentication — Public vs Private

```bash
# Allow unauthenticated (public) access
gcloud run services add-iam-policy-binding my-service \
  --region=us-central1 \
  --member=allUsers \
  --role=roles/run.invoker

# Allow only a specific service account
gcloud run services add-iam-policy-binding my-service \
  --region=us-central1 \
  --member=serviceAccount:my-sa@PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/run.invoker
```

- Default: **authentication required** (only authorised identities can invoke)
- Public APIs/websites: add `allUsers` as invoker

---

## Traffic Splitting and Canary Deployments

Split traffic between multiple revisions for gradual rollouts:

```bash
# Send 90% to latest, 10% to previous revision
gcloud run services update-traffic my-service \
  --region=us-central1 \
  --to-revisions=REVISION_NEW=90,REVISION_OLD=10

# Roll back to a previous revision
gcloud run services update-traffic my-service \
  --region=us-central1 \
  --to-revisions=REVISION_OLD=100
```

---

## Secrets and Environment Variables

```bash
# Set an environment variable
gcloud run services update my-service \
  --region=us-central1 \
  --set-env-vars=ENV=production,DB_HOST=db.example.com

# Mount a Secret Manager secret as an env variable
gcloud run services update my-service \
  --region=us-central1 \
  --set-secrets=DB_PASSWORD=my-secret:latest
```

- Always use **Secret Manager** for credentials — never hardcode in container images

---

## Eventarc Integration

Cloud Run can be triggered by events beyond HTTP:

| Trigger | Example |
|---|---|
| **HTTP** | Direct web requests |
| **Pub/Sub** | Message queue events |
| **Eventarc** | Cloud Storage uploads, Audit Log events, Firestore changes |
| **Cloud Scheduler** | Cron-style scheduled jobs |

```bash
# Trigger Cloud Run from a Pub/Sub topic
gcloud eventarc triggers create my-trigger \
  --location=us-central1 \
  --destination-run-service=my-service \
  --destination-run-region=us-central1 \
  --event-filters=type=google.cloud.pubsub.topic.v1.messagePublished \
  --transport-topic=my-topic
```

---

## Key Takeaways — Cloud Run

- Set **`min-instances=1`** only if cold start latency is unacceptable (adds cost)
- Use **Secret Manager** (`--set-secrets`) not environment variables for credentials
- Default authentication is **private** — explicitly add `allUsers` for public services
- Use **traffic splitting** for canary releases and safe rollbacks
- Cloud Run scales to **zero** — ideal for event-driven, bursty, or infrequent workloads
