# kubectl — Configuration and Usage

## What is kubectl?

- Command-line utility for **administering Kubernetes clusters**
- Communicates with the **kube-APIserver** on the control plane
- Transforms command-line entries into **API calls** sent over HTTPS
- Determines which part of the control plane to communicate with

> kubectl can **not** create new clusters or change cluster shape — that's done via `gcloud` or the Google Cloud Console.

---

## How kubectl is Configured

- Configuration is stored in: `~/.kube/config`
- Contains the list of clusters and the credentials for each
- Credentials come from **gcloud**

### Connecting kubectl to a GKE Cluster

```bash
gcloud container clusters get-credentials CLUSTER_NAME
```

- Writes credentials into `~/.kube/config`
- Rerunning for a different cluster **updates** the config file
- Only needs to be run **once per cluster** in Cloud Shell (the `.kube` directory persists in `$HOME`)
- After config is set, kubectl connects to the default cluster **automatically** — no credential prompt needed

### Viewing the Configuration

```bash
kubectl config view
```

> Note: `kubectl config` shows kubectl's own configuration; other kubectl commands show cluster and workload configurations.

---

## kubectl Syntax

```
kubectl [command] [TYPE] [NAME] [flags]
```

| Part | Description | Examples |
| --- | --- | --- |
| **command** | Action to perform | `get`, `describe`, `logs`, `exec` |
| **TYPE** | Kubernetes object type | `pods`, `deployments`, `nodes` |
| **NAME** | Specific object name (optional) | `my-test-app` |
| **flags** | Optional modifiers / special requests | `-o=yaml`, `-o=wide` |

---

## Common Usage Examples

```bash
# List all Pods
kubectl get pods

# Get a specific Pod
kubectl get pod my-test-app

# View Pod state as YAML (useful for recreating objects in another cluster)
kubectl get pod my-test-app -o=yaml

# List all Pods in wide format (shows which node each Pod runs on)
kubectl get pods -o=wide
```

---

## How a kubectl Request Flows

1. Admin runs `kubectl get pods`
2. kubectl converts the command into an **API call**
3. API call is sent to **kube-APIserver** over HTTPS
4. kube-APIserver queries **etcd** for the data
5. kube-APIserver returns results to kubectl over HTTPS
6. kubectl interprets the response and **displays results** at the command prompt

---

## Key Reminders

- Always configure kubectl first, or use `--kubeconfig` / `--context` flags to target the right cluster
- `gcloud` and `kubectl` are both installed by default in **Cloud Shell**
- Producing YAML output (`-o=yaml`) is useful for recreating or copying objects across clusters
