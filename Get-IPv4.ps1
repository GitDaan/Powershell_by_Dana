#Requires -Version 1.0

function Get-IPv4 {
<#
.Synopsis
   Gets the IP address from a computer name
.DESCRIPTION
   This function returns the IP address of the non-loopback (localhost) adapter for the given netbios name
.EXAMPLE
   Get-IPv4 <computername>
.EXAMPLE
   Get-IPv4 (Get-content -path <path to flat file of computernames>
.INPUTS
   [string] or [array]
.OUTPUTS
   [string]
.NOTES
   File Name: Get-IPv4.ps1  
   Date Create: May 24, 2017
   Author: Dana Andrews
   Contact: dandrews@co.grant.wi.gov
   Current Version: 1.0
.COMPONENT
   Netadapter
.ROLE
   Network
.FUNCTIONALITY
   Workstation Information
#>

[CmdletBinding(DefaultParameterSetName='ComputerName', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$true)]

[Alias('GIP')]
[OutputType([String],[Array])]

param(
     [Parameter(Mandatory=$true, 
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true, 
                Position=0,
                ParameterSetName='ComputerName')]
    [string[]]$ComputerName
    )

Begin{
        If ((Get-Service WinRM -ComputerName $ComputerName -ErrorVariable IPv4Errors -ErrorAction SilentlyContinue).Status -eq "stopped") { (Get-Service WinRM -ComputerName $ComputerName).Start() }
    }#begin
Process {
    Try {
    Get-NetIPAddress -CimSession $ComputerName -AddressFamily ipv4 -ErrorAction Stop | where {$_.InterfaceAlias -notmatch 'loopback'} | Select PSComputername, IpAddress
    } Catch {
        Write-Warning 'Unable to resolve address'
    }#try/catch
}#process

End{
    If ($IPv4Errors.Count -gt 0) {Write-host -ForegroundColor Red "Failure Category: $($IPv4Errors[0].CategoryInfo.Category)"
                                  Write-host -ForegroundColor Red "Target Miss: $($IPv4Errors.CategoryInfo.TargetName)" 
                                  Write-host -ForegroundColor Red "Failing command: $($IPv4Errors[0].InvocationInfo.InvocationName)"
                                  }#if
}#end

}#function
