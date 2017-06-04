function Get-ServiceInfo {
$r = $host.ui.Prompt("SERVER REPORTING","Enter values for these settings:",@("Computername","Domain","Service Name","Status"))
$s = New-Object -TypeName PSObject -Property $r
$s.Computername
}