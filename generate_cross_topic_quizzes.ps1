$ErrorActionPreference = 'Stop'

$outDir = 'cross_topic_quizzes'
if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

Get-ChildItem -Path $outDir -Filter 'mix_*.md' -ErrorAction SilentlyContinue | Remove-Item -Force

$notes = Get-ChildItem -Path 'notes' -Filter '*.md' | Sort-Object Name
if ($notes.Count -eq 0) {
    throw 'No notes markdown files found under notes/.'
}

function Get-TopicLabel([string]$fileName) {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    $base = $base -replace '^\d+_', ''
    $base = $base -replace '_', ' '
    return (Get-Culture).TextInfo.ToTitleCase($base)
}

function Get-Recommendation([string]$fileName) {
    $k = $fileName.ToLowerInvariant()
    switch -Regex ($k) {
        'projects|resource_hierarchy|resource_manager' { return 'project-level isolation for IAM, API enablement, quotas, and billing' }
        'billing|quotas|labels|cost' { return 'budgets and alerts with quotas plus billing export visibility' }
        'iam|service_account|identity|access|organization_restrictions' { return 'least-privilege IAM with groups for users and service accounts for workloads' }
        'vpc|subnet|firewall|routes|ip_addresses|network_designs' { return 'VPC segmentation with tag or service-account-based firewall policies' }
        'vpn|interconnect|peering|shared_vpc|connectivity|nat' { return 'private connectivity with HA VPN or Interconnect and correct egress design' }
        'load_balancing|alb|network_load_balancing|internal_load_balancing|cdn|dns' { return 'correct load balancer type with DNS and edge strategy aligned to traffic pattern' }
        'compute_engine|vm_|machine|disk|images|instance' { return 'Compute Engine design with autoscaling, resilience, and right sizing' }
        'managed_instance_groups|mig|autoscaling|health' { return 'regional MIG with health checks, autohealing, and autoscaling policy' }
        'kubernetes|gke|kubectl|container' { return 'GKE workload placement, rolling updates, and node pool optimization' }
        'cloud_run|app_engine|functions' { return 'managed serverless deployment path for minimal operations overhead' }
        'cloud_storage|storage_classes|filestore|storage_overview' { return 'storage class and lifecycle policy selected by access frequency and retention' }
        'cloud_sql|spanner|firestore|bigtable|alloydb|memorystore|database' { return 'database choice by data model, scale pattern, and consistency requirements' }
        'bigquery|dataflow|dataprep|dataproc|managed_services' { return 'analytics pipeline with correct ingest, transform, and warehouse roles' }
        'monitoring|logging|trace|profiler|error_reporting|observability' { return 'monitoring plus logging plus tracing with alert-driven operations' }
        'terraform|infrastructure_automation|deployment_manager|marketplace' { return 'infrastructure-as-code and standardized deployment templates' }
        default { return 'managed-service-first architecture with least-privilege controls' }
    }
}

function Get-UniqueIndices([int]$count, [int]$need, [int]$offset) {
    if ($count -le 0) {
        return @()
    }

    $need = [Math]::Max(1, [Math]::Min($need, $count))
    $indices = New-Object System.Collections.Generic.List[int]
    $step = [Math]::Max(1, [Math]::Floor($count / [Math]::Max(1, $need)))
    if (($step % 2) -eq 0) {
        $step = $step + 1
    }

    $attempt = 0
    $maxAttempts = $count * 4

    while ($indices.Count -lt $need -and $attempt -lt $maxAttempts) {
        $idx = ($offset + ($attempt * $step)) % $count
        if (-not $indices.Contains($idx)) {
            $indices.Add($idx)
        }
        $attempt++
    }

    if ($indices.Count -lt $need) {
        for ($i = 0; $i -lt $count -and $indices.Count -lt $need; $i++) {
            if (-not $indices.Contains($i)) {
                $indices.Add($i)
            }
        }
    }

    return $indices
}

