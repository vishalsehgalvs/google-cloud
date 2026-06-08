# Kubernetes Introspection and Debugging

## What is Introspection?

**Introspection** is the act of gathering information about the containers, Pods, services, and other engines running within a cluster — used to debug problems when an application is running.

---

## The Four Key Commands

| Command | Purpose |
| --- | --- |
| `kubectl get` | High-level status of objects |
| `kubectl describe` | Detailed information about an object |
| `kubectl exec` | Run a command inside a container |
| `kubectl logs` | View output from containers inside a Pod |

---

## `kubectl get pods`

Shows the **phase status** of each Pod:

| Phase | Meaning |
| --- | --- |
| `Pending` | Pod accepted by Kubernetes but not yet scheduled; container images not yet created (e.g., still being pulled) |
| `Running` | Pod is attached to a node; all containers are created and running, starting, or restarting |
| `Succeeded` | All containers finished/terminated successfully; will not restart |
| `Failed` | A container terminated with a failure; will not restart |
| `Unknown` | Pod state cannot be retrieved — likely a communication error between control plane and kubelet |
| `CrashLoopBackOff` | A container exited unexpectedly after being restarted at least once; usually means the Pod is misconfigured |

> `get` shows a **high-level summary**, not comprehensive details.

---

## `kubectl describe pod POD_NAME`

Provides detailed information about a Pod and its containers:

**For the Pod:**
- Name, namespace, node name, labels, status, IP address

**For each container:**
- State (waiting / running / terminated)
- Images, ports, commands, restart count

Also shows: labels, resource requirements, volumes, status details.

---

## `kubectl exec`

Run a **single command** inside a container and view results in your shell:

```bash
# Run a single command (e.g., ping)
kubectl exec POD_NAME -- ping google.com
```

### Interactive Shell (`-it`)

```bash
# Launch an interactive shell inside a container
kubectl exec -it POD_NAME -- /bin/bash
```

- `-i` — passes the terminal's standard input to the container
- `-t` — tells kubectl the input is a TTY
- Without `-it`, the command runs and returns immediately to your local shell

> **Best practice:** Do NOT install software directly into a running container — changes to a container's filesystem are **ephemeral**. Instead, build container images that include the software you need, then redeploy.  
> Use the interactive shell to figure out what changes are needed, then integrate them into the image.

---

## `kubectl logs POD_NAME`

View **stdout and stderr** output from applications running inside a Pod:

```bash
# Logs from a single-container Pod
kubectl logs POD_NAME

# Logs from a specific container in a multi-container Pod
kubectl logs POD_NAME -c CONTAINER_NAME
```

- Useful for finding errors or debug messages from failing containers
- Use `-c` when the Pod has multiple containers
