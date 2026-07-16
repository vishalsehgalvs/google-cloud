param(
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'

$root = Join-Path $PSScriptRoot 'study_focus_by_scorecard'
if ($Clean -and (Test-Path $root)) {
    Remove-Item -Path $root -Recurse -Force
}
if (-not (Test-Path $root)) {
    New-Item -ItemType Directory -Path $root | Out-Null
}

$groups = @(
    [PSCustomObject]@{
        Name = '01_section2_planning_and_implementation_does_not_meet'
        Priority = 'Highest'
        Description = 'Start here first. This section was 30 percent of the exam and your scorecard says Does Not Meet.'
        Files = @(
            'notes/04_virtual_private_cloud.md',
            'notes/05_compute_engine.md',
            'notes/06_vpc_features.md',
            'notes/07_cloud_load_balancing.md',
            'notes/08_dns_cdn.md',
            'notes/09_connectivity_options.md',
            'notes/10_storage_overview.md',
            'notes/11_cloud_storage.md',
            'notes/12_cloud_storage_classes.md',
            'notes/13_cloud_sql.md',
            'notes/14_spanner.md',
            'notes/15_firestore.md',
            'notes/16_bigtable.md',
            'notes/18_containers.md',
            'notes/19_kubernetes.md',
            'notes/20_gke.md',
            'notes/21_cloud_run.md',
            'notes/22_cloud_run_functions.md',
            'notes/29_virtual_networks_intro.md',
            'notes/30_vpc_objects_overview.md',
            'notes/31_projects_networks_and_subnets.md',
            'notes/33_ip_addresses_in_google_cloud.md',
            'notes/36_routes_and_firewall_rules.md',
            'notes/39_common_network_designs.md',
            'notes/40_private_vm_cloud_nat_lab.md',
            'notes/41_compute_engine_vm_overview.md',
            'notes/42_compute_engine_vm_creation_console.md',
            'notes/44_compute_engine_machine_families.md',
            'notes/46_compute_engine_special_vm_types.md',
            'notes/47_compute_engine_images.md',
            'notes/48_compute_engine_disk_options.md',
            'notes/49_compute_engine_common_actions.md',
            'notes/64_cloud_storage_deep_dive.md',
            'notes/65_cloud_storage_features.md',
            'notes/66_cloud_storage_class_selection.md',
            'notes/70_cloud_sql.md',
            'notes/72_spanner.md',
            'notes/73_alloydb.md',
            'notes/74_firestore.md',
            'notes/75_bigtable.md',
            'notes/95_cloud_vpn.md',
            'notes/99_cloud_interconnect_peering_overview.md',
            'notes/100_cloud_interconnect_dedicated_partner_crosscloud.md',
            'notes/102_choosing_hybrid_connectivity.md',
            'notes/103_shared_vpc_and_vpc_peering.md',
            'notes/106_managed_instance_groups.md',
            'notes/107_mig_autoscaling_health_checks.md',
            'notes/108_application_load_balancing.md',
            'notes/109_alb_examples_cross_region_content_based.md',
            'notes/110_alb_https_backend_buckets_negs.md',
            'notes/111_cloud_cdn.md',
            'notes/112_network_load_balancing.md',
            'notes/113_internal_load_balancing.md',
            'notes/115_choosing_load_balancer.md',
            'ace_exam_refactor/03_networking_hybrid_lb.md',
            'ace_exam_refactor/04_compute_gke_serverless.md',
            'ace_exam_refactor/05_storage_databases.md',
            'ace_exam_refactor/09_real_world_scenarios.md',
            'ace_exam_refactor/10_command_playbook.md'
        )
        Patterns = @()
    },
    [PSCustomObject]@{
        Name = '02_section4_access_and_security_does_not_meet'
        Priority = 'High'
        Description = 'Second focus block. This section was 20 percent and scorecard says Does Not Meet.'
        Files = @(
            'notes/51_iam_intro.md',
            'notes/52_iam_overview.md',
            'notes/53_iam_organization_and_folders.md',
            'notes/54_iam_roles.md',
            'notes/55_iam_custom_role_demo.md',
            'notes/56_iam_members_and_policies.md',
            'notes/57_iam_service_accounts.md',
            'notes/58_iam_organization_restrictions.md',
            'notes/59_iam_best_practices.md',
            'notes/60_iam_lab_access_control.md',
            'notes/61_iam_lab_walkthrough.md',
            'notes/62_iam_module_summary.md',
            'notes/96_identity_aware_proxy.md',
            'notes/97_private_gke_cluster_iam_lab.md',
            'notes/134_resource_hierarchy_projects_iam.md',
            'notes/137_container_images_and_cloud_build.md',
            'ace_exam_refactor/02_iam_access_security.md',
            'ace_exam_refactor/08_pinpoint_traps.md',
            'ace_exam_refactor/10_command_playbook.md'
        )
        Patterns = @()
    },
    [PSCustomObject]@{
        Name = '03_section3_operations_borderline'
        Priority = 'Medium'
        Description = 'Third focus block. This section was 30 percent and scorecard says Borderline.'
        Files = @(
            'notes/78_resource_management_intro.md',
            'notes/79_resource_manager_overview.md',
            'notes/80_quotas.md',
            'notes/81_labels.md',
            'notes/82_billing_and_cost_management.md',
            'notes/83_billing_admin_demo.md',
            'notes/84_bigquery_billing_lab_walkthrough.md',
            'notes/85_observability_overview.md',
            'notes/86_cloud_monitoring.md',
            'notes/87_cloud_monitoring_lab_walkthrough.md',
            'notes/88_cloud_logging.md',
            'notes/89_error_reporting.md',
            'notes/90_cloud_trace.md',
            'notes/91_cloud_profiler.md',
            'notes/92_observability_integrations.md',
            'notes/93_observability_module_summary.md',
            'notes/116_load_balancing_module_summary.md',
            'notes/126_managed_services_module_summary.md',
            'notes/130_reliable_cloud_infra_course_intro.md',
            'notes/146_kubernetes_operations_intro.md',
            'notes/147_kubectl_configuration_and_usage.md',
            'notes/148_kubernetes_introspection_debugging.md',
            'ace_exam_refactor/07_operations_observability_cost.md',
            'ace_exam_refactor/08_pinpoint_traps.md',
            'ace_exam_refactor/10_command_playbook.md'
        )
        Patterns = @()
    },
    [PSCustomObject]@{
        Name = '04_section1_setup_environment_meets_refresh'
        Priority = 'Maintenance'
        Description = 'Keep this warm so it stays at Meets while you focus on weaker domains.'
        Files = @(
            'notes/01_cloud_computing_overview.md',
            'notes/02_resource_hierarchy.md',
            'notes/03_accessing_google_cloud.md',
            'notes/24_architecting_intro.md',
            'notes/25_getting_started_interacting_gcp.md',
            'notes/28_projects_and_billing.md',
            'notes/94_course_series_intro.md',
            'notes/131_cloud_computing_overview_gke_course.md',
            'notes/132_compute_services_overview.md',
            'notes/133_google_cloud_network_and_infrastructure.md',
            'notes/134_resource_hierarchy_projects_iam.md',
            'notes/135_billing_and_cost_controls.md',
            'notes/136_interacting_with_google_cloud.md',
            'notes/138_what_is_a_container.md',
            'notes/139_kubernetes_intro.md',
            'notes/140_gke_overview.md',
            'ace_exam_refactor/01_foundations_projects_billing.md',
            'ace_exam_refactor/11_full_coverage_map_00_148.md',
            'ace_exam_refactor/12_14_day_retake_plan.md'
        )
        Patterns = @()
    },
    [PSCustomObject]@{
        Name = '05_cross_topic_mixed_revision_all_topics'
        Priority = 'Daily'
        Description = 'Use these cumulative mixed sets every day for exam-style switching across domains.'
        Files = @(
            'ace_exam_refactor/08_pinpoint_traps.md',
            'ace_exam_refactor/09_real_world_scenarios.md',
            'ace_exam_refactor/10_command_playbook.md'
        )
        Patterns = @(
            'notes/*_mix_topics_*.md'
        )
    }
)

function Copy-RepoFile {
    param(
        [string]$RelativePath,
        [string]$DestinationFolder
    )

    $source = Join-Path $PSScriptRoot $RelativePath
    if (-not (Test-Path $source)) {
        Write-Warning "Missing file: $RelativePath"
        return $false
    }

    $destination = Join-Path $DestinationFolder ([System.IO.Path]::GetFileName($RelativePath))
    Copy-Item -Path $source -Destination $destination -Force
    return $true
}

$totalCopied = 0

foreach ($group in $groups) {
    $folder = Join-Path $root $group.Name
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
    }

    $copiedInGroup = 0

    foreach ($file in $group.Files) {
        if (Copy-RepoFile -RelativePath $file -DestinationFolder $folder) {
            $copiedInGroup++
            $totalCopied++
        }
    }

    foreach ($pattern in $group.Patterns) {
        $glob = Join-Path $PSScriptRoot $pattern
        $matches = Get-ChildItem -Path $glob -File | Sort-Object Name
        foreach ($match in $matches) {
            $destination = Join-Path $folder $match.Name
            Copy-Item -Path $match.FullName -Destination $destination -Force
            $copiedInGroup++
            $totalCopied++
        }
    }

    $readme = @"
# $($group.Name)

Priority: $($group.Priority)

$($group.Description)

How to use this folder:
- Read files in filename order.
- For each file, solve the full Extra Exam Practice block without looking at answers first.
- Track mistakes in one note: error type, why you missed it, and the corrected decision rule.
- Revisit missed questions after 24 hours and again after 72 hours.

Current markdown files in this folder: $copiedInGroup
"@

    Set-Content -Path (Join-Path $folder 'README.md') -Value $readme -NoNewline
}

