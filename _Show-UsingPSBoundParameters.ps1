Function Show-UsingPSBoundParameters {
<#
.Note
	One automatic variable I use all the time is $PsBoundParameters. $PsBoundParameters is a hashtable-like variable, more specifically a [System.Management.Automation.PSBoundParametersDictionary] object. This variable is present if a script or function you create that contains user-populated parameters. In other words, if you've got a script or function using the param() statement with one or more parameters inside and you've passed arguments to these parameters, the $PsBoundParameters variable will always be available.

This is useful for non-mandatory parameters that the user may or may not pass in

#>

    Param (
        [string]$Text,
        [double]$Number
    )
    Begin {
        Write-Output -InputObject "****************************** `n Multi-phase Input Detector`n"
        If ($PSBoundParameters.ContainsKey('Text')) {Write-Output -InputObject "[Text Detected] `n"}   
        If ($PSBoundParameters.ContainsKey('Number')) {Write-Output -InputObject "[Number Detected] `n"}
    }
    Process {
    If ($PSBoundParameters.ContainsKey('Text')) {
        switch ($Text) {
        {$_ -eq 'hello'} {Write-Output -InputObject "Hello to you too! `n" ; break}
        {$_ -eq 'hi'} {Write-Output -InputObject "Hi yourself `n" ; break}        
        default {"You entered: $Text (How childish) `n"}
        }
      }
    If ($PSBoundParameters.ContainsKey('Number')) {
        switch ($Number) {
        {$_ -lt 0} {Write-Output "You entered $Number, which is less than 0" ; break}
        {$_ -gt 0} {Write-Output "You entered $_, which is greater than 0" ; break}
        default {"You entered 0"}
        
        }
      }
      }
      End {
        Write-Output -InputObject "[`n... Processing Complete, function shutting down] `n****************************** "
      }
    } 
