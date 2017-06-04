Function Show-AdvancedFunction {
     [CmdletBinding(SupportsShouldProcess)]Param()

     #$ConfirmPreference = "High" ## Not needed for confirm box in Powershell 5.1

     If($PSCmdlet.ShouldContinue("This means you will have stuff to read,`n Do you really want to invest that kind of time?`n Verbose is even worse!","Dumb User Dialog"))
     {
     Write-Verbose "Alright, Talky talky it is!"
     Write-Host -ForegroundColor DarkRed -BackgroundColor White "This is self-explanatory, anyway."
        } Else { Write-Host -BackgroundColor Red -ForegroundColor white "User Chickened Out"
            }
}