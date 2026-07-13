# Compute And MIG Traps

## Trap 1: MIG Update Type — Opportunistic vs Proactive

This is one of the most commonly missed traps because both options "update the instances eventually."

- "automated + minimal resources / gradual / doesn't need to happen immediately" -> Opportunistic
- "immediate + fast rollout / force replace now" -> Proactive

Why Opportunistic wins when the question says "minimal resources":

- Opportunistic only updates instances when they naturally recreate anyway (autoscale event, health check failure, manual recreation). Google does not force replacement, so no extra compute is spun up just for the update.
- Proactive actively and immediately replaces running instances according to your rolling update settings (max surge, max unavailable). This uses more resources right now because it is actively creating/replacing instances.

Why the distractors fail:

- "Set max surge to 5" does not specify update type at all, and a higher max surge actually creates more instances simultaneously, which is the opposite of minimal resources.
- "Manually abandon and recreate instances" is manual and resource-heavy, contradicting both "automated" and "minimal resources."

One-line rule: "automated + minimal/low resource usage" -> Opportunistic. "Immediate/fast rollout" -> Proactive.

## Trap 2: Regional vs Zonal MIG

- "protect against zone failure / spread across zones" -> Regional MIG (recommended default for production)
- "simple, single-zone, no redundancy required" -> Zonal MIG

One-line rule: default answer for production reliability questions is Regional MIG unless the question explicitly restricts to one zone.

## Trap 3: Stateful IPs

- "preserve static IP across autohealing/updates/recreation" -> configure Stateful IPs on the MIG
- Applies to both internal and external IPv4 addresses.

One-line rule: if the question mentions "IP must stay the same after instance is recreated," think Stateful IPs, not just static IP reservation alone.

## Trap 4: Compute Engine vs GKE vs Cloud Run vs Cloud Run Functions vs App Engine

- full VM/OS control needed, custom software stack, lift-and-shift -> Compute Engine
- many containerized microservices needing orchestration -> GKE
- stateless HTTP container service, scale to zero, minimal ops -> Cloud Run
- single-purpose function triggered by an event -> Cloud Run Functions
- want to just deploy code without managing infra, simpler than containers -> App Engine

One-line rule: if the question emphasizes "no infrastructure management" and "event-driven" or "HTTP request," it is almost never Compute Engine.

## Trap 5: Health Checks vs Autoscaling vs Auto-healing

These three sound similar but do different jobs:

- Health check: determines if an instance is healthy enough to receive traffic
- Auto-healing: recreates an instance that crashed, was deleted, or fails health checks
- Autoscaling: adds/removes instances based on load (CPU, LB capacity, custom metric, queue depth, schedule)

One-line rule: "keep app running after a crash" -> auto-healing. "Handle more/less traffic" -> autoscaling. "Decide who receives traffic" -> health check.

## Quick Self-Test

1. Requirement says "automated" and "minimal resources" for MIG updates. Update type?
2. Requirement says "protect against a single zone outage." MIG type?
3. Requirement says "IP address must not change after instance recreation." Feature?
4. Requirement says "run containers, orchestrate many services." Compute choice?
5. Requirement says "scale to zero, pay only when running, stateless HTTP." Compute choice?
