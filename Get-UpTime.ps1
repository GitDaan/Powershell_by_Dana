<#
    This little script is the basis for displaying the uptime of a workstation in a more human readable form.
    It works locally. It needs to be updated to work remotely. 
    This one is meant to be added to Grant.Module and, possibly, added to existing Get-Inventory.ps1

#>
function Get-UpTime {
$date = Get-Date
$os = Get-WmiObject -Class Win32_OperatingSystem
$uptime = $os.ConvertToDateTime($os.lastbootuptime)
$Up = ($date - $uptime)
$Result = $Up.Days.ToString() + " days, " + $Up.Hours.ToString() + " Hours, " + $Up.Minutes.ToString() + " Minutes, " + $Up.Seconds.ToString() + " seconds."
Write-Output "Workstation has been up for $Result"
}