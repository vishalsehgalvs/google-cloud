param(
    [switch]$DryRun,
    [int]$Limit = 0,
    [switch]$ExcludeMixFiles,
    [int]$QuestionsPerNote = 10
)

$ErrorActionPreference = 'Stop'

$notesDir = Join-Path $PSScriptRoot 'notes'
if (-not (Test-Path $notesDir)) {
    throw "notes directory not found at $notesDir"
}

$startMarker = '<!-- ACE_DEEP_ENRICHMENT_START -->'
$endMarker = '<!-- ACE_DEEP_ENRICHMENT_END -->'
$blockRegex = '(?s)\r?\n?<!-- ACE_DEEP_ENRICHMENT_START -->.*?<!-- ACE_DEEP_ENRICHMENT_END -->\r?\n?'

function Get-NoteTitle {
    param(
        [string]$Content,
        [string]$FallbackName
    )

    $lines = $Content -split "`r?`n"
    $inCodeFence = $false

    foreach ($line in $lines) {
        $trim = $line.Trim()
        if ($trim.StartsWith('```')) {
            $inCodeFence = -not $inCodeFence
            continue
        }

        if ($inCodeFence) {
            continue
        }

        if ($line -match '^\s*#{1,3}\s+(.+?)\s*$') {
            $candidate = $Matches[1].Trim()
            if (-not [string]::IsNullOrWhiteSpace($candidate)) {
                return $candidate
            }
        }
    }

    $base = [System.IO.Path]::GetFileNameWithoutExtension($FallbackName)
    $base = $base -replace '^\d+[a-z]?_', ''
    $base = $base -replace '_', ' '
    return (Get-Culture).TextInfo.ToTitleCase($base)
}

function Get-Category {
    param(
        [string]$FileName,
        [string]$Title
    )

    $s = ("$FileName $Title").ToLowerInvariant()

    if ($FileName.ToLowerInvariant().Contains('_mix_topics_')) {
        return 'mix'
    }
    if ($s -match 'iam|identity|policy|service_account|access|organization_restrictions|security|u2f|least[- ]privilege') {
        return 'iam'
    }
    if ($s -match 'vpc|network|subnet|firewall|routes|route|ip_|dns|cdn|load_balancing|alb|vpn|interconnect|peering|nat|iap|connectivity') {
        return 'network'
    }
    if ($s -match 'compute|vm|mig|autoscaling|health_checks|gke|kubernetes|kubectl|container|cloud_run|app_engine|functions|instance') {
        return 'compute'
    }
    if ($s -match 'storage|cloud_sql|spanner|firestore|bigtable|alloydb|memorystore|database|filestore|bucket') {
        return 'storage'
    }
    if ($s -match 'bigquery|dataflow|dataprep|dataproc|pipeline|etl|warehouse|analytics') {
        return 'data'
    }
    if ($s -match 'billing|cost|quota|labels') {
        return 'cost'
    }
    if ($s -match 'monitoring|logging|trace|profiler|observability|error_reporting') {
        return 'ops'
    }
    return 'foundations'
}

