# ⚡ Cloud Run Functions

## What is Cloud Run Functions?

**Cloud Run Functions** is a lightweight, serverless compute solution where you write small, focused functions that run automatically in response to events — no server or runtime to manage.

Think of it as: *"something happens → your code runs → it stops."*

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

| Trigger Type | How it works |
|---|---|
| **Cloud Storage** | Fires when a file is uploaded, deleted, or changed |
| **Pub/Sub** | Fires when a message is published to a topic (asynchronous) |
| **HTTP** | Fires when someone calls a URL directly (synchronous) |

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
