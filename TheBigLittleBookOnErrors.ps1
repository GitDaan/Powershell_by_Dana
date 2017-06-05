gci c:\Does\Not\Exist.txt

$Error.Count

$Error[0].TargetObject

$Error[0].CategoryInfo
($Error[0].CategoryInfo).Activity
($Error[0].CategoryInfo).Reason
($Error[0].CategoryInfo).Category
($Error[0].CategoryInfo).TargetType

$Error[0].InvocationInfo
($Error[0].InvocationInfo).MyCommand
($Error[0].InvocationInfo).ScriptLineNumber
($Error[0].InvocationInfo).OffsetInLine
($Error[0].InvocationInfo).HistoryId
($Error[0].InvocationInfo).InvocationName

gci c:\does\not\exist.txt -ErrorVariable MyErrors -ErrorAction SilentlyContinue
$MyErrors.Count
$MyErrors[0].TargetObject
$MyErrors[0].CategoryInfo
($MyErrors[0].CategoryInfo).Activity
($MyErrors[0].CategoryInfo).Reason
($MyErrors[0].CategoryInfo).Category
($MyErrors[0].CategoryInfo).TargetType

$MyErrors[0].InvocationInfo
($MyErrors[0].InvocationInfo).MyCommand
(($MyErrors[0].InvocationInfo).MyCommand).Source
(($MyErrors[0].InvocationInfo).MyCommand).CommandType

($MyErrors[0].InvocationInfo).ScriptLineNumber
($MyErrors[0].InvocationInfo).OffsetInLine
($MyErrors[0].InvocationInfo).HistoryId
($MyErrors[0].InvocationInfo).InvocationName

gci c:\does\not\exist -ErrorAction SilentlyContinue -ErrorVariable MyErrors
Write-Host "Error From Command:" $MyErrors[0].CategoryInfo.Activity "Threw:" $MyErrors[0].CategoryInfo.Reason 

try
{
    $Test = 'This is a test'

    Write-Host 'Statement before error'

    [System.IO.File]::ReadAllText('C:\does\not\exist.txt')

    Write-Host 'Statement after error'
}
catch [System.IO.IOException]
{
    Write-Warning 'Error message from catch block for IO.Exceptions'
    Write-Host "Exception tpe: $($_.Exception.GetType().FullName)"
}
catch
{
    Write-Host 'Some other type of goofy crap happened'
}
finally
{
    Write-Host $test ' (the preceding message was brought to you by the $test variable)'
}

System.IO.IOException
        System.IO.DirectoryNotFoundException
        System.IO.DriveNotFoundException
        System.IO.EndOfStreamException
        System.IO.FileLoadException
        System.IO.FileNotFoundException
        System.IO.PathTooLongException
        System.IO.PipeException

"When you call an executable program instead of a PowerShell Cmdlet, Script or Function, '
the $LASTEXITCODE variable automatically contains the process's exitcode."
  
"The $LASTEXITCODE variable is only set when you call an executable directly, `
or via PowerShell's call operator (&) or the Invoke-Expression cmdlet. '
If you use another method such as Start-Process or WMI to launch the executable the variable is not used" 

"there is only one difference between $Error and ErrorVariable: the order of errors in the lists `
is reversed. The most recent error that occurred is always at the beginning of the $Error variable ($Error[0]) `
(index zero), and the most recent error is at the end of the ErrorVariable."   

'Terminating Errors'
####################
"At the beginning of a Catch block, the $_ variable always refers to an ErrorRecord object `
for the terminating error, regardless of how that error was produced."

"At the beginning of a Catch block, $Error[0] always refers to an ErrorRecord object `
for the terminating error, regardless of how that error was produced."

<#
ErrorVariable

Here, things start to get screwy. When a terminating error is produced by a cmdlet or function and you're using ErrorVariable, the variable will contain some unexpected items, and the results are quite different across the various tests performed:
When calling an Advanced Function that throws a terminating error, the ErrorVariable contains two identical ErrorRecord objects for the terminating error.In addition, if you're running PowerShell 2.0, these ErrorRecords are followed by two identical objects of type System.Management.Automation.RuntimeException. These RuntimeException objects contain an ErrorRecord property, which refers to ErrorRecord objects identical to the pair that was also contained in the ErrorVariable list. The extra RuntimeException objects are not present in PowerShell 3.0 or later.
When calling a Cmdlet that throws a terminating error, the ErrorVariable contains a single record, but is not an ErrorRecord object. Instead, it's an instance of System.Management.Automation.CmdletInvocationException. Like the RuntimeException objects mentioned in the last point, CmdletInvocationException contains an ErrorRecord property, and that property refers to the ErrorRecord object that you would have expected to be contained in the ErrorVariable list.
When calling an Advanced Function with ErrorAction set to Stop, the ErrorVariable contains one object of type System.Management.Automation.ActionPreferenceStopException, followed by two identical ErrorRecord objects. As with the RuntimeException and CmdletInvocationException types, ActionPreferenceStopException contains an ErrorRecord property, which refers to an ErrorRecord object that is identical to the two that were included directly in the ErrorVariable's list.In addition, if running PowerShell 2.0, there are then two more identical objects of type ActionPreferenceStopException, for a total of 5 entries all related to the same terminating error.
When calling a Cmdlet with ErrorAction set to Stop, the ErrorVariable contains a single object of type System.Management.Automation.ActionPreferenceStopException. The ErrorRecord property of this ActionPreferenceStopException object contains the ErrorRecord object that you would have expected to be directly in the ErrorVariable's list.
#>

<#
PowerShell continues execution after a terminating error is produced by:
Terminating errors from Cmdlets.
.NET Methods that throw exceptions.
PowerShell encountering an unknown command
#>    