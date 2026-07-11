# Networking And Operations Deep Dive

## Networking fundamentals

VPC:

- private logical network boundary in cloud

Subnets:

- regional IP allocation segments

Firewall rules:

- define allowed and denied traffic paths

Routes:

- determine packet destination paths

## Delivery and edge services

Cloud DNS:

- domain-to-endpoint resolution

Cloud Load Balancing:

- distributes traffic to healthy backends
- improves availability and scalability

Cloud CDN:

- edge caching to reduce latency and backend load

## Connectivity decision level

Cloud VPN, interconnect, and peering appear in your notes.

Practitioner-level expectation:

- understand use-case level differences, not deep provisioning details

## Operations and reliability stack

Cloud Monitoring:

- metrics, dashboards, alert policies

Cloud Logging:

- central log storage and search

Error Reporting, Trace, Profiler:

- deeper debugging and performance visibility

## Reliability answer framework

For reliability questions, include:

- service availability strategy
- monitoring and alerting
- centralized logging
- managed services where possible

## Scenario set

1. Global app with user latency complaints.
   Likely additions: load balancing plus CDN.

2. Team cannot quickly detect production issues.
   Likely additions: monitoring dashboards and alerts.

3. Troubleshooting distributed request latency.
   Likely addition: Cloud Trace.

## Fast self-test

1. What is the core difference between DNS and load balancing?
2. Why is observability required in reliability-focused answers?
3. What is a strong exam-safe response for latency at global scale?
