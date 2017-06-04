WorkFlow Get-EventLogData

{

 Parallel

 {
 Get-WinEvent -LogName Application -MaxEvents 100 | Where-Object {$_.TimeCreated -gt [DateTime]::Today.AddDays(-1) -and $_.LevelDisplayName -eq "Error"}
 Get-WinEvent -LogName System -MaxEvents 100 | Where-Object {$_.TimeCreated -gt [DateTime]::Today.AddDays(-1) -and $_.LevelDisplayName -eq "Error"}
 Get-WinEvent -LogName "Windows Powershell" -MaxEvents 100 | Where-Object {$_.TimeCreated -gt [DateTime]::Today.AddDays(-1) -and $_.LevelDisplayName -eq "Error"}
 }}