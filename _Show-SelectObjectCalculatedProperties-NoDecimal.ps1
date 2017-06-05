Get-ChildItem  -Path C:\BPS |
 Select-Object Name, @{Name="Kb";Expression={ "{0:N0}" -f ($_.Length / 1Kb) + " kb" }}