function Get-Profile {
    param([string]$Category)

    switch ($Category) {
        'iam' {
            return @{
                scenario = 'A fintech team is onboarding 40 engineers and 12 workloads in one quarter. They need strict access boundaries, auditability, and zero long-lived credentials while still shipping features fast.'
                example = @(
                    'Create separate projects for dev, staging, and prod so IAM and quotas are isolated.',
                    'Map users to Google Groups and grant predefined roles at the narrowest scope.',
                    'Use service accounts for workloads and rotate to short-lived credentials through Workload Identity.',
                    'Enable audit logs and alert on policy changes and service account key creation.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[New Access Request] --> B{Human or Workload?}',
                    '    B -->|Human| C[Group Based IAM]',
                    '    B -->|Workload| D[Service Account + Workload Identity]',
                    '    C --> E{Least Privilege Verified?}',
                    '    D --> E',
                    '    E -->|No| F[Reduce Permissions]',
                    '    E -->|Yes| G[Approve and Log]',
                    '    G --> H[Continuous Audit Alerts]'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant User',
                    '    participant IAM',
                    '    participant SA as ServiceAccount',
                    '    participant API',
                    '    User->>IAM: Request role binding',
                    '    IAM-->>User: Grant least privilege role',
                    '    SA->>IAM: Exchange identity token',
                    '    IAM-->>SA: Short lived access token',
                    '    SA->>API: Call API with token',
                    '    API-->>SA: Authorized response'
                )
                prompts = @(
                    'Your team must grant temporary production access for incident response. Which approach is best?',
                    'A workload is still using a JSON key file in source control. What is the best fix?',
                    'Which setup best reduces blast radius across environments?',
                    'What should you monitor first for IAM abuse detection?',
                    'A developer needs read-only billing visibility. Which decision is best?'
                )
                correct = @(
                    'Grant a time-bound least-privilege role through group membership and audit the binding.',
                    'Move to service account impersonation or Workload Identity and disable long-lived keys.',
                    'Use separate projects per environment with narrow IAM bindings at project or resource level.',
                    'Alert on IAM policy changes, service account key creation, and high-risk privilege grants.',
                    'Assign a billing viewer role at the required scope instead of broad project editor access.'
                )
                traps = @(
                    'Grant Owner role temporarily and remove it manually later.',
                    'Share one administrator account for faster troubleshooting.',
                    'Store service account keys in a shared drive because it is internal.',
                    'Apply organization-level broad roles so future access requests are avoided.',
                    'Skip audit logs to reduce logging costs during non-peak hours.'
                )
                commands = @(
                    'gcloud projects get-iam-policy PROJECT_ID',
                    'gcloud projects add-iam-policy-binding PROJECT_ID --member=group:team@example.com --role=roles/viewer',
                    'gcloud iam service-accounts list --project=PROJECT_ID',
                    'gcloud logging read "protoPayload.methodName=\"SetIamPolicy\"" --freshness=7d --project=PROJECT_ID --limit=20'
                )
                recall = @(
                    'Least privilege beats convenience in all exam scenarios.',
                    'Prefer groups for humans and service accounts for workloads.',
                    'Avoid long-lived keys whenever possible.'
                )
            }
        }
        'network' {
            return @{
                scenario = 'An ecommerce platform serves customers across regions. The team must keep latency low, protect internal services, and survive zonal failures while controlling egress costs.'
                example = @(
                    'Place internet-facing services behind the correct external load balancer type.',
                    'Keep internal services private with internal load balancers and private IP ranges.',
                    'Use firewall rules by tags or service accounts, not wide open CIDR ranges.',
                    'Add Cloud CDN or regional placement based on traffic profile and content type.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[Traffic Requirement] --> B{Public or Private Entry?}',
                    '    B -->|Public| C[External Load Balancer]',
                    '    B -->|Private| D[Internal Load Balancer]',
                    '    C --> E{Global Users?}',
                    '    E -->|Yes| F[Global Backend + CDN]',
                    '    E -->|No| G[Regional Backend]',
                    '    D --> H[VPC Segmentation + Firewall]',
                    '    F --> I[Observability and SLO Alerts]',
                    '    G --> I',
                    '    H --> I'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant Client',
                    '    participant DNS',
                    '    participant LB',
                    '    participant Service',
                    '    participant Logs',
                    '    Client->>DNS: Resolve application endpoint',
                    '    DNS-->>Client: Return load balancer IP',
                    '    Client->>LB: HTTPS request',
                    '    LB->>Service: Forward to healthy backend',
                    '    Service-->>LB: Response',
                    '    LB-->>Client: Response',
                    '    LB->>Logs: Emit latency and error metrics'
                )
                prompts = @(
                    'A service must be reachable only from internal VMs. Which design is best?',
                    'You need to reduce global web latency for static assets. What should you choose?',
                    'Which firewall strategy best matches zero-trust network design?',
                    'A backend fails health checks in one zone. What architecture is best practice?',
                    'You need private hybrid connectivity between on-prem and GCP. Which path is preferred?'
                )
                correct = @(
                    'Use an internal load balancer with private backend endpoints and private DNS.',
                    'Use an external application load balancer with Cloud CDN and cacheable content rules.',
                    'Use least-privilege firewall policies scoped by service accounts or tags.',
                    'Run multi-zone backends with health checks and automatic failover.',
                    'Use HA VPN or Interconnect based on throughput and SLA requirements.'
                )
                traps = @(
                    'Expose the service publicly and rely on app-level passwords.',
                    'Use one VM with a static external IP to simplify architecture.',
                    'Allow 0.0.0.0/0 ingress to speed up troubleshooting.',
                    'Disable health checks to avoid accidental failover.',
                    'Route all traffic through manual bastion hops in production.'
                )
                commands = @(
                    'gcloud compute firewall-rules list --project=PROJECT_ID',
                    'gcloud compute forwarding-rules list --global --project=PROJECT_ID',
                    'gcloud compute backend-services get-health BACKEND_NAME --global --project=PROJECT_ID',
                    'gcloud compute routes list --project=PROJECT_ID'
                )
                recall = @(
                    'Pick load balancer type by traffic pattern, not preference.',
                    'Private services should stay private end to end.',
                    'Health checks and multi-zone design are core reliability controls.'
                )
            }
        }
        'compute' {
            return @{
                scenario = 'A media startup has unpredictable traffic spikes during launches. They need faster releases, automatic scaling, and strong reliability without overpaying for idle capacity.'
                example = @(
                    'Choose managed compute first when operations overhead is a concern.',
                    'For VM workloads, use managed instance groups with autoscaling and autohealing.',
                    'For container workloads, use GKE node pools and rolling updates.',
                    'For event-driven workloads, prefer Cloud Run or functions with concurrency controls.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[Workload Requirement] --> B{Need Full VM Control?}',
                    '    B -->|Yes| C[Compute Engine + MIG]',
                    '    B -->|No| D{Containerized?}',
                    '    D -->|Yes| E[GKE or Cloud Run]',
                    '    D -->|No| F[Cloud Run Functions]',
                    '    C --> G[Autoscaling + Health Checks]',
                    '    E --> G',
                    '    F --> G',
                    '    G --> H[Monitoring + Error Budgets]'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant User',
                    '    participant Ingress',
                    '    participant Compute',
                    '    participant Autoscaler',
                    '    participant Monitor',
                    '    User->>Ingress: Send request',
                    '    Ingress->>Compute: Route to healthy instance',
                    '    Compute-->>User: Return response',
                    '    Monitor->>Autoscaler: Report utilization metrics',
                    '    Autoscaler->>Compute: Scale out or in'
                )
                prompts = @(
                    'Traffic triples during business hours and falls overnight. Which compute pattern is best?',
                    'A VM app must self-heal when instances fail health checks. What should you use?',
                    'A team wants to deploy containers without managing nodes. Which platform fits best?',
                    'Which update strategy minimizes user impact during releases?',
                    'How do you avoid overprovisioning while keeping performance stable?'
                )
                correct = @(
                    'Use autoscaling with target utilization and baseline minimum capacity.',
                    'Use a managed instance group with health checks and autohealing enabled.',
                    'Use Cloud Run for containerized services when node management is not required.',
                    'Use rolling or blue-green deployment with health-based rollout checks.',
                    'Right-size resources and monitor saturation, latency, and error rates continuously.'
                )
                traps = @(
                    'Pin capacity to peak traffic all day for safety.',
                    'Restart failed instances manually as incidents occur.',
                    'Use one large VM because horizontal scaling is complex.',
                    'Deploy all changes at once without canary checks.',
                    'Ignore utilization metrics and optimize only by guesswork.'
                )
                commands = @(
                    'gcloud compute instance-groups managed list --project=PROJECT_ID',
                    'gcloud compute instance-groups managed describe MIG_NAME --zone=ZONE --project=PROJECT_ID',
                    'gcloud run services list --region=REGION --project=PROJECT_ID',
                    'kubectl get pods -A'
                )
                recall = @(
                    'Autoscaling is useful only with valid signals and guardrails.',
                    'Managed offerings usually reduce operational burden.',
                    'Deployment safety needs health checks and staged rollout.'
                )
            }
        }
        'storage' {
            return @{
                scenario = 'A healthcare SaaS stores user documents, transactional data, and low-latency session state. They must balance cost, durability, and performance under compliance constraints.'
                example = @(
                    'Map each data type to the right storage service by access pattern and consistency needs.',
                    'Use lifecycle policies for object storage to control long-term cost.',
                    'Select database engines based on query shape, scale, and relational requirements.',
                    'Back up critical datasets and validate restore runbooks regularly.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[Data Requirement] --> B{Object, Relational, or NoSQL?}',
                    '    B -->|Object| C[Cloud Storage + Lifecycle]',
                    '    B -->|Relational| D[Cloud SQL or AlloyDB]',
                    '    B -->|NoSQL| E[Firestore or Bigtable]',
                    '    C --> F{Access Frequency?}',
                    '    F -->|Hot| G[Standard Class]',
                    '    F -->|Cold| H[Nearline or Archive]',
                    '    D --> I[Backup and HA Strategy]',
                    '    E --> I',
                    '    G --> I',
                    '    H --> I'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant App',
                    '    participant Storage',
                    '    participant DB',
                    '    participant Backup',
                    '    App->>Storage: Upload object',
                    '    Storage-->>App: Return object path',
                    '    App->>DB: Write metadata record',
                    '    DB-->>App: Commit transaction',
                    '    DB->>Backup: Schedule snapshot'
                )
                prompts = @(
                    'Your logs are rarely accessed after 90 days. What storage policy is best?',
                    'A workload requires relational transactions and managed operations. Which database is best?',
                    'Which practice improves durability and recovery posture most?',
                    'A key-value workload needs very high scale and low latency. Which service fits?',
                    'How should you choose a storage class on the exam?'
                )
                correct = @(
                    'Use lifecycle rules to transition objects to colder storage classes after 90 days.',
                    'Use Cloud SQL or AlloyDB for managed relational workloads with transaction support.',
                    'Enable backups with tested restore procedures and clear recovery objectives.',
                    'Use Bigtable for high-throughput low-latency wide-column workloads.',
                    'Choose based on access frequency, retention period, and retrieval latency requirements.'
                )
                traps = @(
                    'Keep everything in the most expensive hot class forever.',
                    'Use local disk snapshots as the only backup strategy.',
                    'Pick a database only by familiarity and ignore access patterns.',
                    'Store transactional records only in object storage.',
                    'Skip restore drills because backups are assumed valid.'
                )
                commands = @(
                    'gcloud storage ls --project=PROJECT_ID',
                    'gcloud sql instances list --project=PROJECT_ID',
                    'gcloud firestore databases list --project=PROJECT_ID',
                    'gcloud bigtable instances list --project=PROJECT_ID'
                )
                recall = @(
                    'Data service choice is a pattern-matching question.',
                    'Lifecycle rules are a common cost optimization lever.',
                    'Backup without restore validation is not a complete strategy.'
                )
            }
        }
        'data' {
            return @{
                scenario = 'A retail analytics team needs near-real-time dashboards and nightly reporting from multiple source systems while controlling pipeline failures and data quality regressions.'
                example = @(
                    'Ingest streaming or batch data through the right transport and landing zone.',
                    'Use Dataflow or Dataproc based on transformation complexity and runtime control needs.',
                    'Store analytics outputs in BigQuery with partitioning and clustering.',
                    'Monitor pipeline lag, failed jobs, and schema drift with alerts.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[Data Source] --> B{Batch or Streaming?}',
                    '    B -->|Batch| C[Scheduled Ingest]',
                    '    B -->|Streaming| D[Streaming Ingest]',
                    '    C --> E[Transform Layer]',
                    '    D --> E',
                    '    E --> F[BigQuery Curated Tables]',
                    '    F --> G[Dashboards and Alerts]',
                    '    E --> H[Data Quality Checks]'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant Source',
                    '    participant Pipeline',
                    '    participant Warehouse',
                    '    participant BI',
                    '    Source->>Pipeline: Emit records',
                    '    Pipeline->>Pipeline: Validate and transform',
                    '    Pipeline->>Warehouse: Load partitioned tables',
                    '    Warehouse-->>BI: Query serving',
                    '    BI-->>Warehouse: Dashboard refresh'
                )
                prompts = @(
                    'You need low-latency event processing with autoscaling transforms. Which service is best?',
                    'What is the best BigQuery table strategy for time-series analytics?',
                    'A pipeline keeps failing due to schema changes. What is the best first control?',
                    'Which architecture supports both nightly batch and near-real-time reporting?',
                    'What should teams monitor to catch pipeline regressions early?'
                )
                correct = @(
                    'Use Dataflow for managed autoscaling stream and batch processing.',
                    'Use partitioned tables and clustering for common filter dimensions.',
                    'Add schema validation and contract checks before loading curated tables.',
                    'Use a shared transform layer that handles both streaming and scheduled batch paths.',
                    'Monitor lag, failed jobs, data freshness, and quality rule violations.'
                )
                traps = @(
                    'Run all ETL manually from local scripts on one VM.',
                    'Store analytical aggregates only in flat files.',
                    'Disable job retry and ignore dead-letter handling.',
                    'Use unpartitioned large tables for all query workloads.',
                    'Treat data quality checks as optional in production.'
                )
                commands = @(
                    'bq ls --project_id=PROJECT_ID',
                    'bq query --use_legacy_sql=false "SELECT COUNT(*) FROM DATASET.TABLE"',
                    'gcloud dataflow jobs list --region=REGION --project=PROJECT_ID',
                    'gcloud dataproc clusters list --region=REGION --project=PROJECT_ID'
                )
                recall = @(
                    'Design pipeline by freshness target and transformation complexity.',
                    'Partitioning and clustering are common BigQuery optimization tools.',
                    'Data quality checks belong inside the pipeline, not after incidents.'
                )
            }
        }
        'cost' {
            return @{
                scenario = 'A scale-up exceeded budget for two months due to idle resources and untracked growth. Leadership needs predictable spend without breaking product velocity.'
                example = @(
                    'Set budgets and alerts at billing account and project levels.',
                    'Use labels for environment, team, and cost center to attribute spend.',
                    'Right-size compute and remove idle disks, snapshots, and static IPs.',
                    'Export billing data for trend analysis and anomaly detection.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[Monthly Cost Review] --> B{Budget Breach Risk?}',
                    '    B -->|Yes| C[Trigger Alerts]',
                    '    B -->|No| D[Continue Monitoring]',
                    '    C --> E[Find Top Cost Drivers]',
                    '    E --> F[Rightsize and Cleanup]',
                    '    F --> G[Add Labels and Guardrails]',
                    '    G --> H[Recheck Forecast]'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant Billing',
                    '    participant Alerting',
                    '    participant Team',
                    '    participant Resources',
                    '    Billing->>Alerting: Budget threshold crossed',
                    '    Alerting-->>Team: Send notification',
                    '    Team->>Resources: Cleanup and right-size',
                    '    Resources-->>Billing: Lower projected spend'
                )
                prompts = @(
                    'A project is constantly over budget. What is the highest-impact first step?',
                    'Which resource tagging strategy improves chargeback visibility?',
                    'How should you control runaway spend in exam scenarios?',
                    'What is the best way to identify long-term cost trends?',
                    'Which decision reduces waste while preserving reliability?'
                )
                correct = @(
                    'Create budgets with alerts and investigate top cost drivers immediately.',
                    'Apply consistent labels for owner, environment, and cost center.',
                    'Use quotas, budgets, and alerting guardrails before incidents happen.',
                    'Export billing data and analyze trends with dashboards and anomaly checks.',
                    'Right-size resources using utilization metrics and remove idle assets.'
                )
                traps = @(
                    'Wait until the invoice arrives, then react next month.',
                    'Disable all monitoring because it has a minor cost.',
                    'Give every team unrestricted quotas for speed.',
                    'Keep orphaned resources as backups without tracking.',
                    'Use one shared project for all environments and teams.'
                )
                commands = @(
                    'gcloud beta billing budgets list --billing-account=BILLING_ACCOUNT_ID',
                    'gcloud compute instances list --project=PROJECT_ID',
                    'gcloud compute disks list --project=PROJECT_ID',
                    'gcloud resource-manager tags keys list --parent=projects/PROJECT_NUMBER'
                )
                recall = @(
                    'Budgets and alerts are preventive controls, not reporting after the fact.',
                    'Label discipline enables real cost accountability.',
                    'Rightsizing requires metrics, not assumptions.'
                )
            }
        }
        'ops' {
            return @{
                scenario = 'A customer-facing API has intermittent latency spikes and error bursts. The team needs faster detection, cleaner triage, and safer remediation during peak traffic.'
                example = @(
                    'Define SLOs and monitor latency, error rate, and saturation.',
                    'Correlate logs, metrics, and traces using request IDs.',
                    'Create alert policies for burn-rate and critical error thresholds.',
                    'Run incident playbooks and validate post-incident action items.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[Incident Signal] --> B{Metric or Log Alert?}',
                    '    B -->|Metric| C[Check SLO Burn Rate]',
                    '    B -->|Log| D[Find Error Fingerprint]',
                    '    C --> E[Trace Affected Requests]',
                    '    D --> E',
                    '    E --> F[Apply Safe Mitigation]',
                    '    F --> G[Post Incident Review]'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant User',
                    '    participant Service',
                    '    participant Monitoring',
                    '    participant Logging',
                    '    participant OnCall',
                    '    User->>Service: Request',
                    '    Service-->>User: Error response',
                    '    Service->>Monitoring: Emit metrics',
                    '    Service->>Logging: Emit structured log',
                    '    Monitoring-->>OnCall: Alert triggered',
                    '    OnCall->>Logging: Investigate root cause'
                )
                prompts = @(
                    'Latency increases only for one endpoint. What is the best first triage action?',
                    'Which monitoring strategy best protects user experience?',
                    'A team has logs but no trace correlation. What should they add?',
                    'How should alerting be tuned to reduce noisy pages?',
                    'What should happen after mitigation is applied?'
                )
                correct = @(
                    'Check endpoint-specific metrics and traces before broad scaling actions.',
                    'Track SLO-aligned latency and error burn-rate alerts.',
                    'Add request correlation IDs across logs and traces.',
                    'Use severity-based alerts with actionable thresholds and runbooks.',
                    'Run a post-incident review and capture prevention tasks.'
                )
                traps = @(
                    'Restart all services immediately without diagnosis.',
                    'Rely only on CPU metrics and ignore user-facing latency.',
                    'Disable alerts during busy periods to avoid noise.',
                    'Investigate incidents only from one log line sample.',
                    'Skip retrospectives once service is healthy again.'
                )
                commands = @(
                    'gcloud monitoring policies list --project=PROJECT_ID',
                    'gcloud logging read "severity>=ERROR" --freshness=1d --project=PROJECT_ID --limit=30',
                    'gcloud alpha monitoring channels list --project=PROJECT_ID',
                    'gcloud logging metrics list --project=PROJECT_ID'
                )
                recall = @(
                    'Observability is metrics plus logs plus traces together.',
                    'Alerts should be actionable and aligned to SLO impact.',
                    'Post-incident review turns outages into reliability improvements.'
                )
            }
        }
        'mix' {
            return @{
                scenario = 'This checkpoint combines multiple earlier topics. Treat it like a production architecture review where security, reliability, cost, and operations all matter at the same time.'
                example = @(
                    'Read requirements and classify them into security, reliability, performance, and cost.',
                    'Pick managed services first, then add specific controls for access and observability.',
                    'Validate failure handling across zone, region, and dependency boundaries.',
                    'Reject options that optimize one constraint while breaking others.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[Scenario Requirement] --> B[Identify Constraints]',
                    '    B --> C{Security, Reliability, Cost, Ops Covered?}',
                    '    C -->|No| D[Refine Design]',
                    '    C -->|Yes| E[Select Managed Services]',
                    '    E --> F[Add IAM and Network Guardrails]',
                    '    F --> G[Add Monitoring and Budget Alerts]',
                    '    G --> H[Choose Best Exam Option]'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant Candidate',
                    '    participant Scenario',
                    '    participant Design',
                    '    participant Validation',
                    '    Candidate->>Scenario: Parse requirement and constraints',
                    '    Candidate->>Design: Build candidate architecture',
                    '    Design->>Validation: Check security, reliability, cost, ops',
                    '    Validation-->>Candidate: Keep only balanced option'
                )
                prompts = @(
                    'A mixed-topic scenario has one option that is fast but insecure. What should you do?',
                    'Which answer pattern is usually strongest in mixed scenarios?',
                    'A design is cheap but single-zone and unmonitored. How should you evaluate it?',
                    'What is the best exam-time method when two options look correct?',
                    'How do you avoid trap choices in cumulative questions?'
                )
                correct = @(
                    'Reject it and choose the option that balances security with reliability and operations.',
                    'Choose managed-service-first plus least-privilege IAM and observability controls.',
                    'Mark it as a trap because it violates reliability and operational readiness.',
                    'Score both options against all constraints and pick the one with fewer tradeoff risks.',
                    'Eliminate options with broad access, single points of failure, or missing monitoring.'
                )
                traps = @(
                    'Pick the shortest option because it saves reading time.',
                    'Optimize only for cost and ignore reliability requirements.',
                    'Assume manual fixes later are acceptable in production.',
                    'Prefer options with broad admin access for simplicity.',
                    'Skip checking observability and backup strategy.'
                )
                commands = @(
                    'gcloud projects list',
                    'gcloud services list --enabled --project=PROJECT_ID',
                    'gcloud logging read "severity>=ERROR" --project=PROJECT_ID --freshness=24h --limit=10',
                    'gcloud compute regions list'
                )
                recall = @(
                    'Mixed questions reward balanced architecture decisions.',
                    'Strong options usually include security and observability by default.',
                    'Trap answers often trade production safety for short-term convenience.'
                )
            }
        }
        default {
            return @{
                scenario = 'A growing startup is moving from manual infrastructure to Google Cloud. They need fast delivery, better reliability, and clear operational controls while keeping architecture simple.'
                example = @(
                    'Translate business goals into technical constraints before selecting services.',
                    'Favor managed services to reduce operational burden where possible.',
                    'Apply least-privilege IAM and private-by-default networking decisions.',
                    'Add monitoring, logging, and budget controls from the start.'
                )
                flowchart = @(
                    'flowchart TD',
                    '    A[Business Goal] --> B[Technical Constraints]',
                    '    B --> C{Need Custom Infra Control?}',
                    '    C -->|Yes| D[Choose IaaS Pattern]',
                    '    C -->|No| E[Choose Managed Service]',
                    '    D --> F[Apply IAM and Network Guardrails]',
                    '    E --> F',
                    '    F --> G[Add Monitoring and Cost Controls]',
                    '    G --> H[Run Production Readiness Check]'
                )
                sequence = @(
                    'sequenceDiagram',
                    '    participant Team',
                    '    participant Platform',
                    '    participant Security',
                    '    participant Operations',
                    '    Team->>Platform: Deploy workload',
                    '    Platform->>Security: Enforce IAM and policy',
                    '    Platform->>Operations: Emit logs and metrics',
                    '    Operations-->>Team: Alert and feedback loop'
                )
                prompts = @(
                    'Which design pattern is usually best for fast, safe cloud adoption?',
                    'A team wants speed and low ops overhead. What should they prioritize?',
                    'What is a common architecture trap in early cloud projects?',
                    'Which control set should be baseline for production?',
                    'How should you evaluate conflicting requirements on the exam?'
                )
                correct = @(
                    'Use managed services with least-privilege IAM and clear observability controls.',
                    'Prefer services that reduce operational toil while meeting reliability goals.',
                    'Over-broad access and missing monitoring are high-risk trap patterns.',
                    'Baseline should include IAM guardrails, logging, monitoring, and cost alerts.',
                    'Choose the option that balances security, reliability, cost, and operability.'
                )
                traps = @(
                    'Start with manual scripts and unrestricted access, then harden later.',
                    'Use one project for everything to reduce setup effort.',
                    'Ignore telemetry until after first production incident.',
                    'Pick only the cheapest service regardless of reliability needs.',
                    'Keep architecture opaque to avoid governance overhead.'
                )
                commands = @(
                    'gcloud config list',
                    'gcloud projects describe PROJECT_ID',
                    'gcloud services list --enabled --project=PROJECT_ID',
                    'gcloud logging read "severity>=WARNING" --project=PROJECT_ID --freshness=2d --limit=20'
                )
                recall = @(
                    'Good cloud design is constraint-driven, not tool-driven.',
                    'Managed services usually improve delivery speed and reliability.',
                    'Security and observability should be built in from day one.'
                )
            }
        }
    }
}

