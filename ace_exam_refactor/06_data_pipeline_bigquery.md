# Domain 6 - Data Pipelines, BigQuery, Managed Analytics

## Service Choice Core

- BigQuery: serverless SQL analytics
- Dataflow: managed batch and streaming transforms
- Dataproc: managed Spark and Hadoop with minimal rewrite
- Dataprep: visual data preparation
- Pub/Sub: event ingestion and decoupling
- BigQuery Data Transfer Service: scheduled managed data ingestion

## Decision Signals

- "hourly scheduled load with fewest steps" -> BigQuery Data Transfer Service
- "streaming transform at scale" -> Pub/Sub + Dataflow + BigQuery
- "existing Spark jobs" -> Dataproc
- "need SQL analytics" -> BigQuery
- "cost estimate before query" -> bq dry run

## Pinpoint Traps

- Topic without subscription does not deliver Pub/Sub messages.
- Cloud Functions can work but are often not best for high-throughput ETL.
- Dataflow is not the cheapest answer for simple scheduled file loads.
- BigQuery cost is tied to bytes processed, not rows returned.

## Scenario Example 1

- Trigger words: streaming IoT events, transform, near real-time dashboard
- Best answer: Pub/Sub to Dataflow to BigQuery
- Why not Cloud SQL: wrong analytics shape and scale
- Why not manual batch jobs: latency and operations mismatch

```bash
gcloud pubsub topics create sensor-events

gcloud pubsub subscriptions create sensor-events-sub \
  --topic=sensor-events

gcloud dataflow jobs run sensor-stream-job \
  --gcs-location=gs://dataflow-templates-us-central1/latest/PubSub_to_BigQuery \
  --region=us-central1 \
  --staging-location=gs://PROJECT_ID-temp/staging \
  --parameters=inputTopic=projects/PROJECT_ID/topics/sensor-events,outputTableSpec=PROJECT_ID:analytics.sensor_events
```

## Scenario Example 2

- Trigger words: existing Spark ETL, fast migration, minimal code rewrite
- Best answer: Dataproc
- Why not full replatform first: violates minimal-change requirement
- Why not BigQuery only: cannot run existing Spark code directly

```bash
gcloud dataproc clusters create etl-temp \
  --region=us-central1 \
  --single-node

gcloud dataproc jobs submit spark \
  --cluster=etl-temp \
  --region=us-central1 \
  --jars=gs://code-bucket/jobs/etl.jar \
  --class=com.example.EtlMain
```

## Scenario Example 3

- Trigger words: repeated analytical query costs are high
- Best answer: partition and cluster tables, dry-run to estimate cost
- Why not only bigger slots: does not fix bad table design
- Why not filtering after scan: still pays for scanned bytes

```bash
bq query --use_legacy_sql=false --dry_run \
"SELECT * FROM analytics.events WHERE event_date >= '2026-07-01'"
```

## BigQuery Cost Checklist

- Partition by date or timestamp
- Cluster by common filter columns
- Use dry-run before expensive queries
- Avoid SELECT \* in large tables

## One-Line Rules

- Scheduled ingest with minimal work usually means managed transfer.
- Streaming plus transform usually means Dataflow.
- Existing Spark workloads usually stay Spark on Dataproc first.
