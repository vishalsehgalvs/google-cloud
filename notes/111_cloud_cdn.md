# Cloud CDN

## Overview

- Uses Google's globally distributed **edge Points of Presence (PoPs)** to cache HTTP(S) load-balanced content close to users
- **90+ cache sites** across Asia Pacific, Americas, and EMEA
- Caches content at the edges of Google's network → faster delivery + reduced serving costs
- Enable with a **single checkbox** when setting up the backend service of an Application Load Balancer

---

## How It Works — Response Flow

**Example setup:**
- Managed instance groups in `us-central1` and `asia-east1` (dynamic/PHP traffic)
- Cloud Storage bucket in `us-east1` (static content)
- URL map routes requests to the appropriate backend

**Cache Miss:**
1. User in San Francisco requests content for the first time
2. Cache site in San Francisco can't fulfill the request → **cache miss**
3. Cache checks a nearby cache (e.g., Los Angeles) first
4. If not found nearby, request is forwarded to the Application Load Balancer → backend
5. If the response is **cacheable**, the San Francisco cache stores it for future use

**Cache Hit:**
- Next user in San Francisco requests the same content
- Cache site serves it directly → **shorter round trip**, origin server not involved

> Every Cloud CDN request is **automatically logged** in Google Cloud, with a `Cache Hit` or `Cache Miss` status per HTTP request.

---

## Cache Modes

Control how Cloud CDN caches content and whether it respects cache directives from the origin.

| Cache Mode | Behavior |
|---|---|
| `USE_ORIGIN_HEADERS` | Only caches responses that include valid cache directives and caching headers from the origin |
| `CACHE_ALL_STATIC` | Automatically caches static content without `no-store`, `private`, or `no-cache` directives; also caches origin responses with valid caching directives |
| `FORCE_CACHE_ALL` | Unconditionally caches all responses, overriding any cache directives set by the origin |

> **Warning:** Do not use `FORCE_CACHE_ALL` with a shared backend that serves private, per-user content (e.g., dynamic HTML or API responses) — it will cache and serve that content to other users.
