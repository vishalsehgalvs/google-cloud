# MIG Autoscaling and Health Checks

## Autoscaling

Automatically adds or removes instances based on load — handles traffic spikes and reduces cost during low demand.

### How It Works

1. Define an **autoscaling policy**
2. The autoscaler measures load and scales accordingly

### Autoscaling Policy Types

| Policy                  | Description                                         |
| ----------------------- | --------------------------------------------------- |
| CPU utilization         | Scale to keep CPU below a target percentage         |
| Load balancing capacity | Scale based on load balancer utilization            |
| Monitoring metrics      | Scale based on any Cloud Monitoring metric          |
| Queue-based workload    | Scale based on queue depth (e.g., Pub/Sub)          |
| Schedule                | Scale based on start time, duration, and recurrence |

### Example — CPU-Based Autoscaling

- 2 instances at 100% and 85% CPU; target is 75%
- Autoscaler adds a third instance to spread load and stay below 75%
- If overall load drops well below target, autoscaler removes instances

### Monitoring Utilization

- Click on an instance group or individual VM to view metrics (CPU, disk, network)
- Default view: CPU utilization over the past hour; time frame and metric are configurable
- Can set up **alerts** via Cloud Monitoring with multiple notification channels

---

## Health Checks

Defines how Google Cloud determines whether an instance is healthy and should receive traffic.

### Configuration Parameters

| Parameter           | Description                                      |
| ------------------- | ------------------------------------------------ |
| Protocol            | e.g., HTTP, HTTPS, TCP                           |
| Port                | Port to check                                    |
| Check interval      | How often to check                               |
| Timeout             | How long to wait for a response                  |
| Healthy threshold   | Number of consecutive successes to mark healthy  |
| Unhealthy threshold | Number of consecutive failures to mark unhealthy |

> Example: unhealthy threshold of 2 with a 15-second window means the health check must fail twice over 15 seconds before the instance is considered unhealthy.

---

## Stateful IP Addresses

Preserves an instance's IP address across **autohealing, updates, and recreation events**.

- Both **internal and external IPv4 addresses** can be preserved
- IPs can be auto-assigned or manually assigned per instance

### When to Use Stateful IPs

- Application requires a static IP after initial assignment
- Application config depends on specific IP addresses
- Other services or users access a server via a dedicated static IP
- Migrating existing workloads without changing network config

### Configuring Stateful IPs on an Existing MIG

- Configure IPs as stateful for **all existing and future instances** — promotes ephemeral IPs to static
- Update existing stateful IP configuration at any time

## ACE Exam-Style Practice Questions

### Q1
A Mig Autoscaling Health Checks alert says new instances fail to create and desired capacity is not maintained. What should you check first?

A. Validate template configuration and resolve persistent disk name collisions; ensure autoDelete is set correctly
B. Disable health checks
C. Delete VPC routes
D. Recreate billing account

Answer: A
Trap: Template and disk naming collisions are frequent MIG creation failure causes.

### Q2
In a Mig Autoscaling Health Checks issue, CPU is at 100% and MIG already reached max replicas. What is the fastest mitigation?

A. Change metric to memory immediately
B. Increase autoscaler upper limit while investigating application bottleneck
C. Restart all VMs manually
D. Disable autoscaling

Answer: B
Trap: If ceiling is reached, immediate capacity headroom is the quickest stabilization action.
