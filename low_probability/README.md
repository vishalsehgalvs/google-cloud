# Low Probability Topics

Use this folder only after finishing the high-probability list.

These topics are still useful, but they are either too deep, too operational, or more specialized than what is usually emphasized on an entry-level Google Cloud exam.

## Lower Priority For Revision

### 1. Deep Kubernetes and GKE internals

- [../notes/19_kubernetes.md](../notes/19_kubernetes.md)  
  Helpful background, but more detail than most entry-level exams need.
- [../notes/139_kubernetes_intro.md](../notes/139_kubernetes_intro.md)  
  Good overview, but lower return than IAM or billing.
- [../notes/140_gke_overview.md](../notes/140_gke_overview.md)  
  Useful if you have time after core compute topics.
- [../notes/142_kubernetes_object_model_declarative_management.md](../notes/142_kubernetes_object_model_declarative_management.md)  
  Object model and control loops are deeper than needed for most beginner exams.
- [../notes/143_kubernetes_components_control_plane_nodes.md](../notes/143_kubernetes_components_control_plane_nodes.md)  
  Control plane internals are usually low yield.
- [../notes/144_gke_autopilot_vs_standard.md](../notes/144_gke_autopilot_vs_standard.md)  
  Good to know, but not core if time is tight.
- [../notes/145_kubernetes_object_management.md](../notes/145_kubernetes_object_management.md)  
  Operational detail.
- [../notes/146_kubernetes_operations_intro.md](../notes/146_kubernetes_operations_intro.md)  
  More useful for hands-on admin roles.
- [../notes/147_kubectl_configuration_and_usage.md](../notes/147_kubectl_configuration_and_usage.md)  
  CLI-heavy and lower priority for a business-level exam.
- [../notes/148_kubernetes_introspection_debugging.md](../notes/148_kubernetes_introspection_debugging.md)  
  Troubleshooting detail is lower yield.

### 2. Deep networking and hybrid connectivity detail

- [../notes/95_cloud_vpn.md](../notes/95_cloud_vpn.md)  
  Important conceptually, but operational specifics are usually secondary.
- [../notes/96_identity_aware_proxy.md](../notes/96_identity_aware_proxy.md)  
  Useful security service, but less central than IAM basics.
- [../notes/99_cloud_interconnect_peering_overview.md](../notes/99_cloud_interconnect_peering_overview.md)  
  Specialized connectivity options.
- [../notes/100_cloud_interconnect_dedicated_partner_crosscloud.md](../notes/100_cloud_interconnect_dedicated_partner_crosscloud.md)  
  Detailed comparison is usually low priority.
- [../notes/101_cloud_peering_direct_carrier.md](../notes/101_cloud_peering_direct_carrier.md)  
  Specialized networking detail.
- [../notes/102_choosing_hybrid_connectivity.md](../notes/102_choosing_hybrid_connectivity.md)  
  Useful only after basic networking is solid.
- [../notes/103_shared_vpc_and_vpc_peering.md](../notes/103_shared_vpc_and_vpc_peering.md)  
  Worth a skim, but not before IAM and billing.
- [../notes/104_hybrid_connectivity_module_summary.md](../notes/104_hybrid_connectivity_module_summary.md)  
  Good recap if extra time remains.

### 3. Advanced load balancing and autoscaling variants

- [../notes/105_load_balancing_autoscaling_intro.md](../notes/105_load_balancing_autoscaling_intro.md)  
  Overview is useful, but not top priority.
- [../notes/106_managed_instance_groups.md](../notes/106_managed_instance_groups.md)  
  More relevant for Associate Cloud Engineer than Cloud Digital Leader.
- [../notes/107_mig_autoscaling_health_checks.md](../notes/107_mig_autoscaling_health_checks.md)  
  Operational details are lower yield.
- [../notes/108_application_load_balancing.md](../notes/108_application_load_balancing.md)  
  Too detailed for first-pass exam prep.
- [../notes/109_alb_examples_cross_region_content_based.md](../notes/109_alb_examples_cross_region_content_based.md)  
  Scenario examples are useful later.
- [../notes/110_alb_https_backend_buckets_negs.md](../notes/110_alb_https_backend_buckets_negs.md)  
  NEG and backend detail is specialized.
- [../notes/111_cloud_cdn.md](../notes/111_cloud_cdn.md)  
  Good to know at a high level only.
- [../notes/112_network_load_balancing.md](../notes/112_network_load_balancing.md)  
  Layer 4 variants are lower priority.
- [../notes/113_internal_load_balancing.md](../notes/113_internal_load_balancing.md)  
  Internal LB detail is specialized.
- [../notes/115_choosing_load_balancer.md](../notes/115_choosing_load_balancer.md)  
  Read if you have extra time.
- [../notes/116_load_balancing_module_summary.md](../notes/116_load_balancing_module_summary.md)  
  Good recap, but not core.

### 4. Terraform and infrastructure automation detail

- [../notes/117_infrastructure_automation_intro.md](../notes/117_infrastructure_automation_intro.md)  
  Know the idea of IaC, but not every detail.
- [../notes/118_terraform.md](../notes/118_terraform.md)  
  Focus only on what Terraform is and when you would choose it.
- [../notes/119_cloud_marketplace.md](../notes/119_cloud_marketplace.md)  
  Useful but not central.

### 5. Labs, demos, and walkthrough-heavy notes

- Any file with names such as `lab`, `walkthrough`, or `demo` is lower priority for exam revision.
- These are good for practical understanding, but they are not the fastest path if your goal is exam coverage in limited time.

## How To Use This Folder

- Skim these topics only after you complete the high-probability list.
- For Terraform, GKE, and load balancing, remember the service purpose rather than memorizing commands or internal architecture.
- If your exam turns out to be Associate Cloud Engineer instead, some of these topics move up in priority.
