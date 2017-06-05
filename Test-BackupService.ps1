#requires -Version 3.0
 
Function Test-BackupService  {
<# 
 .NOTES
    Script Name: Test-BackupService
    Version:1.1
    Creation Date: April 20, 2017 
    Last Modify: April 28, 2017
    Author: Dana Andrews
    Location: Grant County, Wisconsin
    Contact: dandrews@co.grant.wi.gov
    
.Synopsis
  Finds if the backup service is running  

.Description
   Checks the status of the backup service which can be one of two flavors; AppAssure or RapidRecovery

.Functionality
    Check that backup is running

.InputType String
    Name of server

.ReturnValue String
    Console message

.Version History
        Version 1.0 - Initial Creation
	Version 1.1 - Changed name to Test-BackupService (consistency of naming)

.Parameter ServerName
    Mandatory, positional, accepts value from a pipeline, must be between 4 and 16 characters in length
    
.Example Basic
   Test-BackupService -ServerName ABCxxx
   => AppAssure/RapidRecovery Agent Is Running (console)
#>
[Alias('TBS')]
[cmdletbinding(SupportsShouldProcess=$true, ConfirmImpact="Low")]
Param(
	[parameter (Mandatory=$True,
		    position=1, 
		    ValueFromPipeline=$true, 
		    ValueFromPipelineByPropertyName=$True,
                    HelpMessage='Server name')]
         [ValidateLength(4,16)]	
	 [String] $ServerName
	)

BEGIN {            
    }#begin

PROCESS {
      if ($pscmdlet.ShouldProcess($ServerName)) {
         If ($PSBoundParameters.ContainsKey('ServerName')) {
        Try {
        If ($ServerName -is [String]) {
            If (Get-Service -Name appassureagent -ComputerName $ServerName -ErrorAction SilentlyContinue) {
                Write-Host -ForegroundColor Cyan "AppAssure Agent Is Running"
                } ElseIF (Get-Service -Name rapidrecoveryagent -ComputerName $Servername -ErrorAction SilentlyContinue) {
                Write-Host -ForegroundColor Cyan "RapidRecovery Agent Is Running"
                } Else { Write-Host -ForegroundColor White -BackgroundColor Red "No backup service is running!" 
                } #end if logic processing
                    } #Validation    
            } Catch {
        #error routine
        Write-Host -BackgroundColor DarkRed -ForegroundColor White "Error: $($_.Exception)"
        Break       
        }#Try/Catch
           }#PSBoundParameters           
          }#ShouldProcess
 }#process              
   
END {            
    }#end
 }#function