# Foundations And Platform Deep Dive

## Cloud model mastery

IaaS:

- Best when you need infrastructure-level control.
- Tradeoff is higher operational burden.

PaaS:

- Best when you want productivity and managed runtime.
- Tradeoff is less low-level customization.

Serverless:

- Best for variable demand and small operations teams.
- Tradeoff is platform constraints and stateless patterns.

SaaS:

- Best when business capability is needed without platform building.

## Global infrastructure understanding

Understand these terms clearly:

- Region: geographic area for deployment.
- Zone: isolated location within a region.
- Multi-region pattern: improves resilience and proximity.

Exam-level takeaway:

- Multi-zone improves availability.
- Multi-region improves geographic resilience and latency optimization.

## Interacting with Google Cloud

Main interfaces:

- Console: GUI operations and visibility.
- Cloud Shell and SDK: command and script workflows.
- APIs: programmatic control.

Scenario logic:

- For automation and repeatability, prefer API or CLI workflows.
- For quick inspection and basic management, console is often enough.

## Compute platform differentiation

Compute Engine:

- VM-centric, most control, most responsibility.

GKE:

- Kubernetes orchestration for container platforms.

App Engine:

- Managed app deployment platform.

Cloud Run:

- Serverless container runtime for stateless services.

Cloud Run Functions:

- Event-driven function execution model.

## Advanced selection cues

Choose Compute Engine if:

- custom OS tuning required
- legacy software constraints exist
- low-level host control is mandatory

Choose Cloud Run if:

- HTTP-driven stateless service
- variable traffic pattern
- rapid delivery with minimal ops

Choose GKE if:

- multi-service container platform
- Kubernetes policy and orchestration needed

## Fast self-test

1. Why might a managed option be preferred over VM option in business exam scenarios?
2. What infrastructure concept improves resiliency first, multi-zone or multi-region?
3. What is the main practical difference between Cloud Run and Cloud Run Functions?
