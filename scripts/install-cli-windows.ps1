$ErrorActionPreference = 'Stop'
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) { throw 'winget is required.' }
$Packages = @(
    'junegunn.fzf',
    'ajeetdsouza.zoxide',
    'BurntSushi.ripgrep.MSVC',
    'sharkdp.fd',
    'sharkdp.bat',
    'JesseDuffield.lazygit'
)
foreach ($Package in $Packages) {
    winget install --id $Package --exact --source winget --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) { throw "winget failed for $Package (exit code $LASTEXITCODE)." }
}
