#requires -Version 3.0
 
function Reverse-Lookup  {
<# 
 .NOTES
    Script Name: Reverse-Lookup.psm1
    Version: 1.1
    Creation Date: April 21, 2017 
    Last Modify: April 24, 2017
    Author: Dana Andrews
    Location: Grant County, Wisconsin
    Contact: dandrews@co.grant.wi.gov
    
.Synopsis
  Looks for a machine name from an IP address  

.Description
   Looks for the computer name from a reverse DNS search

.Functionality
    Find NetBios name from IP address

.InputType [String]
    IP Address

.ReturnValue Object
    FQDN

.Version History
        Version 1.0 - Initial Creation
        Version 1.1 - Update

.Link
  http://blog.forrestshields.com/post/2012/08/01/Resolving-Reverse-DNS-Lookups-in-PowerShell.aspx

.Alias
    RL

.Parameter IP
    Mandatory - IPv4 address to resolve (4 triples). Not tested with IPv6 but should work
    
.Example Basic
   Show a filled out example. One Example per example (try to do one for each possible variation of entry)

#>
[cmdletbinding()]
param (
 [string]$IP
 )
 
 Begin {}

 Process {
    $S = [System.Net.DNS]::GetHostentry($IP); $S.HostName
    }

} #end Function

    If((Test-Path alias:rl) -eq $false){New-Alias -name RL -Value Reverse-Lookup}