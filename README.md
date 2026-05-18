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
- **41_compute_engine_vm_overview.md** — Compute Engine VM fundamentals: IaaS model, TPUs, disk/CPU/network options, and console walkthrough

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
- Compute Engine: VM types, disks, TPUs, and console configuration

---

## Usage

Browse the `notes/` directory for topic-based markdown files. Each note is formatted for clarity and easy review.

---
