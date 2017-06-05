function Check-CPULoad {
<#
.Synopsis
   Spot check CPU load on a server
.DESCRIPTION
   Uses Get-Counter
.EXAMPLE
   Check-CPULoad -CN adadmin
.INPUTS
   [string] Computername
.OUTPUTS
   Console
.NOTES
   Version: 1.0
   Creation Date: May 3, 2017
   Last Modify: N/A
   Author: Dana Andrews
   Location: Grant County, Wisconsin
   Contact: dandrews@co.grant.wi.gov
   Link: https://social.technet.microsoft.com/Forums/windowsserver/en-US/b9d86bdc-9ea8-4659-ae65-4c1b5b86d324/powershell-scripts-to-get-overall-cpu-usage-from-list-of-servers?forum=winserverpowershell
.COMPONENT
   Server
.ROLE
   I.T.
.FUNCTIONALITY
   2 second check of resource CPU load
#>

[Alias('CCPU')]
[cmdletbinding()]
Param(
[parameter (Mandatory=$true)]	
[string]$CN
)

Begin {}
Process {
$proc =get-counter -ComputerName $CN -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 
$cpu=($proc.readings -split ":")[-1]
}
End {
	$temp = [Math]::Round($cpu,2)
    Write-Output "$temp %"
}
}