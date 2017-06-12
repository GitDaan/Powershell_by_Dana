# Finds entries labeled "error" in the event log you specify starting from the date you enter to the most recent
# Example: FindLogErrors Microsoft-Windows-TwinUI/Operational 3/18/2017 (note the example is for a deeply buried log) 
 
function Find-LogError($logname, $fromDate) {
Get-WinEvent -LogName $logname -MaxEvents 10 | Where-Object {$_.TimeCreated -gt $fromDate -and $_.LevelDisplayName -eq "Error"}
}

# 'FindLogErrors' is the function call, 'Microsoft-Windows-TwinUI/Operational' is the log name, '3/18/2017' is the date you want to search FROM (to most recent).
#  Enter the data plainly with no quotes
#  The Event Log in this example would be found at: Microsoft > Windows > TwinUI > Operational