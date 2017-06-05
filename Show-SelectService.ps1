#requires -Version 3.0

$AlertColors = @{ForegroundColor = "White"; BackgroundColor = "Red"} 

Function Show-SelectService  {
<# 
 .NOTES
    Script Name: Show-SelectService.ps1
    Version: 1.0
    Creation Date: April 26, 2017
    Last Modify: N/A
    Author: Dana Andrews
    Location: Grant County, Wisconsin
    Contact: dandrews@co.grant.wi.gov

.Synopsis
  Check the status of a group of similar services  

.Description
   Originally written to check the status of the NetSmart services on
   HEALL, this function has optional parameters that will allow you
   to do the same thing on any server, for any group that can be identified
   by a wildcard. Options include server, service, and status (running, stopped)
   
.Functionality
    Checks the status of a group of services on a server

.Inputs
    Optional server, service, status

.Outputs
    GridView of services and their status

.Link
  None, figured it out all by my pretty lonesome self (I'm awesome like that).

.Component
  System.ServiceProcess.ServiceController (Get-Service)  

.Role
  Server or Network administration    

.Server
    NetBios Name or IP of the server to be checked. Default is HEALL

.Service
    The service group to be checked. Uses wildcards (* ?) Default is
    MHC_*

.Status
    You can look for a specific status like "running" or "stopped"
        
.Example Basic
   Show-SelectService (no mandatory parameters, will be Heall for MHC_*

#>

[cmdletbinding()]
Param(
	[parameter (Mandatory=$false, position=1, HelpMessage='Enter the server name')]
         [String] $Server = 'HEALL',
     [parameter (Mandatory=$false, position=2, HelpMessage='Enter service name with wildcard')]
		 [String] $Service = 'MHC_*'
	     ) #end of param

BEGIN {
      
                
    } #end of begin

PROCESS {      
        $z = @{Expression={$_.Name};Label="Name";width=25},@{Expression={$_.Status};Label="Status";width=15}
$S = foreach ($A in (Get-Service -name $Service -ComputerName $Server)) `
{ $A | Select-Object Name, Status} ; $S | ogv
   $Server
   $Service   
 }  #end of process              
   
END {
             
    } #end of end

 } #end of function

 #If((Test-Path alias:<alias>) -eq $false) {New-Alias -Name   -Value }

 <#
 Version History
        Version 1.0 - Initial Creation
 #>