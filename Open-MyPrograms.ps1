<#
 =====================================
    Script Name: Open-MyPrograms
    Creation Date: April 5, 2017
    Last Modify: N/A
    Author: D Andrews
    Location: Grant County, Wisconsin
    Output path: Workstation
    =====================================

 .Synopsis
  A short script to start up commonly used programs on AD10901  

 .Description
   I am tired of click-click-click. So I wrote this to open my 'never closed' programs.
   Now I just open PowerShell and run this. It's all good. 
   Alias is OMP

 .Parameter N/A
  Ain't nobody got time for putting in parameters

  .Example
   # Basic
    Open-MyPrograms

 .Example
   # Using the alias
   Omp

 #>

 New-Alias -Name Omp -Value Open-MyPrograms

function Open-MyPrograms {
    #start Chrome.exe
    #start "C:\Users\dandrews\AppData\Local\Google\Chrome SxS\Application\Chrome.exe"
    start Outlook.exe
    #start "\\gcadmin\users\dandrews.V2\dandrews\Staff Directory.xlsx"
}