function Get-PrimaryOptimizationAxis {
    param([string]$Category)

    switch ($Category) {
        'iam' { return 'Security posture and blast-radius minimization' }
        'network' { return 'Latency-resilience balance with private-by-default connectivity' }
        'compute' { return 'Elastic performance with minimum operational toil' }
        'storage' { return 'Durability and access-pattern fit at the lowest lifecycle cost' }
        'data' { return 'Data freshness and correctness with scalable transformation' }
        'cost' { return 'Predictable spend guardrails without reliability regression' }
        'ops' { return 'SLO-driven reliability and faster mean time to recovery' }
        'mix' { return 'Balanced trade-offs across security, reliability, cost, and operability' }
        default { return 'Managed-service-first design with reliability and security by default' }
    }
}

function Get-DecisionPrompts {
    param(
        [string]$TopicTitle,
        [string]$OptimizationAxis
    )

    return @(
        "Two designs both satisfy the happy path for $TopicTitle. Which choice is most correct?",
        "What should you validate first before choosing an architecture for $($TopicTitle)?",
        "A proposal lowers cost but increases failure risk. What is the best decision?",
        "Which option best reflects optimization for $($OptimizationAxis)?",
        "How should you evaluate a design that needs frequent manual interventions?",
        "Two options have similar latency. Which tie-breaker is best?",
        "What is the best way to choose between a custom stack and a managed service?",
        "How do you confirm a solution is production-ready for $TopicTitle?",
        "Which pattern usually wins in ACE scenario tie-breakers?",
        "What is the best final check before locking the answer?"
    )
}

