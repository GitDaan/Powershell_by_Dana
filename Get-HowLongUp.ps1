#requires -Version 2
<#
.SYNOPSIS
    Gets how long since last boot
.DESCRIPTION 
    Gets the days-hours-minutes-seconds the server/workstation has been running. This is equivelent to when the user last rebooted
     and is how we internally process such information. 

.FUNCTIONALITY 
    To convert the obtuse System Object Boot time to a human understandable term.

.PARAMETER CompName 
    Mandatory input of the name (or possibly IP) of the machine in question.  
.INPUTTYPE
    [String] Does accept pipeline (text file of computer names?) as well as user supplied
.RETURNVALUE
    [String]
.LINK
    https://www.howtogeek.com/141495/geek-school-writing-your-first-full-powershell-script/
    http://www.computerperformance.co.uk/powershell/powershell_converttodatetime.htm

.NOTES
  File Name: Get-HowLongUp.ps1
  Creation Date: April 7, 2017
  Last Modified: N/A
  Version: 1.0
  Author: Dana C. Andrews

.VERSION HISTORY
    Version 1.0 - Initial creation
  
.CompName
    The name or IP of the computer to be checked. A Get-Content object could be piped in
    with the information on multiple computers contained in a text file. Since pipeline
    functionality is accepted, any source of computer names would work. There is always
    Hash-tables too.

.Alias GUT

.EXAMPLE
    Get-UpTime VAIO_NB1

.EXAMPLE
    Get-Content -path c:\temp\ComputerNames.txt | Get-UpTime (assumes a text file named ComputerNames.txt is at C:\temp)

.EXAMPLE
    $Computers = @{"Comp1" = "Vaio_NB1"; "Comp2" = "Vaio_NB1"} ; ForEach ($GT in $computers.Values) {Get-UpTime $GT}
#>

New-Alias -Name GUT -Value Get-UpTime


Function Get-UpTime {
  [CmdletBinding()]
  Param (
        [Parameter (Mandatory=$true, position=0, ValueFromPipeline=$true)]
        [Alias('gut')]
        [PSObject] $CompName #use ',' at end to add more $vars
    )
    
  Process {
    Try {
      If ($CompName -is [String])
        {
            $date = Get-Date
            $GetRaw = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $CompName
            $uptime = $GetRaw.ConvertToDateTime($GetRaw.lastbootuptime)
            $Calc = ($date - $uptime)
            $Answer = $Calc.Days.ToString() + " days, " + $Calc.Hours.ToString() + " Hours, " + $Calc.Minutes.ToString() + " Minutes, " + $Calc.Seconds.ToString() + " seconds."
            Write-Output "Workstation has been running for $Answer"
        } #end If
    } #end Try
    Catch {
        #error routine
        #example:
        $Global:Bad = "Error: $($_.Exception)"
        Break
        } #end Catch
    } #end Process
  End {
    If ($Global:Bad) {
        Write-Host -BackgroundColor Red -ForegroundColor White "Error: $Global:Bad"
        } #end Catch action
        Else {
            Write-Host 'Completed Successfully.'
            }     
    } # end End
} #end Function