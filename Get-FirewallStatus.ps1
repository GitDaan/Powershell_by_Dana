#Requires -Version 3.0
 
 function Get-FirewallStatus
 {
 <#
 .Synopsis
    Determines status of Firewall 
 .DESCRIPTION
    Gives a true/false on the status of the domain firewall for the node referenced in the function call
 .EXAMPLE
    Get-FirewallStatus <computer/server name>
 .EXAMPLE
    Get-FirewallStatus -cn <computer/server name> (-cn is a parameter alias)
 .INPUTS
    Node to check (server/workstation)
 .OUTPUTS
    [bool]
 .NOTES
    File Name: Get-FirewallStatus  
    Date Create: May 9, 2017
    Author: Dana C. Andrews
    Contact: dandrews@co.grant.wi.gov
    Current Version: 1.0
 .COMPONENT
    Firewall
 .ROLE
    IT 
 .FUNCTIONALITY
    Diagnostic
 #>
 
     [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                   SupportsShouldProcess=$true, 
                   PositionalBinding=$true)]
     [Alias('GFS')]
     [OutputType([String])]
     Param
     (
         # Param1 help description
         [Parameter(Mandatory=$true, 
                    ValueFromPipeline=$true,
                    ValueFromPipelineByPropertyName=$true, 
                    ValueFromRemainingArguments=$false, 
                    Position=0,
                    ParameterSetName='Parameter Set 1')]
         [ValidateCount(0,16)]
         [Alias("CN")] 
         [string]$computer = $env:computername
     ) 
Begin
{
     $HKLM = 2147483650
    }#end Begin
Process
{
    if ($pscmdlet.ShouldProcess("Target", "Operation"))
    { 
    $HKLM = 2147483650 
    $reg = get-wmiobject -list -namespace root\default -computer $computer | where-object { $_.name -eq "StdRegProv" }
    $firewallEnabled = $reg.GetDwordValue($HKLM, "System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile","EnableFirewall")    
    }#End If $pscmdlet
    }#end Process
End
{
    [bool]($firewallEnabled.uValue)
    }#end End
}#End Function