#requires -Version 3.0
#Pnote - Other requires can be PSSnapin, Modules, ShellId, RunAsAdministrator
 
Function Get-FirewallProfile  {
<# 
 .NOTES
    Script Name: 
    Version:
    Creation Date: 
    Last Modify:
    Author: Dana Andrews
    Location: Grant County, Wisconsin
    Contact: dandrews@co.grant.wi.gov
    
.Synopsis
  Some short statement  

.Description
   Lots of words that basically re-states the above. Plus any needed discussions

.Functionality
    What's it purpose in life?
.InputType
    Whatcha going to be working with?

.ReturnValue
    Whatcha gonna get in return

.Version History
        Version 1.0 - Initial Creation

.Link
  https://

.Alias
    If you set it, don't forget it...

.Parameter <name>
    Note if it is mandatory, Note position, Note qualifiers (like Accepts value from a pipeline)
    One entry for each parameter (these are public/global parameters. Internal only do not need to be documented here)
    
.Example
   # Basic
   Show a filled out example. One Example per example (try to do one for each possible variation of entry)

#>

[cmdletbinding(SupportsShouldProcess=$true, ConfirmImpact="Medium")]
Param(
		[parameter (Mandatory=$True, position=1, valueFromPipeline=$true,
                                 ValueFromPipelineByPropertyName=$True,
                HelpMessage='The NetBios Name of the Computer/Server')]
         [ValidateLength(7,8)] #specifies the minimum, and maximum, characters allowed	
		 [string] $ComputerName,
		 [PSObject] $Profile = "AllProfiles"
	     ) #end of param

BEGIN {
            
    } #end of begin

PROCESS {
         if ($pscmdlet.ShouldProcess($ComputerName)) {
          
        netsh -r $ComputerName advfirewall show $Profile
   
            
           } # end of ShouldProcess
        }  #end of process              
   
END {
             
    } #end of end

 } #end of function

 If((Test-Path alias:Firewall) -eq $false) {New-Alias -Name Firewall   -Value Get-FirewallProfile }