function Get-DecisionAnswers {
    param([string]$OptimizationAxis)

    return @(
        'Choose the option that preserves reliability and security while reducing operational burden.',
        'Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.',
        'Reject it unless reliability and recovery objectives remain within required targets.',
        "Select the design that best meets $OptimizationAxis while keeping constraints balanced.",
        'Treat it as high risk and prefer automation-friendly designs with observability and rollback.',
        'Pick the option with stronger operability, clearer failure isolation, and simpler incident response.',
        'Prefer managed services when they meet requirements with lower long-term maintenance effort.',
        'Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.',
        'Managed-service-first plus least-privilege access plus clear observability usually wins.',
        'Run a weighted check across security, reliability, cost, performance, and operability.'
    )
}

function Build-Questions {
    param(
        [hashtable]$Profile,
        [string]$TopicTitle,
        [int]$QuestionCount,
        [string]$OptimizationAxis
    )

    $letters = @('A', 'B', 'C', 'D')
    $decisionPrompts = Get-DecisionPrompts -TopicTitle $TopicTitle -OptimizationAxis $OptimizationAxis
    $decisionAnswers = Get-DecisionAnswers -OptimizationAxis $OptimizationAxis
    $baseCount = [Math]::Min($Profile.prompts.Count, $Profile.correct.Count)
    $sb = New-Object System.Text.StringBuilder

    for ($i = 0; $i -lt $QuestionCount; $i++) {
        if ($i -lt $baseCount) {
            $prompt = $Profile.prompts[$i]
            $correct = $Profile.correct[$i]
        }
        else {
            $idx = ($i - $baseCount) % $decisionPrompts.Count
            $prompt = $decisionPrompts[$idx]
            $correct = $decisionAnswers[$idx]
        }

        $t1 = $Profile.traps[$i % $Profile.traps.Count]
        $t2 = $Profile.traps[($i + 1) % $Profile.traps.Count]
        $t3 = $Profile.traps[($i + 2) % $Profile.traps.Count]

        $answer = $letters[$i % $letters.Count]
        $optA = ''
        $optB = ''
        $optC = ''
        $optD = ''

        switch ($answer) {
            'A' { $optA = $correct; $optB = $t1; $optC = $t2; $optD = $t3 }
            'B' { $optA = $t1; $optB = $correct; $optC = $t2; $optD = $t3 }
            'C' { $optA = $t1; $optB = $t2; $optC = $correct; $optD = $t3 }
            'D' { $optA = $t1; $optB = $t2; $optC = $t3; $optD = $correct }
        }

        [void]$sb.AppendLine("#### Q$($i + 1)")
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine("Scenario Focus: $TopicTitle")
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine($prompt)
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine("A. $optA  ")
        [void]$sb.AppendLine("B. $optB  ")
        [void]$sb.AppendLine("C. $optC  ")
        [void]$sb.AppendLine("D. $optD")
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine("Answer: $answer  ")
        [void]$sb.AppendLine('Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  ')
        [void]$sb.AppendLine('Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.')
        [void]$sb.AppendLine('')
    }

    return $sb.ToString().TrimEnd()
}

