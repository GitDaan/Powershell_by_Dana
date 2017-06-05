 function ChangeIPv6($choice) {
 Write-Output "`n Pre-Change settings: "
 Get-NetAdapterBinding | ? {$_.ComponentID -eq "ms_tcpip6"} | Write-Output
 If ($choice -eq "Disable") {
 Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_tcpip6
 }
 Else
 {
 Enable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_tcpip6
 }
 Write-Output "`nPost-Change settings:`n"
 Get-NetAdapterBinding | ? {$_.ComponentID -eq "ms_tcpip6"} | Write-Output
  }