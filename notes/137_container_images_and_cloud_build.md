# Container Images and Cloud Build

## Containers vs. Images

| Term                | Definition                                       |
| ------------------- | ------------------------------------------------ |
| **Container image** | An application bundled with all its dependencies |
| **Container**       | A running instance of an image                   |

- Developers can package and ship an application without worrying about the target system
- To build and run container images you need software — one option is **Docker**
- Docker alone does not orchestrate apps at scale — that's what **Kubernetes** is for

---

## Linux Technologies Behind Containers

Containers isolate workloads using four Linux building blocks:

| Technology             | What it controls                                                              |
| ---------------------- | ----------------------------------------------------------------------------- |
| **Linux processes**    | Each process gets its own virtual memory address space; rapid create/destroy  |
| **Linux namespaces**   | What the app can _see_ — process IDs, directory trees, IP addresses, etc.     |
| **Linux cgroups**      | What the app can _use_ — max CPU time, memory, I/O bandwidth, other resources |
| **Union file systems** | Bundles the app and its dependencies into clean, minimal layers               |

> **Note:** Linux namespaces ≠ Kubernetes namespaces.

---

## Dockerfile and Image Layers

- A **container image** is built in **read-only layers**
- The tool reads instructions from a **container manifest** — for Docker-formatted images, this is the **Dockerfile**
- Each instruction in the Dockerfile creates one layer

### Simple Dockerfile (4 commands = 4 layers)

```dockerfile
FROM ubuntu:22.04          # Layer 1 — base OS pulled from a public repo
COPY . /app                # Layer 2 — copies files from the build tool's current directory
RUN make /app              # Layer 3 — compiles the app; build output stored here
CMD ["/app/my-binary"]     # Layer 4 — command to run when the container launches
```

### Layer ordering best practice

- Put **least-likely-to-change** layers at the **top**
- Put **most-likely-to-change** layers at the **bottom**
- This maximises cache reuse across builds

---

## Multi-Stage Builds (Modern Best Practice)

The single-stage Dockerfile above is oversimplified:

- **Problem:** build tools (compilers, make, etc.) are clutter in a deployed container and increase the attack surface
- **Solution:** multi-stage builds
  - **Stage 1:** one container builds the final executable
  - **Stage 2:** a separate, minimal container receives only what is needed to run the app

---

## The Writable Container Layer

```
[ writable container layer ]  ← added at runtime; ephemeral
[ read-only image layer n   ]
[ read-only image layer ...  ]
[ read-only image layer 1   ]
```

- When a container starts, the runtime adds a **thin writable layer** on top
- All changes (new files, edits, deletes) go into this layer
- When the container is deleted, **this layer is lost forever**
- The underlying image remains **unchanged**

### Design implication

> Permanent data must be stored **outside** a running container (e.g., Cloud Storage, a database, a persistent volume).

---

## Image Sharing and Layer Efficiency

- Multiple containers can share the same underlying image while each maintains its own writable layer
- Images get smaller with each incremental release:
  - Base image: ~200 MB
  - Point release delta: ~200 KB
- Only the **difference** (diff) between layers is pulled or copied — much faster than spinning up a new VM

---

## Getting Container Images

| Source                                   | Details                                                                      |
| ---------------------------------------- | ---------------------------------------------------------------------------- |
| **Google Artifact Registry** (`pkg.dev`) | Public open-source images + private project storage; integrated with **IAM** |
| **Docker Hub Registry**                  | Large public repository of community images                                  |
| **GitLab**                               | Another public registry option                                               |

---

## Cloud Build

- Google's **managed service** for building container images
- Integrated with **Cloud IAM**
- Retrieves source code from:
  - Cloud Source Repositories
  - GitHub
  - Bitbucket (and other git-compatible repos)

### Build steps

Define a series of steps — each step runs in a Docker container:

- Fetch dependencies
- Compile source code
- Run integration tests
- Use tools like Docker, Gradle, Maven

### Delivery targets after build

| Target                       | Type               |
| ---------------------------- | ------------------ |
| **Google Kubernetes Engine** | Managed containers |
| **App Engine**               | PaaS               |
| **Cloud Run functions**      | Serverless         |

## ACE Exam-Style Practice Questions

### Q1
A Container Images And Cloud Build workload requires full OS control and custom runtime with strict policy against managed platforms. Which compute option is best?

A. Compute Engine
B. Cloud Run Functions
C. App Engine Standard
D. Dataflow

Answer: A
Trap: Full host-level control is a strong Compute Engine signal.

### Q2
In a Container Images And Cloud Build scenario, a fault-tolerant nightly batch workload is too expensive. What should you test and then use?

A. Spot or preemptible VMs after simulated interruption testing
B. Owner role on all instances
C. Single large sole-tenant node
D. Cloud DNS autoscaling

Answer: A
Trap: Interruptible workloads are classic candidates for discounted VM pricing models.
