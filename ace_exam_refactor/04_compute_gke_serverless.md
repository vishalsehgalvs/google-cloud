# Domain 4 - Compute, GKE, Serverless, MIG

## Compute Decision Core

- Compute Engine: full VM and OS control
- GKE Standard: full Kubernetes control including node tuning
- GKE Autopilot: Kubernetes without node management
- Cloud Run: stateless HTTP container with scale to zero
- Cloud Run Functions: event-driven function execution
- App Engine: managed app runtime with minimal platform work

## MIG and Scaling Core

- Health check: who gets traffic now
- Autohealing: recreate broken instances
- Autoscaling: adjust instance count by load
- Regional MIG: default for zone-failure resilience

## Pinpoint Traps

- Autohealing is configured on MIG, not solved by LB alone.
- HPA, VPA, and Cluster Autoscaler are different controls.
- GKE Standard is not the best answer when node operations must be minimal.
- Deleting and recreating deployment is not required for normal image update.

## Scenario Example 1

- Trigger words: stateless API, spiky traffic, minimal infra management
- Best answer: Cloud Run
- Why not Compute Engine: unnecessary ops burden
- Why not GKE Standard: too much platform management for requirement

```bash
gcloud run deploy api-service \
  --image=us-central1-docker.pkg.dev/PROJECT_ID/apps/api:1.0 \
  --region=us-central1 \
  --allow-unauthenticated
```

## Scenario Example 2

- Trigger words: strict Kubernetes control, custom node pools, daemon workloads
- Best answer: GKE Standard
- Why not Cloud Run: no direct Kubernetes object-level control
- Why not Autopilot: less control over node-level operations

```bash
gcloud container clusters create prod-standard \
  --region=us-central1 \
  --num-nodes=3

kubectl apply -f deployment.yaml
kubectl set image deployment/api api=us-central1-docker.pkg.dev/PROJECT_ID/apps/api:2.0
```

## Scenario Example 3

- Trigger words: VM app, needs autoscaling and self-healing
- Best answer: Regional MIG with autoscaling and health checks
- Why not unmanaged group: no managed healing behavior
- Why not single big VM: no elasticity and weak resilience

```bash
gcloud compute instance-templates create web-template \
  --machine-type=e2-medium \
  --image-family=debian-12 \
  --image-project=debian-cloud

gcloud compute instance-groups managed create web-mig \
  --template=web-template \
  --size=2 \
  --region=us-central1

gcloud compute instance-groups managed set-autoscaling web-mig \
  --region=us-central1 \
  --max-num-replicas=10 \
  --target-cpu-utilization=0.6
```

## GKE Fast Rules

- Per-pod scaling by load -> HPA
- Right-size CPU and memory requests -> VPA
- Node count scaling -> Cluster Autoscaler
- Private access to cluster nodes -> private cluster plus IAM

## One-Line Rules

- No strong control requirement usually means managed or serverless answer.
- VM autohealing and autoscaling should make you think MIG first.
- For rolling updates, update image in-place, do not rebuild the whole stack.
