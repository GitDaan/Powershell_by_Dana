# PowerShell Switch script to count eventlog messages
Function EventType{
BEGIN {
$errors = 0
$warnings = 0
$info = 0
$Logname = $_.name
}

Process {
Switch -Wildcard ($_.entrytype) {
   "err*" {$errors++}
   "warn*" {$warnings++}
   "info*" {$info++}
    default {}
           }# End of switch block
       }# End of Process block
END {
Clear-Host
"The $Logname contains " + $errors + " error messages."
"The $Lognamelog contains " + $warnings + " warning messages."
"The $Lognamelog contains " + $info + " information messages. `n" 
Get-Date
          } # End block
} # End of function 