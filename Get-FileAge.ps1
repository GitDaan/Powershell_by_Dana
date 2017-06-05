#requires -Version 4.0

Function Get-FileAge {
<#
    .Note
        Author: Dana C. Andrews
        Creation: April 18, 2017
        Last Modified: N/A
        Version: 1.0
        Contact: dandrews@co.grant.wi.gov

    .Link
        https://technet.microsoft.com/en-us/library/ff730948.aspx (This website is about Expressions)
    
    .Example Simple
        get-FileAge -Which_Directory C:\Windows\temp

    .Example Sort
        Get-FileAge -Which_Directory C:\Windows\temp | Sort-Object -Property "Age in Days"
#>

[cmdletbinding()]
Param (
    [Parameter (Mandatory=$true, Position=1)]
    [PSObject] $Which_Directory 
        )

Get-ChildItem -Path $Which_Directory | Select-Object @{Name="Name";Expression={$_.name.ToUpper()}},`
 @{Name="Age in days";Expression={(((Get-Date) - $_.Creationtime).Days)}}


}