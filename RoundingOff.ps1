$Disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='c:'"
$FreeSpace = $Disk.freespace / 1gb -as [int] #better than [system.Math]::Round($Disk.freespace,0)

Write-Output "Space available on C: disk is approximately $FreeSpace GB"