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
Set-ConfigLink (Join-Path $Repo 'shell') (Join-Path $HOME '.config\dotfiles-shell')
$ProfilePath = $PROFILE.CurrentUserCurrentHost
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $ProfilePath) | Out-Null
$Hook = '# dotfiles shell configuration'
$ExistingProfile = if (Test-Path -LiteralPath $ProfilePath) { Get-Content -LiteralPath $ProfilePath -Raw } else { '' }
if ($ExistingProfile -notmatch [regex]::Escape($Hook)) {
    $Lines = @('', $Hook, '. "$HOME\.config\dotfiles-shell\powershell\profile.ps1"')
    Add-Content -LiteralPath $ProfilePath -Value $Lines -Encoding UTF8
    Write-Host "Added shell configuration to: $ProfilePath"
}

if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw 'Install Oh My Posh or winget, then rerun this installer.'
    }
    winget install --id JanDeDobbeleer.OhMyPosh --exact --source winget --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) { throw "winget failed to install Oh My Posh (exit code $LASTEXITCODE)." }
    Write-Host 'Restart PowerShell to load Oh My Posh.'
}
