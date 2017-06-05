#Requires -Version 2.0

function Get-LoggedOnUser {
<#
.Synopsis
   Find out who's logged on
.DESCRIPTION
   Who dat who say 'Who dat'? Reads the Win32_ComputerSystem for the username
.EXAMPLE
   Get-LoggedOnUser <node netbios name>
.INPUTS
   Server/Workstation name
.OUTPUTS
   [String[]
.NOTES
   File Name: Get-LoggedOnUser.ps1   
   Date Create: May 9, 2017
   Author: Dana C Andrews
   Contact: dandrews@co.grant.wi.gov
   Current Version:1.0
   Links: https://4sysops.com/archives/how-to-find-a-logged-in-user-remotely-using-powershell/
.COMPONENT
   Win32_ComputerSystem
.ROLE
   IT
.FUNCTIONALITY
   Diagnostic
#>

    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                   SupportsShouldProcess=$true, 
                   PositionalBinding=$true)]
    [Alias("GLU")]
    [OutputType([PSCustomObject])]

    Param (
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   Position=1,
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(1,16)]
        [String[]] $ComputerName        
    )

    Begin { }#Begin

    Process {
        if ($pscmdlet.ShouldProcess($ComputerName)) {
	    Try {
             ForEach-Object -InputObject $ComputerName -ErrorAction Stop  {
                $output = @{ 'ComputerName' = $_ }
                $output.UserName = (Get-WmiObject -Class win32_computersystem -ComputerName $_).UserName
                [PSCustomObject]$output                  
                     }
	        } Catch {
			         Write-Warning "O.M.G. There are errors."
			        }#catch
                }#$pscmdlet
           }#Process

    End {        
        }#End
}#End Function