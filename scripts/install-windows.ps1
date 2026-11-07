$ErrorActionPreference = 'Stop'
$Repo = Split-Path -Parent $PSScriptRoot
function Set-ConfigLink([string]$Source, [string]$Target) {
    $Existing = Get-Item -LiteralPath $Target -Force -ErrorAction SilentlyContinue
    if ($Existing) {
        if ($Existing.LinkType -and $Existing.Target -eq $Source) {
            Write-Host "Already linked: $Target"
            return
        }
        $Backup = "$Target.backup.$(Get-Date -Format 'yyyyMMddHHmmss')"
        if (Test-Path -LiteralPath $Backup) { throw "Backup already exists: $Backup" }
        Move-Item -LiteralPath $Target -Destination $Backup
        Write-Host "Backed up: $Backup"
    }
    New-Item -ItemType Junction -Path $Target -Target $Source | Out-Null
    Write-Host "Linked: $Target"
}
New-Item -ItemType Directory -Force -Path $env:LOCALAPPDATA, "$HOME\.config" | Out-Null
Set-ConfigLink (Join-Path $Repo 'nvim') (Join-Path $env:LOCALAPPDATA 'nvim')
Set-ConfigLink (Join-Path $Repo 'wezterm') (Join-Path $HOME '.config\wezterm')
