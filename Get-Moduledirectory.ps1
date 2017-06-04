#requires -Version 2
<#
.SYNOPSIS
    Opens Powershell module directory (user location)
.DESCRIPTION 
    Opens the directory where Powershell looks for $User module folders  
.FUNCTIONALITY 
    To quickly open the user's modules folder

.PARAMETER N/A
      There are no parameters, it is automagical
.INPUTTYPE
    None
.RETURNVALUE
    directory
.LINK
    http://www.powershellmagazine.com/2014/03/12/get-started-with-pester-powershell-unit-testing-framework/
    (about a third of the way down)
     
.NOTES
  File Name: Get-ModuleDirectory
  Creation Date: 9 April 2017
  Last Modified: N/A
  Version: 1.0
  Author: I stole it from Powershell Magazine (online)

.VERSION HISTORY
    1.00 Original theft and modification
  
.Alias openmod

.EXAMPLE
    Get-ModuleDirectory

#>

If ((Test-Path alias:openmod) -eq $false) {New-Alias -name openmod -value Get-ModuleDirectory }

function Get-ModuleDirectory {
 
    $Path = $env:PSModulePath -split ";" -match $env:USERNAME
 
    if (-not (Test-Path -Path $Path))
    {
        New-Item -Path $Path -ItemType Container | Out-Null
    }
        $Path
}
 
Invoke-Item (Get-ModuleDirectory)