function Build-Question([array]$covered, [int]$mixCount, [int]$qNo, [int]$checkpoint) {
    $count = $covered.Count
    $indices = Get-UniqueIndices -count $count -need $mixCount -offset ($checkpoint + $qNo * 3)

    $selected = foreach ($i in $indices) { $covered[$i] }
    $labels = $selected | ForEach-Object { $_.Label }
    $conceptMix = ($labels -join ' + ')

    $recs = $selected | ForEach-Object { $_.Rec } | Select-Object -Unique | Select-Object -First 3
    $good = 'Use ' + ($recs -join '; ') + ', and enforce least-privilege IAM with automated monitoring and alerts.'
    $bad1 = 'Use broad Owner/Editor roles and one shared manual setup to reduce initial effort.'
    $bad2 = 'Optimize only for short-term cost and ignore latency, reliability, and recovery constraints.'
    $bad3 = 'Rely on ad-hoc scripts with public exposure defaults and fix controls later.'

    $answerCycle = @('B', 'C', 'A', 'D')
    $ans = $answerCycle[($qNo - 1) % $answerCycle.Count]

    $optA = ''
    $optB = ''
    $optC = ''
    $optD = ''

    switch ($ans) {
        'A' { $optA = $good; $optB = $bad1; $optC = $bad2; $optD = $bad3 }
        'B' { $optA = $bad1; $optB = $good; $optC = $bad2; $optD = $bad3 }
        'C' { $optA = $bad1; $optB = $bad2; $optC = $good; $optD = $bad3 }
        'D' { $optA = $bad1; $optB = $bad2; $optC = $bad3; $optD = $good }
    }

    @"
### Q$qNo (Mix $mixCount Concepts)
Concept Mix: $conceptMix
Scenario: You are deploying a production workload that combines the concepts above. The system must be secure, scalable, and cost-aware while minimizing operations overhead. What is the best approach?

A. $optA
B. $optB
C. $optC
D. $optD

Answer: $ans
Trap: The wrong options either over-privilege access, over-index on one constraint, or increase manual operational risk.

"@
}

$checkpoints = New-Object System.Collections.Generic.List[int]
for ($i = 3; $i -le $notes.Count; $i += 3) {
    $checkpoints.Add($i)
}
if ($notes.Count % 3 -ne 0) {
    $checkpoints.Add($notes.Count)
}

$created = New-Object System.Collections.Generic.List[string]
$prev = 0

foreach ($cp in $checkpoints) {
    $coveredFiles = $notes[0..($cp - 1)]
    $covered = foreach ($f in $coveredFiles) {
        [PSCustomObject]@{
            Name  = $f.Name
            Label = Get-TopicLabel $f.Name
            Rec   = Get-Recommendation $f.Name
        }
    }

    $newStart = $prev + 1
    $newEnd = $cp

    $qCount = if ($cp -le 3) { 3 } else { 4 }
    $mixes = if ($qCount -eq 3) {
        @([Math]::Min(2, $cp), [Math]::Min(3, $cp), [Math]::Min(2, $cp))
    }
    else {
        @([Math]::Min(2, $cp), [Math]::Min(3, $cp), [Math]::Min(4, $cp), [Math]::Min(5, $cp))
    }

    $fileName = ('mix_{0:d3}_topics_001_{1:d3}.md' -f $cp, $cp)
    $path = Join-Path $outDir $fileName

    if ($covered.Count -le 8) {
        $focus = $covered
    }
    else {
        $focus = $covered[($covered.Count - 8)..($covered.Count - 1)]
    }

    $content = New-Object System.Text.StringBuilder
    [void]$content.AppendLine("# Cross-Topic Mix Set $($cp.ToString('000'))")
    [void]$content.AppendLine('')
    [void]$content.AppendLine("Coverage Window: topics 001 to $($cp.ToString('000'))")
    [void]$content.AppendLine("Newly Added Since Last Mix: topics $($newStart.ToString('000')) to $($newEnd.ToString('000'))")
    [void]$content.AppendLine('')
    [void]$content.AppendLine('Focus Topics For This Set:')
    foreach ($t in $focus) {
        [void]$content.AppendLine("- $($t.Label)")
    }
    [void]$content.AppendLine('')
    [void]$content.AppendLine("Question Count: $qCount")
    [void]$content.AppendLine('Each question mixes 2 to 5 previously covered concepts.')
    [void]$content.AppendLine('')

    for ($q = 1; $q -le $qCount; $q++) {
        [void]$content.Append((Build-Question -covered $covered -mixCount $mixes[$q - 1] -qNo $q -checkpoint $cp))
    }

    Set-Content -Path $path -Value $content.ToString() -NoNewline
    $created.Add($fileName)
    Write-Output ("Generated: {0}" -f $fileName)
    $prev = $cp
}

$index = New-Object System.Text.StringBuilder
[void]$index.AppendLine('# Cross-Topic Quiz Index')
[void]$index.AppendLine('')
[void]$index.AppendLine('This track adds cumulative mixed-topic ACE-style questions so practice is never isolated by single topic.')
[void]$index.AppendLine('')
[void]$index.AppendLine('Pattern used:')
[void]$index.AppendLine('- After topic 3: 3 mixed questions')
[void]$index.AppendLine('- After topic 6 and onward checkpoints: 4 mixed questions per file')
[void]$index.AppendLine('- Each question mixes 2 to 5 concepts from covered topics')
[void]$index.AppendLine('')
[void]$index.AppendLine('## Files')
[void]$index.AppendLine('')
foreach ($f in $created) {
    [void]$index.AppendLine("- $f")
}
Set-Content -Path (Join-Path $outDir 'README.md') -Value $index.ToString() -NoNewline

Write-Output ("Created mix files: {0}" -f $created.Count)
Write-Output ("Total notes detected: {0}" -f $notes.Count)
