
Stop-Process -Id 23, 53, 999 -ea SilentlyContinue -ev e

$e[0] | fl * -Force

$e[0].targetObject
$e[0].Exception
$e[0].CategoryInfo
$e[0].CategoryInfo.Activity
$e[0].CategoryInfo.Category
$e[0].CategoryInfo.TargetType
($e[0].FullyQualifiedErrorId.Split('{,}'))[0]

$i = 0
While ($i -lt $e.Count) {
    "Error"
    "What happened was " + ((($e[0].FullyQualifiedErrorId.Split('{,}'))[0]) -creplace  '([A-Z\W_]|\d+)(?<![a-z])',' $&').trim() + " " + $e[$i].targetObject
    "The command " + $e[$i].CategoryInfo.Activity + " failed because parameter " + $e[$i].targetObject + " threw an " + $e[$i].CategoryInfo.Category + " error."
    "Diagnostic: The Target was of Type: [" + $e[$i].CategoryInfo.TargetType + "]`n"
    $i++
    }

############################################################################################################

$ErrorView = "CategoryView"
Stop-Process -Id 23, 53, 999 -ea Continue -ev e
$i = 0
While ($i -lt $e.Count) {
    "Error"
    "What happened was " + ((($e[0].FullyQualifiedErrorId.Split('{,}'))[0]) -creplace  '([A-Z\W_]|\d+)(?<![a-z])',' $&').trim() + " " + $e[$i].targetObject
    "The command " + $e[$i].CategoryInfo.Activity + " failed because parameter " + $e[$i].targetObject + " threw an " + $e[$i].CategoryInfo.Category + " error."
    "Diagnostic: The Target was of Type: [" + $e[$i].CategoryInfo.TargetType + "]`n"
    $i++
    } 

$ErrorView = "normalview"

# Log all runs of your scripts to show 'value'. You can then retrieve later with script that looks on all machines by ID by logname (by source?)
New-EventLog -LogName 'Windows Powershell' -Source 'My Scripts' #You only need to do this once to create the "source"

$Message = "Script foo ran"
Write-EventLog -LogName 'Windows Powershell' -Source 'My Scripts' -EntryType Information -Message $Message -EventId 0 -ComputerName $env:Computername

New-EventLog -LogName 'Windows Powershell' -Source 'MyScriptErrors' #You only need to do this once to create the "source"

$err = "The command " + $e[0].CategoryInfo.Activity + " failed because " + ((($e[0].FullyQualifiedErrorId.Split('{,}'))[0]) -creplace  '([A-Z\W_]|\d+)(?<![a-z])',' $&').trim() + " " + $e[0].targetObject
Write-EventLog -LogName 'Windows Powershell' -Source 'MyScriptErrors' -EntryType Warning -Message $err -EventId 999 -ComputerName $env:Computername

Get-Eventlog -LogName 'Windows PowerShell' -InstanceId 0
Get-Eventlog -LogName 'Windows PowerShell' -InstanceId 999

measure-command -Expression {Get-WinEvent @{logname= 'Windows PowerShell'; level=2}} #@home 206 ms
measure-command -Expression {Get-eventlog -LogName 'Windows PowerShell' -EntryType Warning} #@home 6 ms
Measure-Command -Expression {Get-WmiObject Win32_NTLogEvent -Filter "Logfile='Windows PowerShell' AND EntryType = 'Warning'"} #@home 219 ms

#Speaking of using numbers for category without a dictionary
$i = 2
$category = Switch ($i) { #Variable = switch(){statement} is known as 'assignable'. In powershell, variables are assignable. 
            0 {"Joy"}
            1 {"Happy"}
            2 {"Okay"}
            3 {"crap"}
            4 {"Damn"}
            Default {"No category specified"}
        }
$category