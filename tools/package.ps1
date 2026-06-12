param(
    [string]$SourcePath,
    [string]$OutputPath
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

if ([string]::IsNullOrWhiteSpace($SourcePath)) {
    $SourcePath = "."
}

if ([System.IO.Path]::IsPathRooted($SourcePath)) {
    $modRoot = $SourcePath
} else {
    $modRoot = Join-Path $repoRoot $SourcePath
}

if (-not (Test-Path -LiteralPath $modRoot -PathType Container)) {
    throw "Mod source folder not found: $modRoot"
}

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $repoRoot "dist\FS25_PhobosLib.zip"
}

$resolvedOutputParent = Split-Path -Parent $OutputPath
if ([string]::IsNullOrWhiteSpace($resolvedOutputParent)) {
    $resolvedOutputParent = Get-Location
}

New-Item -ItemType Directory -Force -Path $resolvedOutputParent | Out-Null

if (Test-Path -LiteralPath $OutputPath) {
    Remove-Item -LiteralPath $OutputPath -Force
}

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$repoRootPath = (Resolve-Path -LiteralPath $repoRoot).Path.TrimEnd("\", "/")
$modRootPath = (Resolve-Path -LiteralPath $modRoot).Path.TrimEnd("\", "/")
$modRootPrefix = $modRootPath + [System.IO.Path]::DirectorySeparatorChar
$sourceIsRepoRoot = $modRootPath -eq $repoRootPath
$rootFiles = @(
    "modDesc.xml",
    "icon.dds",
    "LICENSE",
    "LICENSE-CC-BY-NC-SA.txt"
)
$rootPrefixes = @(
    "src/",
    "languages/",
    "xml/",
    "objects/",
    "textures/",
    "sounds/"
)

function Test-PackageEntryAllowed {
    param(
        [string]$EntryName,
        [bool]$SourceIsRepoRoot
    )

    if (-not $SourceIsRepoRoot) {
        return $true
    }

    if ($rootFiles -contains $EntryName) {
        return $true
    }

    foreach ($prefix in $rootPrefixes) {
        if ($EntryName.StartsWith($prefix, [System.StringComparison]::Ordinal)) {
            return $true
        }
    }

    return $false
}

$archive = [System.IO.Compression.ZipFile]::Open($OutputPath, [System.IO.Compression.ZipArchiveMode]::Create)

try {
    Get-ChildItem -LiteralPath $modRootPath -Recurse -File -Force | ForEach-Object {
        $relativePath = $_.FullName.Substring($modRootPrefix.Length)
        $entryName = $relativePath.Replace([System.IO.Path]::DirectorySeparatorChar, "/")
        $entryName = $entryName.Replace([System.IO.Path]::AltDirectorySeparatorChar, "/")

        if (-not (Test-PackageEntryAllowed -EntryName $entryName -SourceIsRepoRoot $sourceIsRepoRoot)) {
            return
        }

        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $archive,
            $_.FullName,
            $entryName,
            [System.IO.Compression.CompressionLevel]::Optimal
        ) | Out-Null
    }
}
finally {
    $archive.Dispose()
}

Write-Output "Created $OutputPath"
