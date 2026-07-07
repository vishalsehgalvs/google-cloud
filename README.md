# Google Cloud Notes

This repository contains concise, structured notes for Google Cloud Platform (GCP) concepts, organized by topic and course section.

## Notes Structure

- **01_cloud_computing_overview.md** — Cloud computing basics, service models, and Google's approach
- **02_resource_hierarchy.md** — GCP resource hierarchy: organization, folders, projects, resources
- **03_accessing_google_cloud.md** — Ways to access and interact with Google Cloud
- **04_virtual_private_cloud.md** — Virtual Private Cloud (VPC) networking concepts
- **05_compute_engine.md** — Compute Engine: Google Cloud's IaaS solution
- **06_vpc_features.md** — VPC compatibility features: routing, firewall, peering, shared VPC
- **07_cloud_load_balancing.md** — Cloud Load Balancing: types, features, and use cases
- **08_dns_cdn.md** — Cloud DNS and Cloud CDN: managed DNS, edge caching, content delivery
- **09_connectivity_options.md** — Connectivity options: VPN, peering, Interconnect, cross-cloud
- **10_storage_overview.md** — Overview of Google Cloud storage services and how to choose between them
- **11_cloud_storage.md** — Cloud Storage basics, buckets, objects, and common use cases
- **12_cloud_storage_classes.md** — Storage classes and when to use each one
- **13_cloud_sql.md** — Cloud SQL overview and managed relational database basics
- **14_spanner.md** — Spanner overview, strengths, and global relational scaling
- **15_firestore.md** — Firestore basics, document model, and app-focused use cases
- **16_bigtable.md** — Bigtable overview and high-scale NoSQL workloads
- **17_storage_comparison.md** — Quick comparison of major Google Cloud storage services
- **18_containers.md** — Containers explained in simple terms and how they differ from VMs
- **19_kubernetes.md** — Kubernetes basics: Pods, Deployments, Services, scaling, and rollouts
- **20_gke.md** — Google Kubernetes Engine (GKE), Autopilot vs Standard, and managed cluster features
- **21_cloud_run.md** — Cloud Run basics, serverless containers, deployment workflows, and pricing
- **22_cloud_run_functions.md** — Cloud Run Functions, event-driven workloads, and triggers
- **23_prompt_engineering_guide.md** — Generative AI, LLM basics, prompt types, and prompt engineering best practices
- **24_architecting_intro.md** — Overview of the Architecting with Google Compute Engine course series
- **25_getting_started_interacting_gcp.md** — Main ways to interact with Google Cloud, including Console, CLI, APIs, Marketplace, and Projects
- **26_cloud_storage_bucket_lab.md** — Lab walkthrough for creating buckets and using Cloud Shell persistence
- **27_jenkins_marketplace_lab.md** — Lab walkthrough for deploying and managing Jenkins from Marketplace
- **28_projects_and_billing.md** — Projects, billing relationships, and switching project context
- **29_virtual_networks_intro.md** — Introduction to virtual networking, VPC, regions, zones, and PoPs
- **30_vpc_objects_overview.md** — VPC building blocks: projects, networks, subnets, regions, zones, IPs, routes, firewall
- **31_projects_networks_and_subnets.md** — Deep dive into projects, network types (default/auto/custom), and subnet planning
- **32_custom_subnet_expansion_lab.md** — Lab walkthrough for expanding subnet IP ranges without downtime
- **33_ip_addresses_in_google_cloud.md** — Internal vs external IPs, ephemeral vs static, BYOIP, and pricing
- **34_vm_internal_external_ip_lab.md** — Lab demonstrating IP configuration during VM creation and stop/start behavior
- **35_dns_external_mapping_and_alias_ips.md** — Internal/external DNS, Cloud DNS, and alias IP ranges
- **36_routes_and_firewall_rules.md** — How packets flow through VPC, the virtual router, and firewall rule design
- **37_network_pricing.md** — Network pricing: ingress/egress, external IPs, load balancing, and how to reduce costs
- **38_vpc_network_lab_connectivity.md** — Lab walkthrough covering VPC creation, firewall rules, and connectivity between VMs
- **39_common_network_designs.md** — Common network design patterns: availability, security, global deployment, and Cloud NAT
- **40_private_vm_cloud_nat_lab.md** — Lab walkthrough for private VMs, Cloud IAP, Private Google Access, and Cloud NAT
- **41_compute_engine_vm_overview.md** — Compute Engine overview: IaaS model, TPUs, disk types, CPU/network throughput, and compute options
- **42_compute_engine_vm_creation_console.md** — Step-by-step VM creation walkthrough in the GCP Console: region, machine type, disk, networking, and CLI export
- **43_compute_engine_vm_access_and_lifecycle.md** — VM access (SSH/RDP), full lifecycle states, availability policies, and OS patch management
- **44_compute_engine_machine_families.md** — All four machine families: general-purpose, compute-optimized, memory-optimized, accelerator-optimized, and custom types
- **45_compute_engine_pricing.md** — Compute Engine pricing: billing model, sustained use discounts, committed use, preemptible vs Spot VMs, and rightsizing
- **46_compute_engine_special_vm_types.md** — Preemptible VMs, Spot VMs, sole-tenant nodes, shielded VMs, and confidential VMs
- **47_compute_engine_images.md** — Boot disk images: public vs custom, premium image billing, importing images, and machine images
- **48_compute_engine_disk_options.md** — Compute Engine disk options: persistent disk types, local SSDs, RAM disks, and how to choose
- **49_compute_engine_common_actions.md** — Common VM actions: instance metadata, startup/shutdown scripts, moving VMs, and snapshots
- **50_minecraft_server_lab.md** — Lab walkthrough for setting up a Minecraft server on Compute Engine with persistent disk
- **51_iam_intro.md** — IAM module introduction: what IAM is and why access control matters in GCP
- **52_iam_overview.md** — IAM overview: the who, what, and can-do model for controlling access to GCP resources
- **53_iam_organization_and_folders.md** — IAM organization node and folders: hierarchy-based access control and inheritance
- **54_iam_roles.md** — IAM roles: basic, predefined, and custom roles and how they grant permissions
- **55_iam_custom_role_demo.md** — Demo walkthrough for creating a custom IAM role in the GCP Console
- **56_iam_members_and_policies.md** — IAM members, policies, and identity types: users, groups, service accounts, and policy bindings
- **57_iam_service_accounts.md** — Service accounts: what they are, how they work, and best practices for use
- **58_iam_organization_restrictions.md** — Organization restrictions: limiting access to only approved GCP organizations
- **59_iam_best_practices.md** — IAM best practices: least privilege, resource hierarchy, service account hygiene, and auditing
- **60_iam_lab_access_control.md** — Lab overview for IAM access control: roles, bindings, and permission testing
- **61_iam_lab_walkthrough.md** — Step-by-step walkthrough of the IAM access control lab
- **62_iam_module_summary.md** — IAM module summary: key concepts, roles, service accounts, and best practices recap
- **63_storage_module_intro.md** — Storage and database module introduction: overview of services covered
- **64_cloud_storage_deep_dive.md** — Cloud Storage deep dive: key characteristics, object storage model, and data access
- **65_cloud_storage_features.md** — Cloud Storage features: versioning, lifecycle policies, retention, encryption, and data management
- **66_cloud_storage_class_selection.md** — Choosing a Cloud Storage class: decision tree, Autoclass, and cost trade-offs
- **67_filestore.md** — Filestore: managed NFS-based network file storage for GCP workloads
- **68_cloud_storage_lab_overview.md** — Cloud Storage lab overview: what the lab covers and goals
- **69_cloud_storage_lab_walkthrough.md** — Step-by-step walkthrough of the Cloud Storage lab
- **70_cloud_sql.md** — Cloud SQL deep dive: managed relational databases, features, replicas, and use cases
- **71_cloud_sql_lab_walkthrough.md** — Lab walkthrough for Cloud SQL: setup, connection, and basic operations
- **72_spanner.md** — Cloud Spanner deep dive: globally distributed relational database, scaling, and architecture
- **73_alloydb.md** — AlloyDB for PostgreSQL: high-performance managed Postgres with Google-built storage engine
- **74_firestore.md** — Firestore deep dive: document-based NoSQL database, data model, queries, and consistency
- **75_bigtable.md** — Bigtable deep dive: wide-column NoSQL for analytics and high-throughput workloads
- **76_memorystore.md** — Memorystore: fully managed in-memory data store for Redis and Memcached
- **77_storage_database_module_summary.md** — Storage and database module summary: comparison and service selection recap
- **78_resource_management_intro.md** — Resource management module introduction: what the module covers
- **79_resource_manager_overview.md** — Resource Manager overview: managing GCP resources through the hierarchy
- **80_quotas.md** — Quotas in Google Cloud: rate quotas, allocation quotas, and how to request increases
- **81_labels.md** — Labels in Google Cloud: key-value metadata for organizing and filtering resources
- **82_billing_and_cost_management.md** — Billing, budgets, and cost management: budgets, alerts, exports, and cost controls
- **83_billing_admin_demo.md** — Billing administration demo: exploring the billing console, reports, and cost tools
- **84_bigquery_billing_lab_walkthrough.md** — Lab walkthrough for analyzing billing data with BigQuery
- **85_observability_overview.md** — Google Cloud Observability overview: monitoring, logging, tracing, and profiling tools
- **86_cloud_monitoring.md** — Cloud Monitoring: metrics, dashboards, alerting policies, and uptime checks
- **87_cloud_monitoring_lab_walkthrough.md** — Lab walkthrough for Cloud Monitoring: setting up dashboards and alerts
- **88_cloud_logging.md** — Cloud Logging: log collection, log buckets, log sinks, and log-based metrics
- **89_error_reporting.md** — Error Reporting: automatic error grouping, alerting, and stack trace analysis
- **90_cloud_trace.md** — Cloud Trace: distributed tracing for latency analysis across services
- **91_cloud_profiler.md** — Cloud Profiler: continuous CPU and memory profiling for production applications
- **92_observability_integrations.md** — Cloud Observability third-party integrations: partner ecosystem and OpenTelemetry support
- **93_observability_module_summary.md** — Observability module summary: recap of all monitoring and logging services
- **94_course_series_intro.md** — Architecting with Google Compute Engine course series introduction
- **95_cloud_vpn.md** — Cloud VPN: IPsec tunnels, HA VPN, Classic VPN, and when to use VPN
- **96_identity_aware_proxy.md** — Identity-Aware Proxy (IAP): zero-trust access control for applications and VMs
- **97_private_gke_cluster_iam_lab.md** — Lab walkthrough for deploying a private GKE cluster with a custom IAM role and jumphost access
- **98_ha_vpn_lab.md** — Lab overview for building HA VPN between two VPCs to simulate GCP-to-on-premises connectivity
- **99_cloud_interconnect_peering_overview.md** — Overview of Cloud Interconnect and Peering services: dedicated vs shared, Layer 2 vs Layer 3
- **100_cloud_interconnect_dedicated_partner_crosscloud.md** — Dedicated Interconnect, Partner Interconnect, and Cross-Cloud Interconnect: details and comparison
- **101_cloud_peering_direct_carrier.md** — Direct Peering and Carrier Peering: public IP access to Google services without an SLA
- **102_choosing_hybrid_connectivity.md** — Decision guide for choosing the right hybrid connectivity option
- **103_shared_vpc_and_vpc_peering.md** — Shared VPC and VPC Network Peering: cross-project and cross-org network sharing
- **104_hybrid_connectivity_module_summary.md** — Hybrid connectivity module summary: all five connection services and VPC sharing recap
- **105_load_balancing_autoscaling_intro.md** — Load Balancing and Autoscaling module intro: ALB vs NLB, anycast IP, and module overview
- **106_managed_instance_groups.md** — Managed Instance Groups: instance templates, autoscaling, auto-healing, and regional vs zonal MIGs
- **107_mig_autoscaling_health_checks.md** — MIG autoscaling policies, health check configuration, and stateful IP addresses
- **108_application_load_balancing.md** — Application Load Balancing: Layer 7 architecture, backend services, session affinity, and balancing modes
- **109_alb_examples_cross_region_content_based.md** — ALB examples: cross-region load balancing and content-based routing
- **110_alb_https_backend_buckets_negs.md** — ALB with HTTPS, backend buckets, and Network Endpoint Groups (NEGs)
- **111_cloud_cdn.md** — Cloud CDN: edge caching, cache modes, cache keys, and invalidation
- **112_network_load_balancing.md** — Network Load Balancing: Layer 4 passthrough, backend service NLB, and proxy NLB
- **113_internal_load_balancing.md** — Internal Load Balancing: internal ALB and internal passthrough NLB
- **114_internal_load_balancer_lab.md** — Lab walkthrough for configuring an internal load balancer
- **115_choosing_load_balancer.md** — Decision guide for choosing the right load balancer
- **116_load_balancing_module_summary.md** — Load balancing module summary
- **117_infrastructure_automation_intro.md** — Infrastructure automation module intro: Terraform and Cloud Marketplace
- **118_terraform.md** — Terraform on Google Cloud: IaC, providers, resources, state, and modules
- **119_cloud_marketplace.md** — Cloud Marketplace: deploying third-party solutions quickly
- **120_managed_services_intro.md** — Managed services module intro: BigQuery, Dataflow, Dataprep, Dataproc
- **121_bigquery.md** — BigQuery: fully managed data warehouse, serverless analytics, and key features
- **122_dataflow.md** — Dataflow: managed Apache Beam pipelines for stream and batch processing
- **123_dataprep.md** — Dataprep: visual data wrangling and intelligent transformation suggestions
- **124_dataproc.md** — Dataproc: managed Spark and Hadoop clusters on Google Cloud
- **125_dataproc_lab_walkthrough.md** — Lab walkthrough for running a Spark job on Dataproc
- **126_managed_services_module_summary.md** — Managed services module summary
- **127_gemini_enterprise_demo.md** — Gemini for Google Cloud demo: Duet AI and enterprise AI assistant features
- **128_gke_course_intro.md** — GKE course introduction: architecture, workload management, and course overview
- **129_gke_course_cloud_intro.md** — Cloud fundamentals recap for the GKE course
- **130_reliable_cloud_infra_course_intro.md** — Reliable Cloud Infrastructure course introduction
- **131_cloud_computing_overview_gke_course.md** — Cloud computing overview as covered in the GKE course
- **132_compute_services_overview.md** — Google Cloud compute services overview: Compute Engine, GKE, App Engine, Cloud Run, Cloud Run Functions
- **133_google_cloud_network_and_infrastructure.md** — Google Cloud network and infrastructure overview
- **134_resource_hierarchy_projects_iam.md** — Resource hierarchy, projects, and IAM recap for the GKE course
- **135_billing_and_cost_controls.md** — Billing and cost controls: budgets, alerts, quotas, and cost optimization
- **136_interacting_with_google_cloud.md** — Four ways to interact with Google Cloud: Console, SDK/Cloud Shell, APIs, and Mobile App
- **137_container_images_and_cloud_build.md** — Container images, Dockerfile layers, multi-stage builds, Artifact Registry, and Cloud Build
- **138_what_is_a_container.md** — What a container is: evolution from physical servers to VMs to containers, user space isolation, and developer benefits
- **139_kubernetes_intro.md** — Kubernetes introduction: what it is, cluster architecture, declarative vs imperative config, and key features
- **140_gke_overview.md** — GKE overview: fully managed Kubernetes, Autopilot mode, auto-upgrade, node auto-repair, and integrations
- **141_gke_kubernetes_concepts_module_intro.md** — GKE Kubernetes concepts module intro: topics covered in the module
- **142_kubernetes_object_model_declarative_management.md** — Kubernetes object model, declarative management, Pods, and the watch loop
- **143_kubernetes_components_control_plane_nodes.md** — Kubernetes control plane components (kube-APIserver, etcd, kube-scheduler, kube-controller-manager) and node components (kubelet, containerd, kube-proxy)

