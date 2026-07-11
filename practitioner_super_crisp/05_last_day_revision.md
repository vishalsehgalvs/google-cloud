# Last Day Revision Checklist

Use this file as your final revision script.

## Must Recite Without Looking

- Cloud models and what you manage in each.
- Resource hierarchy order and IAM inheritance.
- Project as unit of IAM, APIs, quota, and billing.
- Compute service differences and selection cues.
- Storage and database selection by data shape.
- BigQuery, Dataflow, Dataproc differences.
- Monitoring, Logging, and alerting purpose.
- Budget, alerts, and quota roles.

## 45-Minute Final Drill

1. 10 min: read 01 and speak each section aloud.
2. 10 min: read 02 and rehearse service choices with one example each.
3. 10 min: read 03 and memorize IAM and cost-control traps.
4. 10 min: read 04 and solve mini patterns mentally.
5. 5 min: rapid recite from this checklist.

## 12 High-Yield Rapid Q and A

1. Need serverless stateless container API?
   Answer: Cloud Run.

2. Need event-triggered single function?
   Answer: Cloud Run Functions.

3. Need full VM and OS control?
   Answer: Compute Engine.

4. Need managed relational DB?
   Answer: Cloud SQL.

5. Need global relational at massive scale?
   Answer: Spanner.

6. Need document NoSQL app store?
   Answer: Firestore.

7. Need huge wide-column throughput?
   Answer: Bigtable.

8. Need SQL analytics warehouse?
   Answer: BigQuery.

9. Need batch and stream processing pipelines?
   Answer: Dataflow.

10. Need Spark or Hadoop clusters?
    Answer: Dataproc.

11. Need least-risk access model?
    Answer: IAM predefined roles, least privilege, groups for humans, service accounts for workloads.

12. Need spend control before budget overrun?
    Answer: Budget plus alerts plus quota.

## Exam Execution Strategy

- First pass: answer direct service-choice questions quickly.
- Second pass: handle long scenario questions with elimination method.
- Final pass: review marked questions only.

## Tie-Breaker Rule

If two answers are technically possible, select the one that is:

- more managed
- more secure by default
- easier to monitor
- easier to scale
- lower operational burden
