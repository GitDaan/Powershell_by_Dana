<#
    .Synopsis
        The local command to list all the installed printers on a particular workstation/computer
#>


function Get-InstalledPrinter {
Get-WmiObject Win32_Printer | ForEach-Object {$_.Name}
}