function Get-Latency {
[cmdletbinding()]
param(
[parameter (Mandatory=$true, Position=1, HelpMessage = "Name of Server/Computer")]
[string] $NetBiosName
)
    BEGIN {}#end of BEGIN
    PROCESS {
            $S = Test-connection -Count 4 -ComputerName $NetBiosName -ErrorAction SilentlyContinue  |
            Measure-Object ResponseTime -Average 
        }#end of PROCESS
    END {
        Write-Host -NoNewline "Average response time was " $S.Average " milliseconds"
        }#end of END
}#end of Function