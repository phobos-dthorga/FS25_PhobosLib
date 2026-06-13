param(
    [string]$LogPath,
    [string]$GameUserDir,
    [string]$SummaryJson,
    [switch]$FailOnOwnedWarning
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
$python = $env:PYTHON
if ([string]::IsNullOrWhiteSpace($python)) {
    $python = "python"
}

$argsList = @((Join-Path $repoRoot "tools\triage_log.py"))
if (-not [string]::IsNullOrWhiteSpace($LogPath)) {
    $argsList += @("--log", $LogPath)
}
if (-not [string]::IsNullOrWhiteSpace($GameUserDir)) {
    $argsList += @("--game-user-dir", $GameUserDir)
}
if (-not [string]::IsNullOrWhiteSpace($SummaryJson)) {
    $argsList += @("--summary-json", $SummaryJson)
}
if ($FailOnOwnedWarning) {
    $argsList += "--fail-on-owned-warning"
}

& $python @argsList
exit $LASTEXITCODE
