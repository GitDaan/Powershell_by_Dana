# PowerShell Switch script to count eventlog messages
Function Get-EventCount{
BEGIN {
$errors = 0
$warnings = 0
$info = 0
$Logname = Read-Host -Prompt "Which Log File?"
$Events = Get-EventLog $Logname -Newest 250
}

Process {
Switch -Wildcard ($Events.entrytype) {
   "err*" {$errors++}
   "warn*" {$warnings++}
   "info*" {$info++}
    default {}
           }# End of switch block
       }# End of Process block
END {
Clear-Host
"For the newest 250 event entries:"
"The $Logname log contained " + $errors + " error messages."
"The $Logname log contained " + $warnings + " warning messages."
"The $Logname log contained " + $info + " information messages. `n" 
Write-Output "Report run on " + Get-Date
          } # End block
} # End of function 