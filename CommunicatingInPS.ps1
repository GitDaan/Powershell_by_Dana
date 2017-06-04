
function Test-Msg {
    [cmdletbinding()]
    Param(
        [parameter()]
        [string]$Msg
        )

Process {
        Write-Verbose -Message "I am chatty in Verbose"
        Write-Output $Msg
        Write-Information -MessageData "Here's the 9-1-1 information"
        Write-Debug -Message "Debug will run the ShouldProcess dialog"
    }#process

End {      
        #Write-Error -Message "This is an error" #uncomment this if you want to see an error
        Write-Warning -Message "Warning Will Rodgers"
    }#end

}#function

Test-Msg "xxx"
Test-Msg "xxx" -Verbose
Test-Msg "xxx" -Debug
Test-Msg "xxx" -InformationAction Continue
