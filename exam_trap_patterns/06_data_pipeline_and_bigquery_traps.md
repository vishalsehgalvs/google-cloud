# Data Pipeline And BigQuery Traps

## Trap 1: BigQuery Data Transfer Service vs Cloud Function vs Dataflow vs Cloud Function + Dataflow

This is directly from your practice discussion and is one of the highest-value traps to internalize.

Scenario pattern: "data arrives hourly / slowly changing / minimize cost / fewest steps, load into BigQuery."

Ranking of answers from best to worst for this exact phrasing:

1. Best: BigQuery Data Transfer Service (scheduled transfer, no code, fully managed)
2. Weaker but plausible: standalone Cloud Function triggered on file upload, calling BigQuery load API directly
3. Worse: Cloud Function that pushes data to BigQuery through a Dataflow pipeline

Why the Data Transfer Service wins when the question says "hourly" and "fewest steps":

- Zero custom code — configure source bucket, destination table, and schedule. Google manages everything else.
- Meets timing easily since minimum scheduling interval is far below hourly.
- No separate compute cost for the transfer itself, since it is a managed scheduling mechanism.

Why Cloud Function + Dataflow is the worst option even though it "would work":

- It requires writing Cloud Function code AND building/deploying a full Apache Beam pipeline. That is significantly more setup.
- Dataflow spins up worker VMs even for simple hourly batch jobs, adding real compute cost on top of the function invocation. This directly contradicts "minimize cost."

Why a standalone Cloud Function (no Dataflow) is still not the best answer:

- Even without Dataflow, you still must write function code, deploy it, and manually handle errors/retries and schema/load configuration.
- A no-code managed service beats even simple custom code when the question says "fewest steps."
- Cost between a lightweight Cloud Function and the Data Transfer Service is roughly comparable, so implementation effort becomes the deciding factor.

One-line rule: "minimize cost + fewest steps + scheduled/batch (not real-time)" -> fully managed no-code service (BigQuery Data Transfer Service) beats any custom-code option, even a simple one.

## Trap 2: When Event-Driven (Cloud Function) Actually IS The Right Answer

Event-driven processing is the correct pattern when the question emphasizes:

- "react immediately to each file as it lands"
- "near real-time"
- "as soon as a file is uploaded"

The trigger name to recognize: `google.storage.object.finalize` — fires when an object is successfully created or overwritten in Cloud Storage. This is the same concept as `OBJECT_FINALIZE` in Pub/Sub bucket notifications.

One-line rule: "immediate per-file reaction" -> Cloud Function on `google.storage.object.finalize`. "Scheduled / hourly / batch / slowly changing" -> BigQuery Data Transfer Service.

## Trap 3: Dataflow vs Dataproc vs Data Transfer Service vs BigQuery

- need custom transform logic, streaming AND batch, complex pipeline -> Dataflow
- need to run existing Spark/Hadoop jobs -> Dataproc
- need scheduled simple data movement into BigQuery with no transform logic -> BigQuery Data Transfer Service
- need to just query/analyze already-loaded data with SQL -> BigQuery itself

One-line rule: if the question is about moving data on a schedule with no real transformation, do not default to Dataflow just because it is the "official" data movement tool. Check for a managed scheduling service first.

## Trap 4: Dataprep vs Dataflow

- "visual, no-code data cleaning and wrangling before analysis" -> Dataprep
- "programmatic, code-based transformation pipeline at scale" -> Dataflow

One-line rule: Dataprep is the UI-driven cleaning tool. Dataflow is the code-driven pipeline engine.

## Quick Self-Test

1. Data lands hourly, slowly changing, need lowest cost and fewest steps into BigQuery. Best answer?
2. Requirement changes to "must process each file the instant it arrives." Best answer now?
3. Existing Spark jobs need to run in the cloud with minimal rewrite. Best answer?
4. Need a no-code way to clean messy CSV data before loading. Best answer?
