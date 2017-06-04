function Group-ServiceByStatus {
    param (
        [parameter (Mandatory=$true,position=1)]
        [String]
        $Global:State
        )

     process {
     $hash = Get-Service | Group-Object -Property Status -AsHashTable -AsString
     switch ($Global:State)
     {
        "running" {$hash.running}
        "stopped" {$hash.stopped}
        default {Write-Output "The values are either running or stopped"}
        }

    }
}