function Build-EnrichmentBlock {
    param(
        [string]$Title,
        [string]$Category,
        [hashtable]$Profile,
        [string]$StartMarker,
        [string]$EndMarker,
        [int]$QuestionsPerNote
    )

    $optimizationAxis = Get-PrimaryOptimizationAxis -Category $Category
    $questions = Build-Questions -Profile $Profile -TopicTitle $Title -QuestionCount $QuestionsPerNote -OptimizationAxis $optimizationAxis

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add($StartMarker)
    $lines.Add('## ACE Deep Enrichment')
    $lines.Add('')
    $lines.Add('### Think Like a Google Engineer')
    $lines.Add("- Primary optimization axis: $optimizationAxis.")
    $lines.Add('- Start with constraints first: SLO, security, compliance, latency, budget, and team operations capacity.')
    $lines.Add('- Prefer managed services if they satisfy requirements with lower long-term operational toil.')
    $lines.Add('- Minimize blast radius using environment isolation, least privilege, and failure-domain awareness.')
    $lines.Add('- Design for day-2 operations: observability, rollback strategy, and quota or budget guardrails.')
    $lines.Add('')
    $lines.Add('### Most Correct Option Filter (60 Seconds)')
    $lines.Add('1. Eliminate options with broad access, single points of failure, or missing monitoring.')
    $lines.Add('2. Confirm the option meets non-negotiables first: security and reliability requirements.')
    $lines.Add('3. Compare remaining options on operational simplicity and long-term maintainability.')
    $lines.Add('4. Use cost as an optimizer only after requirements and risk controls are satisfied.')
    $lines.Add('')
    $lines.Add('### Weighted Decision Matrix')
    $lines.Add('| Dimension | Weight | Strong Signal |')
    $lines.Add('| --- | --- | --- |')
    $lines.Add('| Security | 3 | Least privilege, secure defaults, no exposed blast radius |')
    $lines.Add('| Reliability | 3 | Multi-zone or HA design, health checks, tested recovery path |')
    $lines.Add('| Operability | 2 | Clear monitoring, alerting, rollout and rollback simplicity |')
    $lines.Add('| Cost Efficiency | 2 | Right-sized resources, no waste, no reliability regression |')
    $lines.Add('| Performance | 1 | Meets latency and throughput targets with headroom |')
    $lines.Add('')
    $lines.Add('### Real-Life Scenario')
    $lines.Add($Profile.scenario)
    $lines.Add('')
    $lines.Add('### Worked Example')
    foreach ($step in $Profile.example) {
        $lines.Add("- $step")
    }
    $lines.Add('')
    $lines.Add('### Flowchart')
    $lines.Add('```mermaid')
    foreach ($l in $Profile.flowchart) {
        $lines.Add($l)
    }
    $lines.Add('```')
    $lines.Add('')
    $lines.Add('### Optimization Decision Flow')
    $lines.Add('```mermaid')
    $lines.Add('flowchart TD')
    $lines.Add('    A[Read Requirement] --> B[Identify Hard Constraints]')
    $lines.Add('    B --> C{Security and Reliability Met?}')
    $lines.Add('    C -->|No| D[Reject Option]')
    $lines.Add('    C -->|Yes| E[Score Operability and Cost]')
    $lines.Add('    E --> F{Managed Service Meets Needs?}')
    $lines.Add('    F -->|Yes| G[Prefer Managed Path]')
    $lines.Add('    F -->|No| H[Use Custom Design with Guardrails]')
    $lines.Add('    G --> I[Validate Observability and Rollback]')
    $lines.Add('    H --> I')
    $lines.Add('    I --> J[Pick Highest Weighted Score]')
    $lines.Add('```')
    $lines.Add('')
    $lines.Add('### Interaction Sequence')
    $lines.Add('```mermaid')
    foreach ($l in $Profile.sequence) {
        $lines.Add($l)
    }
    $lines.Add('```')
    $lines.Add('')
    $lines.Add("### Extra Exam Practice ($QuestionsPerNote Questions)")
    $lines.Add($questions)
    $lines.Add('')
    $lines.Add('### Quick Commands')
    $lines.Add('```bash')
    foreach ($cmd in $Profile.commands) {
        $lines.Add($cmd)
    }
    $lines.Add('```')
    $lines.Add('')
    $lines.Add('### Fast Recall')
    foreach ($item in $Profile.recall) {
        $lines.Add("- $item")
    }
    $lines.Add($EndMarker)

    return ($lines -join "`n")
}

