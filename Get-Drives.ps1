<#
    .SYNOPSIS
  <Overview of script>
.DESCRIPTION
  <Brief description of script>
.PARAMETER <Parameter_Name>
    <Brief description of parameter input required. Repeat this attribute if required>
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
.NOTES
  Version:        1.0
  Author:         <Name>
  Creation Date:  <Date>
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>

#>

function Get-Drives {
    Clear-Host
    $Disk = Get-WmiObject win32_logicaldisk 
    Foreach ($Drive in $Disk) {
        Switch ($Drive.DriveType) 
        {
        1{ $Drive.DeviceID + " Unknown"; Break } 
        2{ $Drive.DeviceID + " Floppy or Removable Drive"; Break } 
        3{ $Drive.DeviceID + " Hard Drive"; Break } 
        4{ $Drive.DeviceID + " Network Drive"; Break } 
        5{ $Drive.DeviceID + " CD"; Break } 
        6{ $Drive.DeviceID + " RAM Disk"; Break }
        Default {"unknown device"} 
    }
  }
}