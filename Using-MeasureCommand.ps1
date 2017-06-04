#Three ways to do the same thing. Which one is quickest?

Measure-Command {
    Get-Process | Select-Object -Property Name,@{n='total';e={$_.vm + $_.pm}} 
    }

Measure-Command {
    $procs = Get-Process
    foreach ($proc in $procs) {
        $total=$proc.vm + $proc.PM
        Write-Output "$($proc.name) $($total)"
        }
    }

Measure-Command {
    Get-Process | ForEach-Object {
        Write-Output "$($_.Name) $($_.vm + $_.PM)"
        }
    }