$files = Get-ChildItem -Path $notesDir -Filter '*.md' | Sort-Object Name
if ($ExcludeMixFiles) {
    $files = $files | Where-Object { -not $_.Name.ToLowerInvariant().Contains('_mix_topics_') }
}
if ($Limit -gt 0) {
    $files = $files | Select-Object -First $Limit
}

if ($files.Count -eq 0) {
    throw 'No matching markdown files were found for enrichment.'
}

if ($QuestionsPerNote -lt 6 -or $QuestionsPerNote -gt 20) {
    throw 'QuestionsPerNote must be between 6 and 20 for balanced note size and readability.'
}

$updated = 0
$created = 0

foreach ($file in $files) {
    $raw = [System.IO.File]::ReadAllText($file.FullName)
    $eol = if ($raw.Contains("`r`n")) { "`r`n" } else { "`n" }

    $title = Get-NoteTitle -Content $raw -FallbackName $file.Name
    $category = Get-Category -FileName $file.Name -Title $title
    $profile = Get-Profile -Category $category
    $block = Build-EnrichmentBlock -Title $title -Category $category -Profile $profile -StartMarker $startMarker -EndMarker $endMarker -QuestionsPerNote $QuestionsPerNote

    $withoutOld = [regex]::Replace($raw, $blockRegex, '')
    $trimmed = $withoutOld.TrimEnd()

    if ([string]::IsNullOrWhiteSpace($trimmed)) {
        $newContent = $block
    }
    else {
        $newContent = "$trimmed`n`n$block"
    }

    $normalized = $newContent -replace "`r`n", "`n"
    if ($eol -eq "`r`n") {
        $normalized = $normalized -replace "`n", "`r`n"
    }

    if ($raw -eq $normalized) {
        continue
    }

    if (-not $DryRun) {
        [System.IO.File]::WriteAllText($file.FullName, $normalized, (New-Object System.Text.UTF8Encoding($false)))
    }

    if ($raw -match [regex]::Escape($startMarker)) {
        $updated++
    }
    else {
        $created++
    }
}

Write-Output "Files scanned: $($files.Count)"
Write-Output "Enrichment blocks updated: $updated"
Write-Output "Enrichment blocks created: $created"
Write-Output "Dry run: $DryRun"