Each file is self-contained and designed for quick reference.

The notes currently span:

- Core Google Cloud concepts
- Resource hierarchy and project organization
- Compute and storage services
- Containers, Kubernetes, GKE, and Cloud Run
- Prompt engineering and Gemini-related fundamentals
- Hands-on lab walkthroughs
- Virtual networking foundations and deep dives
- Network design: VPC, subnets, IPs, DNS, routes, firewall, pricing
- Compute Engine: VM overview, console creation, lifecycle, machine families, pricing, disk options, and common actions
- IAM: overview, roles, service accounts, policies, best practices, and labs
- Storage and databases: Cloud Storage, Filestore, Cloud SQL, Spanner, AlloyDB, Firestore, Bigtable, Memorystore
- Resource management: Resource Manager, quotas, labels, billing, and cost management
- Google Cloud Observability: monitoring, logging, error reporting, tracing, and profiling
- Hybrid connectivity: Cloud VPN, Identity-Aware Proxy, Dedicated/Partner/Cross-Cloud Interconnect, Direct/Carrier Peering, and connectivity decision guide
- VPC sharing: Shared VPC and VPC Network Peering
- Load balancing and autoscaling: Managed Instance Groups, Application Load Balancing, Network Load Balancing, Internal Load Balancing, Cloud CDN
- Infrastructure automation: Terraform and Cloud Marketplace
- Managed data services: BigQuery, Dataflow, Dataprep, Dataproc
- GKE course: containers, Kubernetes architecture, GKE overview, object model, control plane components

---

## Usage

Browse the `notes/` directory for topic-based markdown files. Each note is formatted for clarity and easy review.

For exam prep, use these curated folders first:

- `high_probability/` - primary revision list for the most likely topics
- `low_probability/` - secondary topics to skim after core coverage

---
