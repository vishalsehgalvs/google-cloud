# Command Playbook (Exam-Focused)

Use placeholders in uppercase.

## Project and Billing

```bash
gcloud projects create PROJECT_ID --name="PROJECT_NAME"
gcloud config set project PROJECT_ID
gcloud billing accounts list
gcloud billing projects link PROJECT_ID --billing-account=BILLING_ACCOUNT_ID
```

## IAM and Service Accounts

```bash
gcloud iam service-accounts create SA_NAME --display-name="DISPLAY_NAME"
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=group:GROUP_EMAIL \
  --role=roles/viewer

gcloud projects get-iam-policy PROJECT_ID
```

## Temporary Access With Condition

```bash
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=user:USER_EMAIL \
  --role=roles/compute.admin \
  --condition=expression="request.time < timestamp('2026-08-01T00:00:00Z')",title=temp_access,description=incident_window
```

## Cloud Storage

```bash
gcloud storage buckets create gs://BUCKET_NAME --location=REGION --default-storage-class=STANDARD
gsutil ls gs://BUCKET_NAME
gsutil cp FILE_PATH gs://BUCKET_NAME/
gsutil mv gs://BUCKET_NAME/OLD_NAME gs://BUCKET_NAME/NEW_NAME
gsutil lifecycle set lifecycle.json gs://BUCKET_NAME
```

## VPC, Subnet, Firewall

```bash
gcloud compute networks create VPC_NAME --subnet-mode=custom
gcloud compute networks subnets create SUBNET_NAME --network=VPC_NAME --range=10.10.0.0/20 --region=REGION
gcloud compute firewall-rules create allow-http --network=VPC_NAME --allow=tcp:80,tcp:443 --target-tags=web
```

## Cloud NAT and Private Google Access

```bash
gcloud compute routers create NAT_ROUTER --network=VPC_NAME --region=REGION
gcloud compute routers nats create NAT_CONFIG --router=NAT_ROUTER --region=REGION --nat-all-subnet-ip-ranges --auto-allocate-nat-external-ips
gcloud compute networks subnets update SUBNET_NAME --region=REGION --enable-private-ip-google-access
```

## Compute Engine and MIG

```bash
gcloud compute instance-templates create TEMPLATE_NAME --machine-type=e2-medium --image-family=debian-12 --image-project=debian-cloud

gcloud compute instance-groups managed create MIG_NAME --template=TEMPLATE_NAME --size=2 --region=REGION

gcloud compute instance-groups managed set-autoscaling MIG_NAME --region=REGION --max-num-replicas=10 --target-cpu-utilization=0.6
```

## GKE and kubectl

```bash
gcloud container clusters create CLUSTER_NAME --region=REGION --num-nodes=3
gcloud container clusters create-auto AUTOPILOT_CLUSTER --region=REGION
kubectl apply -f deployment.yaml
kubectl set image deployment/DEPLOYMENT_NAME CONTAINER_NAME=IMAGE_URI
```

## Cloud Run

```bash
gcloud run deploy SERVICE_NAME --image=IMAGE_URI --region=REGION --allow-unauthenticated
gcloud run services describe SERVICE_NAME --region=REGION
```

## SQL and Spanner

```bash
gcloud sql instances create SQL_INSTANCE --database-version=POSTGRES_15 --cpu=2 --memory=8GB --region=REGION --availability-type=REGIONAL
gcloud spanner instance-configs list
gcloud spanner instances create SPANNER_INSTANCE --config=CONFIG_ID --processing-units=1000 --description="DESCRIPTION"
```

## Pub/Sub and Dataflow

```bash
gcloud pubsub topics create TOPIC_NAME
gcloud pubsub subscriptions create SUB_NAME --topic=TOPIC_NAME

gcloud dataflow jobs run JOB_NAME \
  --gcs-location=TEMPLATE_GCS_PATH \
  --region=REGION \
  --staging-location=STAGING_GCS_PATH \
  --parameters=PARAMETERS
```

## BigQuery

```bash
bq mk --dataset PROJECT_ID:DATASET_NAME
bq query --use_legacy_sql=false --dry_run "SELECT COUNT(*) FROM DATASET.TABLE"
bq show --format=prettyjson PROJECT_ID:DATASET.TABLE
```

## Logging and Audit Export

```bash
gcloud logging sinks create SINK_NAME \
  bigquery.googleapis.com/projects/PROJECT_ID/datasets/DATASET_NAME \
  --log-filter='logName:"cloudaudit.googleapis.com"'

gcloud logging read 'severity>=ERROR' --limit=20
```

## High-Frequency Command Traps

- Use add-iam-policy-binding when adding one principal role mapping.
- Be careful with set-iam-policy because it replaces policy document.
- For Cloud Storage object move or rename behavior, use gsutil mv.
- Pub/Sub message delivery requires subscription, not topic only.
