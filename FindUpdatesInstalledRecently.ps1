function DoIHaveThatKB($HowManyMonths) {
Get-CimInstance -Class win32_quickfixengineering | Where-Object { $_.InstalledOn -gt (Get-Date).AddMonths(-$HowManyMonths) }
}
function LookingForKB($KBNumber) {
If (Get-CimInstance -Class win32_quickfixengineering | Where-Object { $_.HotFixID -eq "KB"+$KBNumber }) {
Get-CimInstance -Class win32_quickfixengineering | Where-Object { $_.HotFixID -eq "KB"+$KBNumber } | Select-Object -Property InstalledOn
}
Else
{
Write-Output "KB$KBNumber Not Found"
}
}