$start = @"
# Scorecard Study Workspace

This workspace is arranged by your exam scorecard so you can start where you lost the most points.

Folder order to follow:
1. 01_section2_planning_and_implementation_does_not_meet
2. 02_section4_access_and_security_does_not_meet
3. 03_section3_operations_borderline
4. 04_section1_setup_environment_meets_refresh
5. 05_cross_topic_mixed_revision_all_topics

Method:
- Spend most time on folders 01 and 02 first.
- Use folder 05 every day to train context switching and elimination under pressure.
- Keep short mistake logs and convert each mistake into one decision rule.
"@
Set-Content -Path (Join-Path $root '00_start_here.md') -Value $start -NoNewline

$plan = @"
# 14 Day Scorecard Retake Plan

## Time Allocation by Score Impact
- Section 2 Planning and Implementing: 45 percent
- Section 4 Access and Security: 30 percent
- Section 3 Operations: 20 percent
- Section 1 Setup Environment: 5 percent

## Day Plan
1. Day 1: Section 2 networking and load balancing core files from folder 01 + one mixed file from folder 05.
2. Day 2: Section 2 compute and autoscaling files from folder 01 + one mixed file from folder 05.
3. Day 3: Section 2 storage and database files from folder 01 + one mixed file from folder 05.
4. Day 4: Section 4 IAM fundamentals and policy model from folder 02 + one mixed file.
5. Day 5: Section 4 service accounts, restrictions, and identity-aware controls from folder 02 + one mixed file.
6. Day 6: Section 3 monitoring and logging from folder 03 + one mixed file.
7. Day 7: Section 3 trace, profiler, quotas, labels, and cost controls from folder 03 + one mixed file.
8. Day 8: Section 2 fast second pass of weak files from folder 01 + two mixed files.
9. Day 9: Section 4 fast second pass of weak files from folder 02 + two mixed files.
10. Day 10: Section 3 fast second pass of weak files from folder 03 + two mixed files.
11. Day 11: Section 1 maintenance pass from folder 04 + two mixed files.
12. Day 12: Full mixed revision day from folder 05. Focus on elimination quality and decision speed.
13. Day 13: Weakest 15 files only (based on your error log) + three mixed files.
14. Day 14: Light review. No new content. Read only mistakes, decision rules, and command patterns.

## Question Routine Per File
- Attempt all practice questions first.
- Score yourself immediately.
- Write one line for each miss: what trap won and what rule prevents it next time.
- Re-attempt all misses at end of day.
"@
Set-Content -Path (Join-Path $root '14_day_retake_plan_scorecard.md') -Value $plan -NoNewline

Write-Output "Created: $root"
Write-Output "Total files copied: $totalCopied"
foreach ($group in $groups) {
    $groupPath = Join-Path $root $group.Name
    $count = (Get-ChildItem -Path $groupPath -Filter '*.md' | Where-Object { $_.Name -ne 'README.md' }).Count
    Write-Output "$($group.Name): $count markdown files"
}
