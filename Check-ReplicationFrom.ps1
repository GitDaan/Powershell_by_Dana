Function Check-ReplicationFrom {
[cmdletbinding()]
Param (
[parameter (Mandatory = $true, Position = 1, `
            HelpMessage = 'Adminbldg, OrchardManor, Highway, ADRCSS, UWExtension')]
        [string] $Site
        ) 
repadmin /showrepl * /csv | ConvertFrom-CSV |
 Where-Object {$_."Source DSA Site" -eq "$Site"} | Out-GridView
 }

 IF((Test-Path alias:CRF) -eq $false){New-Alias -name CRF -Value Check-ReplicationFrom}
