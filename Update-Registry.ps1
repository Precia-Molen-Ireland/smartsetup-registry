# Pull the latest registry and rebuild the zip that TMS Smart Setup reads.
#
# Smart Setup reads <this folder>.zip (registered as server "pmi"), not the
# folder itself, so run this after editing or pulling a tmsbuild.yaml and
# before "tms install" / "tms update".
#
#   .\Update-Registry.ps1            pull, then re-zip
#   .\Update-Registry.ps1 -NoPull    re-zip only (local edits not yet committed)
#
# GenMobileMultiTenancy\Build.ps1 does the same thing on every run, so this
# script is for working with Smart Setup by hand.
[CmdletBinding()]
param(
    [switch]$NoPull
)

$ErrorActionPreference = 'Stop'
$registry = $PSScriptRoot
$zip = "$registry.zip"

if (-not $NoPull) {
    git -C $registry pull --ff-only --quiet
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "git pull failed (offline, or local changes not committed?) - zipping the current contents anyway"
    }
}

# Only the product folders go into the zip. Smart Setup ignores everything
# else, and .git must stay out of it.
$products = Get-ChildItem $registry -Directory | Where-Object { $_.Name -notlike '.*' }
if (-not $products) {
    throw "No product folders found in $registry"
}
foreach ($p in $products) {
    if (-not (Test-Path (Join-Path $p.FullName 'tmsbuild.yaml'))) {
        throw "$($p.Name) has no tmsbuild.yaml"
    }
}

Compress-Archive -Path ($products | Select-Object -ExpandProperty FullName) -DestinationPath $zip -Force
Write-Host "Rebuilt $zip with $($products.Count) product(s): $(($products.Name | Sort-Object) -join ', ')"

# Remind if Smart Setup does not know this zip yet.
$tms = Join-Path (Split-Path -Parent $registry) 'tms\tms.exe'
if (Test-Path $tms) {
    Push-Location (Split-Path -Parent $tms)
    try {
        $servers = & $tms server-list 2>&1
        if (-not ($servers -match '^pmi:')) {
            Write-Host "Smart Setup has no 'pmi' server yet. Register it with:" -ForegroundColor Yellow
            Write-Host "  tms server-add pmi zipfile file://$zip" -ForegroundColor Yellow
        }
    }
    finally {
        Pop-Location
    }
}
