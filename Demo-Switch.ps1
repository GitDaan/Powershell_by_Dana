Function Demo-Switch {
<#
    Some jive bullshit here
#>

[alias('Yo')]
[cmdletbinding()]
param(
    [parameter()]
    [switch] $Force,
    [parameter()]
    [switch]$Quiet,
    [switch]$Msg=[switch]::Present #defaults as enabled ($true)
    )

Begin {
        $F = $false
        $Q = $false
        $Msseg = "I'd rather Fight than Switch!"
        }#end of Begin
Process{
    If($Force.IsPresent) {$F = $true} 
    If($Quiet) {$Q=$true}
    }#end of Process
End {
    If ($Msg) {$Voice = 'We are one people. '}
    If ($F) {$Voice = $Voice + 'But force was needed. '}
    If ($Q -eq $true) {$Voice = $Voice + 'So, keep it quiet!'}
    $Voice
    }#end of End
}#end of function

<#invocations
Demo-Switch
Demo-Switch -Force
Demo-Switch -Quiet
Demo-Switch -Force -Quiet
Demo-Switch -Msg:$false
Demo-Switch -Msg:$false -Force -Quiet
#>