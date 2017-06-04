Function Show-Parameter {
    Param (
        [string]$Text,
        [double]$Number
    )
    If ($PSBoundParameters.ContainsKey('Text')) {
        switch ($Text) {
        {$_ -eq 'hello'} {Write-Output -InputObject 'You are so formal' ; break}
        {$_ -eq 'hi'} {Write-Output -InputObject 'Hi yourself' ; break}        
        default {"You entered: `"$Text`" because you're a dick that does not play"}
        }
      }
    If ($PSBoundParameters.ContainsKey('Number')) {
        switch ($Number) {
        {$_ -gt 0} {Write-Output -InputObject "Your number $Number is a positive integer" ; break}
        {$_ -lt 0} {Write-Output -InputObject "You entered $_, which is a negative number" ; break}
        default {"You entered 0"}
        
        }
      }
    }
