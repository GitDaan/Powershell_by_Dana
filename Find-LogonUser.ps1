#requires -Version 3.0
#requires -runasadministrator

function Find-LogonUser {

<#
.Synopsis
   One liner to find who is logged into a computer
.DESCRIPTION
   Function to query WMI (computersystem) for the current logged on user. There is the option for running this
   as verbose and/or debug. Error handling is programmed in as well.
.EXAMPLE
   Find-LogonUser <NetBiosName>
.EXAMPLE
   FLO <NetBiosName>
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   File Name:   
   Date Create:
   Author:
   Contact:
   Current Version:
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>

    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$true,
                  ConfirmImpact='Low')]
    [Alias('FLU')]
    [OutputType([String])]
    Param
    (
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias("cn")] 
        [string[]]$ComputerName        
    )

    Begin {
        }#Begin
    Process
    {
        if ($pscmdlet.ShouldProcess("ComputerName")) {
            try {
                Write-Verbose -Message "Testing connection to $ComputerName"
                $Exists = Test-Connection -ComputerName $ComputerName -Count 1 -Quiet
                If($Exists) {Write-Verbose -Message "Polling Wmi Win32_ComputerSystem for username"
                $UserIs = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName | Select-Object -ExpandProperty UserName
                } Else {Write-Verbose -Message "Computer not found" ; throw "Computername_not_found_on_network" }
            } catch {
                Write-Verbose -Message "Error thrown, aborting script"
                Write-Warning "Unable to connect to resource ($ComputerName)"
                Write-Verbose -Message "Writing Debug message"
                Write-Debug -Message "Input name was either not found or is not on the network"
            } #try/catch
        }#$pscmdlet
        }#Process
    End {
            Write-Verbose -Message "Writing Final Data"
            If ($UserIs) {Write-Output "Current Logged On User: $UserIs"
            } ElseIf (($UserIs -eq $null) -and ($Exists -eq $true)) {Write-Host "No one is currently logged on";Write-Debug -Message "WmiObject empty"
            } Else {Write-Debug "Script error count: $($ScriptErrors.Count)"}#ifElse
        }#End
}#End of Function