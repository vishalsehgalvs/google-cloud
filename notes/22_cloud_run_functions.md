# ⚡ Cloud Run Functions

## What is Cloud Run Functions?

**Cloud Run Functions** is a lightweight, serverless compute solution where you write small, focused functions that run automatically in response to events — no server or runtime to manage.

Think of it as: _"something happens → your code runs → it stops."_

---

## Real-World Example: Image Upload

Say users can upload images to your app. When an image is uploaded, you might need to:

- Convert it to a standard format
- Resize it into different thumbnail sizes
- Save each version to a storage bucket

You could build all of this into your main app — but then you'd need compute running 24/7 whether uploads happen every millisecond or once a day.

With Cloud Run Functions, you write one small function to handle the image processing, and it **only runs when a new image is uploaded**. No idle costs, no wasted resources.

---

## Key Characteristics

- **Event-driven** — triggered by something that happens (a file upload, a message, an HTTP request)
- **Single-purpose** — each function does one specific job
- **Asynchronous** — can run in the background without blocking anything else
- **Serverless** — no infrastructure to set up or maintain
- **Pay per use** — billed to the nearest **100 milliseconds**, only while your code is actually running

---

## What Can Trigger a Function?

| Trigger Type      | How it works                                                |
| ----------------- | ----------------------------------------------------------- |
| **Cloud Storage** | Fires when a file is uploaded, deleted, or changed          |
| **Pub/Sub**       | Fires when a message is published to a topic (asynchronous) |
| **HTTP**          | Fires when someone calls a URL directly (synchronous)       |

---

## What Can You Use Functions For?

- **Event processing** — react to file uploads, database changes, messages
- **Business logic tasks** — small isolated pieces of logic that don't need a full app
- **Connecting cloud services** — glue different Google Cloud services together
- **Extending existing apps** — add functionality without changing your core app

---

## Supported Languages

- Node.js
- Python
- Go
- Java
- .NET Core
- Ruby
- PHP

> Check the official runtimes documentation for specific supported versions.

---

## Key Takeaway

Cloud Run Functions is the right tool when:

- You have **event-driven work** that doesn't need to run constantly
- You want **zero infrastructure management**
- You need small, **single-purpose pieces of logic**
- You only want to **pay when your code actually runs**

---

## gcloud Commands

```bash
# Deploy a function (HTTP trigger)
gcloud functions deploy my-function \
  --runtime=python310 --trigger-http --allow-unauthenticated

# Deploy with a Pub/Sub trigger
gcloud functions deploy my-function \
  --runtime=python310 --trigger-topic=my-topic

# List all functions
gcloud functions list

# View function logs
gcloud functions logs read my-function

# Delete a function
gcloud functions delete my-function
```

## ACE Exam-Style Practice Questions

### Q1
A Cloud Run Functions service is event-driven and should scale automatically with minimal infrastructure management. Which option is usually best?

A. Cloud Run or Cloud Run Functions depending on trigger pattern
B. Unmanaged VMs only
C. Self-managed Kubernetes on Compute Engine
D. Dedicated interconnect

Answer: A
Trap: Event-driven and minimal-ops requirements typically map to serverless services.

### Q2
In a Cloud Run Functions release, you need safe rollout and quick rollback using real traffic testing. What should you do?

A. Overwrite current version in place
B. Deploy new version and use traffic splitting or gradual migration
C. Delete old version before testing
D. Disable logging during rollout

Answer: B
Trap: Versioned deployments plus traffic control provide safer rollback paths.
