function Restart-BackupService {
<#
.Synopsis
   Restarts the backup agent on the specified server
.DESCRIPTION
   Finds which backup agent is installed on the server then restarts the backup agent.
.EXAMPLE
   Restart-BackupService <servername>
   => WARNING: Waiting for service 'Dell Data Protection | Rapid Recovery Agent Service (RapidRecoveryAgent)' to start...
      Service RapidRecoveryAgent restarted
.EXAMPLE
   Restart-BackupService <IP Address>
   => Service AppAssureAgent restarted
.INPUTS
   [string[]]
.OUTPUTS
   [string]console
.NOTES
   File Name: Restart-BackupService.ps1   
   Date Create: May 31, 2017
   Author: Dana C Andrews
   Contact: dandrews@co.grant.wi.gov
   Current Version: 1.0
.ROLE
   Server services
.FUNCTIONALITY
   Services
#>
[cmdletbinding()]
[Alias('RBUS')]
Param(
    [parameter(Mandatory=$True,
               ValueFromPipeline=$True,
               HelpMessage="Computer name")]
               [string[]]$ComputerName
        )

Begin { 
        Write-Verbose "Checking for type of backup service installed"
        If(Get-Service WinRM -ComputerName $ComputerName -ErrorAction SilentlyContinue -ErrorVariable CheckFailed) {
        If(Get-Service AppAssureAgent -ComputerName $ComputerName -ErrorAction SilentlyContinue -ErrorVariable ScriptError) {
            $service = "AppAssureAgent"}
            ElseIf (Get-Service RapidRecoveryAgent -ComputerName $ComputerName -ErrorAction SilentlyContinue -ErrorVariable ScriptError) {
                $service = "RapidRecoveryAgent"} Else {
                    $service = "cancelled, unable to contact agent"}#ifThenElse
                    } Else {
                        Write-Warning "Computer specified not found or remoting is turned off"
                        Return
                    }#If WinRM
    }#begin
Process {
        If($ScriptError.Count -ge 1){
            Write-Warning "No Agent Found!"}
        Write-Verbose -Message "Restarting $service"
        Try {
        If($service -ne "cancelled, unable to contact agent") {
            Restart-Service -inputObject (Get-Service -Name $service -ComputerName $ComputerName)
            $CompletionMessage = "Service $service restarted"
            } Else
                { $CompletionMessage = "Unable to find/contact an agent on the specified machine"
                }#ifElse
        } Catch {
            Write-Warning "Something went wrong with the processing block"
            }
            
    }#process
End {
        Write-Verbose "Writing completion message"
        If($CompletionMessage -eq "") {$CompletionMessage = $ScriptError}
        $CompletionMessage
    }#end
}#function
