<# 
 =====================================
    Script Name: Check-SQLogFileSize.ps1
    Creation Date: March 15, 2017
    Last Modify: April 5, 2017
    Author: D Andrews
    Location: Grant County, Wisconsin
    Output path: Console
    =====================================

 .Synopsis
  Checks that the size of the selected SQL LogFile is under 1 GB.  

 .Description
   Meant as a quick check that SQL truncation is being performed, this script will access the
   appropriate log file and check that the size is under 1 GB. Outputs a message to the console
   that the size is either OK or Not. No further information is provided.

 .Parameter <There are no user accessible parameters>
  N/A

  .Alias
   CSLFS

 .Example
   # Basic
   Check-SQLLogFileSize (Select a number from the menu and press the enter key.

  #>
  If ((Test-Path alias:cslfs) -eq $false) {New-Alias -Name cslfs -Value Check-SQLLogFileSize}
 
function Check-SQLLogFileSize {
    param(
        [parameter (Mandatory=$false, position=0)]
        [String] $WhichOne,
        [String] $Global:S = $null
        )
        Begin {
            
                    $WhichOne = Read-Host -Prompt "Enter number for logfile to check. `n1. OM `n2. AD`nChoice" 
                    try{
                    [int16]$WhichOne = $WhichOne
                    } Catch [System.Management.Automation.ArgumentTransformationMetadataException] {"Please enter a number only" ; Check-SQLLogFileSize }

                Switch ($WhichOne) {
                    1 {$Global:S="\\OMII\e$\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\KNS6X_SDB001_LOG.LDF"; break}
                    2 {$Global:S="\\ADII\e$\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\KNS6X_SDB001_LOG.LDF"; break}
                    Default {"Your Choice Was Not Valid"}
                     }                    
            }
        Process {
                        If ($Global:S -ne "") {
                        if((Get-Item -Path $Global:S).Length -lt 1gb)  {
                                Write-Output "File size is OK"}
                        Else {Write-Output "File Is Too Large!"
                        }
                    }
         }
         End {
                    Write-Output "Script run complete"
                    }
}


