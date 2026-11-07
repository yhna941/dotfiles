# Shared interactive PowerShell settings (PowerShell 7 recommended).
if (Get-Module -ListAvailable PSReadLine) {
    Import-Module PSReadLine
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    if ((Get-Command Set-PSReadLineOption).Parameters.ContainsKey('PredictionSource')) {
        Set-PSReadLineOption -PredictionSource History
    }
    if ((Get-Command Set-PSReadLineOption).Parameters.ContainsKey('PredictionViewStyle')) {
        Set-PSReadLineOption -PredictionViewStyle InlineView
    }
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# Oh My Posh supplies the prompt; PSReadLine handles completion and history.
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh | Invoke-Expression
}
