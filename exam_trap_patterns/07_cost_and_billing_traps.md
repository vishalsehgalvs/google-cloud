# Cost And Billing Traps

## Trap 1: "Minimize Cost" Almost Always Means "Fewer Manual/Custom Steps"

Across many question types (data pipelines, compute choices, storage classes), "minimize cost" is often paired with "fewest steps" or "least effort." The trap is picking a technically cheaper-sounding option that actually requires more custom infrastructure (which costs more in practice).

Rule: when you see "minimize cost AND fewest steps," favor the fully managed, no-code, scheduled/serverless option over any answer involving deploying custom pipelines (like Dataflow) or writing custom retry/error-handling logic.

## Trap 2: Network Service Tier Cost

- Standard Tier: cheaper, routes over public internet within region, ideal when all traffic stays in one region.
- Premium Tier: costs more, routes over Google's global backbone, ideal for multi-region/global low-latency needs.

Rule: single-region workload + cost sensitivity -> Standard Tier is the cost-minimizing answer, not Premium.

## Trap 3: Egress Cost Assumptions

- Ingress is free, egress is usually charged.
- Same-zone traffic via internal IP is free; same-zone traffic via external IP is charged (treated like inter-zone).
- Traffic to Google products (YouTube, Maps, Gmail, Drive) is free.
- Traffic to another Google Cloud service in the same region is free.

Rule: the cheapest architecture always keeps traffic on internal IPs within the same zone/region wherever possible.

## Trap 4: Static External IP Costs

- An unused (idle) static IP costs more than one actively in use.
- Ephemeral IPs are billed while in use, similar to static IPs.

Rule: if a question mentions "reduce unnecessary cost," releasing unused static IPs is a valid answer component.

## Trap 5: Sustained Use / Committed Use / Preemptible / Spot Discounts

- Predictable, always-on workloads for 1-3 years -> Committed Use Discounts (deepest discount, requires commitment)
- Steady month-long usage without upfront commitment -> Sustained Use Discounts (automatic)
- Fault-tolerant, interruptible batch workloads -> Preemptible VMs / Spot VMs (cheapest, can be reclaimed anytime)

Rule: "workload can tolerate interruption" is the signal for Preemptible/Spot. "Long-term guaranteed usage" is the signal for Committed Use.

## Trap 6: Budgets vs Quotas — Which One Actually Stops Spend

- Budgets and alerts only notify; they do not automatically stop resource usage by default.
- Quotas actually cap the number/rate of resources you can consume.

Rule: if the question specifically requires preventing usage beyond a limit (not just visibility), the answer is quotas, not just a budget alert.

## Trap 7: Rate Quota vs Allocation Quota

- Rate quota: resets after a time window (e.g., API calls per 100 seconds).
- Allocation quota: caps total number of resources you can have (e.g., max VPC networks per project).

Rule: "per time period" language -> rate quota. "Maximum number you can have" language -> allocation quota.

## Quick Self-Test

1. Question emphasizes "prevent going over budget automatically, not just get notified." Best control?
2. Workload can be interrupted anytime and just needs to be cheap. VM type?
3. All traffic stays in us-central1, need lowest network cost. Tier?
4. Question says "X calls per 100 seconds." Quota type?
