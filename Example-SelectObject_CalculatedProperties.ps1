#One-liner this is based on
#Get-ChildItem  C:\users\windaan\documents\GitHub\Powershell_by_Dana | Select-Object Name, @{Name="Kb";Expression={ "{0:N0}" -f ($_.Length / 1Kb) }}

function Get-FileSize {
[Alias("GFS")]
[cmdletbinding()]
Param(
    [parameter(valuefrompipeline=$true)]
    [PSObject] $Directory,

    [switch] $MB,
    [switch] $GB
    )
    
BEGIN {
        [string] $Size
        If ($MB) {$Size = "1mb"} 
            ElseIf ($GB) {$Size = "1gb"}
                Else {$Size = "1kb"}   
    }#begin

PROCESS {
           $Directory | Select-Object Name, @{Name=$Size;Expression={ "{0:0.0000}" -f ($_.Length / $Size) }} 
    }#process

}#function

#call
GCI C:\users\windaan\documents\GitHub\Powershell_by_Dana | Get-FileSize -mb