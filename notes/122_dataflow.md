# Dataflow

## What Is Dataflow?

- A **fully managed service** for transforming and enriching data in **stream and batch modes** with equal reliability and expressiveness
- Handles infrastructure setup and maintenance for you
- Built on Google Cloud infrastructure — **autoscales** to meet pipeline demands, scaling to millions of queries per second

---

## Key Features

- **Unified stream and batch processing** — the same pipeline code handles both modes
- **Autoscaling** — intelligently scales up or down based on data volume
- **Fast pipeline development** — uses expressive SQL, Java, and Python APIs via the **Apache Beam SDK**
- **Rich primitives** — windowing and session analysis built in
- **Ecosystem of connectors** — source and sink connectors for many systems
- **Integrated observability** — tightly coupled with Google Cloud Observability; set up priority alerts and notifications to monitor pipeline health and data quality

---

## Apache Beam SDK

- Dataflow pipelines are written using the **Apache Beam SDK**
- Supports: **SQL**, **Java**, **Python**
- Provides windowing, session analysis, and a wide range of source/sink connectors

---

## Data Sources (Input)

| Source Type               | Examples                                          |
| ------------------------- | ------------------------------------------------- |
| Google Cloud services     | **Pub/Sub** (messaging/publishing), **Datastore** |
| Third-party / open source | **Apache Avro**, **Apache Kafka**                 |

---

## Data Destinations (Output / Analysis)

| Destination       | Use Case                                     |
| ----------------- | -------------------------------------------- |
| **BigQuery**      | Large-scale SQL analytics                    |
| **Vertex AI**     | Machine learning and AI workloads            |
| **Bigtable**      | High-throughput NoSQL storage                |
| **Looker Studio** | Real-time dashboards (e.g., for IoT devices) |

---

## Typical Use Cases

- Real-time stream processing (e.g., IoT sensor data, clickstreams)
- Batch ETL (extract, transform, load) pipelines
- Data enrichment and quality monitoring
- Building real-time dashboards from live data streams
