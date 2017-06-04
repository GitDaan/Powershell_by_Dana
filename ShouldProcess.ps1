Function set-stuff{
    [cmdletbinding(SupportsShouldProcess=$true,
                    confirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        [string]$computername   
    )
    Process{
    
        If ($psCmdlet.shouldProcess("$Computername",'A message for WhatIf')){
            Write-Output 'Im changing something right now'
        }
    }
}

Set-stuff -computername localhost           #Runs the script
Set-stuff -computername localhost -whatif   #Shows the message, show what it would run, then it stops
Set-stuff -computername localhost -verbose  #Shows the message then runs the script