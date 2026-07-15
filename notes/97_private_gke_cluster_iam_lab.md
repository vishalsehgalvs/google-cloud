# Private GKE Cluster with Custom IAM Role — Lab Walkthrough

> Region: `us-east1` | Zone: `us-east1-c`

---

## Part 1 — Run in Cloud Shell

Sets up variables, creates the custom IAM role, provisions the service account, binds roles, and deploys the private GKE cluster.

```bash
# 1. Set Environment Variables
export REGION="us-east1"
export ZONE="us-east1-c"
export PROJECT_ID=$(gcloud config get-value project)
export SA_EMAIL="orca-gke-sa@$PROJECT_ID.iam.gserviceaccount.com"

# 2. Create Custom IAM Role
gcloud iam roles create orca_storage_editor \
    --project=$PROJECT_ID \
    --title="Custom Security Role" \
    --description="Custom IAM role for GKE to manage storage objects" \
    --permissions="storage.buckets.get,storage.objects.get,storage.objects.list,storage.objects.update,storage.objects.create" \
    --stage="GA"

# 3. Create Service Account
gcloud iam service-accounts create orca-gke-sa --display-name="Service Account"

# 4. Bind Roles to Service Account
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_EMAIL" --role="projects/$PROJECT_ID/roles/orca_storage_editor"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_EMAIL" --role="roles/logging.logWriter"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_EMAIL" --role="roles/monitoring.metricWriter"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA_EMAIL" --role="roles/monitoring.viewer"

# 5. Fetch JumpHost Internal IP
export JUMPHOST_INTERNAL_IP=$(gcloud compute instances describe orca-jumphost \
    --zone=$ZONE \
    --format='get(networkInterfaces[0].networkIP)')

# 6. Create Private GKE Cluster
gcloud container clusters create orca-cluster \
    --project=$PROJECT_ID \
    --zone=$ZONE \
    --num-nodes=1 \
    --network="orca-build-vpc" \
    --subnet="orca-build-subnet" \
    --service-account="$SA_EMAIL" \
    --enable-ip-alias \
    --enable-private-nodes \
    --enable-private-endpoint \
    --enable-master-authorized-networks \
    --master-authorized-networks="$JUMPHOST_INTERNAL_IP/32" \
    --master-ipv4-cidr="172.16.0.0/28"
```

> GKE cluster creation takes roughly **5 minutes** to complete.

---

## Part 2 — Connect to JumpHost and Deploy the App

Once Part 1 finishes, SSH into the jumphost from Cloud Shell:

```bash
gcloud compute ssh orca-jumphost --zone=us-east1-c
```

If prompted to generate SSH keys, press **Enter** to continue.

Then paste this entire block into the SSH session:

```bash
# Set variables inside the JumpHost VM
export REGION="us-east1"
export ZONE="us-east1-c"
export PROJECT_ID=$(gcloud config get-value project)

# Install GKE authentication plugin
sudo apt-get update && sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y
echo "export USE_GKE_GCLOUD_AUTH_PLUGIN=True" >> ~/.bashrc
source ~/.bashrc

# Fetch cluster credentials over the internal network endpoint
gcloud container clusters get-credentials orca-cluster \
    --internal-ip \
    --project=$PROJECT_ID \
    --zone=$ZONE

# Deploy the test microservice
kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0
```

Once the final command runs, exit the SSH window and click **Check my progress** across all tasks in the Qwiklabs dashboard.

---

## Key Concepts

- **Private cluster** — nodes have no public IPs; the control plane endpoint is also private (`--enable-private-endpoint`)
- **Master authorized networks** — only the jumphost's internal IP is allowed to reach the control plane
- **`--master-ipv4-cidr`** — dedicated CIDR block for the control plane VPC peering (`172.16.0.0/28`)
- **`--internal-ip` flag** on `get-credentials` — needed because the cluster endpoint is private; must be run from inside the same VPC (i.e., from the jumphost)
- **Custom IAM role** (`orca_storage_editor`) — grants only the specific storage permissions needed, following least-privilege
- **GKE auth plugin** (`gke-gcloud-auth-plugin`) — required for `kubectl` to authenticate with GKE clusters in newer SDK versions

## ACE Exam-Style Practice Questions

### Q1
In a Private Gke Cluster Iam Lab cluster, one microservice is CPU-heavy while others are general purpose. How should you optimize?

A. Keep one node pool and only increase pod priority
B. Create dedicated compute-optimized node pool for CPU-heavy workload and keep general-purpose pool for others
C. Disable autoscaling
D. Move workload to Cloud Storage

Answer: B
Trap: Node pools allow workload-specific machine-family optimization.

### Q2
A Private Gke Cluster Iam Lab deployment must be updated with minimal downtime. Which command pattern is best?

A. Delete and recreate service and deployment
B. kubectl set image deployment/NAME CONTAINER=NEW_IMAGE
C. Restart all cluster nodes
D. Create a new project for each version

Answer: B
Trap: Rolling image update is safer and faster than destructive redeploy patterns.
