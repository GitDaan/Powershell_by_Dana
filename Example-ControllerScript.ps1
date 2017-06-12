Clear-Host
Write-Host "========================================="
Write-Host "             Support Menu                "
Write-Host "========================================="
Write-Host ""
Write-Host " A. Retrieve OS information"
Write-Host " B. Query IP address information"
Write-Host ""
Write-Host " X. Cancel and quit"
Write-Host ""
$Choice = Read-Host "Enter Selection"

Switch ($Choice) {
    "A" { Get-WmiObject -Class Win32_OperatingSystem}
    "B" {Get-NetAdapter}
    }#switch