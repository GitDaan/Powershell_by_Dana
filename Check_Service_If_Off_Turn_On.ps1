$Computer=(Get-ChildItem env:computername).value
$srvname='Spooler'
$logfile='C:\ServiceStatus.txt'

if($service=get-service $srvname -Computername $Computer){
     if($service.status -eq 'Running'){
         Write-output "$srvname service is already started and running: $([datetime]::Now)" | Out-File $logfile -Append
     }else{
          Start-Service $service
          Write-output "$srvname was stopped, Service started now: $([datetime]::Now)" | Out-File $logfile -Append
     }
}else{
     Write-output "$srvname service not found on $Computer : $([datetime]::Now)" | Out-File $logfile -Append
}