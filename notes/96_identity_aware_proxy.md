# Identity-Aware Proxy (IAP)

## What is IAP?

Identity-Aware Proxy is a Google Cloud service that sits in front of your web application and handles authentication and authorization for you — no custom auth code required in most cases.

**How it works:**

1. A user sends a request to your app
2. IAP **intercepts** the request before it reaches the app
3. IAP **authenticates** the user via Google Identity Service
4. If the user is authorized (has the correct IAM role), the request is allowed through
5. IAP can optionally **modify the request headers** to include the authenticated user's identity

---

## Why Use IAP?

| Without IAP | With IAP |
| -------------------------------------------- | ----------------------------------------------------- |
| Your app must implement its own auth logic | No auth code needed for basic access restriction |
| Must manage sessions, tokens, login flows | Google Identity Service handles it |
| Often relies on network-level firewalls | Application-level access control — no VPN required |

- Resources protected by IAP can only be accessed by users/groups with the correct IAM role
- Works for **HTTPS applications** — provides an app-level access control model

---

## Two Use Cases

### 1. Restricting Access (No App Changes Needed)
If you just want to limit which users can reach your app, IAP handles it entirely — no changes to your application code.

### 2. Knowing the User's Identity (Minimal App Code)
If your app needs to know *who* the user is (e.g. to store user preferences server-side), IAP injects the authenticated user's identity into the request headers. Your app reads the header — no full auth implementation needed.

---

## Key Points

- IAP uses **Google Identity** for authentication — users sign in with their Google accounts
- Authorization is controlled via **IAM roles** on the protected resource
- No VPN needed — it's an application-layer control
- Also used to **SSH into VMs** without external IPs (Cloud IAP tunneling)

## ACE Exam-Style Practice Questions

### Q1
In a Identity Aware Proxy scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Identity Aware Proxy, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
