# High Probability Topics

Use this folder as the primary exam revision list.

These topics are the most likely to matter for an entry-level Google Cloud exam because they cover service selection, IAM, billing, core infrastructure, and operations.

## Focus First

### 1. Cloud basics and Google Cloud value

- [../notes/01_cloud_computing_overview.md](../notes/01_cloud_computing_overview.md)  
  Cloud concepts, service models, global infrastructure, security model, and why organizations adopt cloud.
- [../notes/132_compute_services_overview.md](../notes/132_compute_services_overview.md)  
  High-level comparison of Compute Engine, GKE, App Engine, Cloud Run, and Cloud Run Functions.
- [../notes/136_interacting_with_google_cloud.md](../notes/136_interacting_with_google_cloud.md)  
  Console, Cloud Shell, SDK, APIs, and when to use each.

### 2. Resource hierarchy, projects, billing, and IAM

- [../notes/02_resource_hierarchy.md](../notes/02_resource_hierarchy.md)  
  Organization, folders, projects, and how resources are structured.
- [../notes/28_projects_and_billing.md](../notes/28_projects_and_billing.md)  
  Projects as the core unit for isolation, billing, and administration.
- [../notes/79_resource_manager_overview.md](../notes/79_resource_manager_overview.md)  
  Policy inheritance, project identifiers, and billing flow.
- [../notes/51_iam_intro.md](../notes/51_iam_intro.md)  
  Intro to access control in Google Cloud.
- [../notes/52_iam_overview.md](../notes/52_iam_overview.md)  
  Who, what, and can-do model.
- [../notes/54_iam_roles.md](../notes/54_iam_roles.md)  
  Basic, predefined, and custom roles.
- [../notes/56_iam_members_and_policies.md](../notes/56_iam_members_and_policies.md)  
  Members, bindings, and IAM policy structure.
- [../notes/57_iam_service_accounts.md](../notes/57_iam_service_accounts.md)  
  Service accounts and machine identity.
- [../notes/59_iam_best_practices.md](../notes/59_iam_best_practices.md)  
  Least privilege and access hygiene.
- [../notes/62_iam_module_summary.md](../notes/62_iam_module_summary.md)  
  Fast recap of the IAM section.
- [../notes/82_billing_and_cost_management.md](../notes/82_billing_and_cost_management.md)  
  Budgets, alerts, reports, and cost control.
- [../notes/135_billing_and_cost_controls.md](../notes/135_billing_and_cost_controls.md)  
  Quotas, budgeting, and billing rules in concise form.

### 3. Core compute, storage, and database selection

- [../notes/05_compute_engine.md](../notes/05_compute_engine.md)  
  Compute Engine basics and common VM use cases.
- [../notes/10_storage_overview.md](../notes/10_storage_overview.md)  
  Storage service categories and decision framing.
- [../notes/11_cloud_storage.md](../notes/11_cloud_storage.md)  
  Object storage basics and bucket concepts.
- [../notes/12_cloud_storage_classes.md](../notes/12_cloud_storage_classes.md)  
  Standard, Nearline, Coldline, and Archive trade-offs.
- [../notes/13_cloud_sql.md](../notes/13_cloud_sql.md)  
  Managed relational database basics.
- [../notes/14_spanner.md](../notes/14_spanner.md)  
  Global relational database positioning.
- [../notes/15_firestore.md](../notes/15_firestore.md)  
  Document database use cases.
- [../notes/16_bigtable.md](../notes/16_bigtable.md)  
  Wide-column NoSQL use cases.
- [../notes/17_storage_comparison.md](../notes/17_storage_comparison.md)  
  Direct comparison across storage choices.
- [../notes/77_storage_database_module_summary.md](../notes/77_storage_database_module_summary.md)  
  Best quick decision guide across storage and database services.

### 4. Containers and modern application platforms

- [../notes/18_containers.md](../notes/18_containers.md)  
  Containers versus VMs.
- [../notes/20_gke.md](../notes/20_gke.md)  
  GKE at a high level and when it fits.
- [../notes/21_cloud_run.md](../notes/21_cloud_run.md)  
  Serverless containers for stateless apps.
- [../notes/22_cloud_run_functions.md](../notes/22_cloud_run_functions.md)  
  Event-driven functions and lightweight automation.

### 5. Networking fundamentals

- [../notes/04_virtual_private_cloud.md](../notes/04_virtual_private_cloud.md)  
  VPC basics.
- [../notes/06_vpc_features.md](../notes/06_vpc_features.md)  
  Routing, firewalls, peering, and shared VPC basics.
- [../notes/07_cloud_load_balancing.md](../notes/07_cloud_load_balancing.md)  
  Main load balancing concepts.
- [../notes/08_dns_cdn.md](../notes/08_dns_cdn.md)  
  DNS and CDN fundamentals.
- [../notes/09_connectivity_options.md](../notes/09_connectivity_options.md)  
  VPN, peering, and interconnect overview.
- [../notes/29_virtual_networks_intro.md](../notes/29_virtual_networks_intro.md)  
  Regions, zones, subnets, and network building blocks.
- [../notes/30_vpc_objects_overview.md](../notes/30_vpc_objects_overview.md)  
  Core VPC objects.
- [../notes/36_routes_and_firewall_rules.md](../notes/36_routes_and_firewall_rules.md)  
  Packet flow, routes, and firewall basics.

### 6. Operations, monitoring, and reliability

- [../notes/85_observability_overview.md](../notes/85_observability_overview.md)  
  Monitoring, logging, tracing, and profiling overview.
- [../notes/86_cloud_monitoring.md](../notes/86_cloud_monitoring.md)  
  Metrics, dashboards, and alerts.
- [../notes/88_cloud_logging.md](../notes/88_cloud_logging.md)  
  Centralized logs and exports.
- [../notes/93_observability_module_summary.md](../notes/93_observability_module_summary.md)  
  Fast recap of cloud operations services.

### 7. Data and AI at a business level

- [../notes/121_bigquery.md](../notes/121_bigquery.md)  
  Serverless analytics and data warehouse positioning.
- [../notes/122_dataflow.md](../notes/122_dataflow.md)  
  Stream and batch processing overview.
- [../notes/123_dataprep.md](../notes/123_dataprep.md)  
  Data preparation at a high level.
- [../notes/124_dataproc.md](../notes/124_dataproc.md)  
  Managed Spark and Hadoop workloads.
- [../notes/126_managed_services_module_summary.md](../notes/126_managed_services_module_summary.md)  
  Managed services and serverless framing.
- [../notes/127_gemini_enterprise_demo.md](../notes/127_gemini_enterprise_demo.md)  
  Gemini for Google Cloud business-oriented overview.

## What To Remember

- Know how to choose the right service for a business scenario.
- Know projects, IAM, billing, and quotas clearly.
- Know the difference between IaaS, PaaS, serverless, and SaaS.
- Know the basic differences between Compute Engine, GKE, Cloud Run, and Cloud Run Functions.
- Know storage and database service selection by use case.
- Know the purpose of Monitoring, Logging, budgets, and alerts.
