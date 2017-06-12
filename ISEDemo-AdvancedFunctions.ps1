#Advanced Powershell 3.0 Part 4 (Dauren Amanbayev)
Clear-Host

#Basic function without advanced parameters. Note that the variable shows in each code block (Begin,Process,End).
Function Test-Pipeline {
    [cmdletBinding()]
    Param(
        [Parameter()]
        [String]$MyVar
        )
Begin { "Begin $MyVar" }
Process { "Process $MyVar" }
End { "End $MyVar" }
}#function
Test-Pipeline -MyVar "Test"

#Advanced Parameter - Values from Pipeline - Note that only Process block works now.#########################
#Example 1
Function Test-Pipeline {
    [cmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline=$true)]
        [String]$MyVar
        )
Begin { "Begin $MyVar" }
Process { "Process $MyVar" }
End { "End $MyVar" }
}#function
1..3 | Test-Pipeline

#Example 2
Function Test-Pipeline {
    [cmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline=$true)]
        [Int]$MyVar
        )
Begin { $Total = 0 } #initialize variable
Process { $Total += $MyVar }
End { "total = $Total" }
}#function
1..3 | Test-Pipeline

#switch as a type/param is an option option for a function.################################### 
#[string] $somevariable
#[string[]] $somevariableThatCanTakeMoreThanOneThing
#[switch] $YesDoThis
#Begin{If($YesDoThis) {...} Else {...}

Function Get-CompInfo {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipeline=$True)] #for pipelining. Could have also included Mandatory and HelpMessage. Don't forget ValueFromPipelineByPropertyName.
        [string[]] $ComputerName, #will take more than one input [$abc[]]
        [switch]$ErrorLog,  #We can 'turn on' error messaging to a logfile
        [string]$Logfile = 'c:\temp\errorlog.txt'
        )
        Begin {
            If($ErrorLog){write-verbose "Error logging is on"}
            Else {Write-Verbose "Error logging is off"}#ifElse            
            }#begin
        Process {  #process block is used in case we pipeline the input
            Foreach($C in $ComputerName){
                    "Computer: $C"}#foreach
            }#process
        End {}#end
}#function

Get-CompInfo Vaio_nb1, LocalHost, DC
Get-CompInfo vaio_nb1, LocalHost, DC -Verbose
Get-CompInfo vaio_nb1, localhost, dc -ErrorLog -Verbose
$Comps = @('Vaio_nb1','localhost','dc')
$Comps | Get-CompInfo -ErrorLog -Verbose

#Mo betta - Adding more advanced parameters
Function Get-CompInfo {
    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$true,
                   ValueFromPipeline=$True,
                   ValueFromPipelineByPropertyName=$True,
                   HelpMessage= 'One or more computer names')] #Now there will be a !? if the mandtory parameter is not specified at run call.
        [Alias('Hostname')]                                    #Now the term Hostname will work for ComputerName ([Alias] inside Param is for the parameter)
        [ValidateSet('Vaio_nb1','DC','LocalHost')]             #Now we can only input computers who's names match the 'set'. Tab-complete will now work too! 
        [ValidateCount(0,3)]                                   #control how many computerNames can be supplied (ITC from one to three with zero for help support).
        [string[]] $ComputerName, #will take more than one input [$abc[]]

        [switch]$ErrorLog,  #We can 'turn on' error messaging to a logfile
        [string]$Logfile = 'c:\temp\errorlog.txt'
        )
        Begin {
            If($ErrorLog){write-verbose "Error logging is on"}
            Else {Write-Verbose "Error logging is off"}#ifElse            
            }#begin
        Process {  #process block is used in case we pipeline the input
            Foreach($C in $ComputerName){
                    "Computer: $C"}#foreach
            }#process
        End {}#end
}#function

Get-CompInfo -Verbose
Import-Csv C:\computers.csv | Get-CompInfo -Verbose
Get-CompInfo SonyVaio_nb1
Get-CompInfo #(tab for names of computers)
Get-CompInfo dc, ad, vaio_nb1, localhost  #note that validateSet() will not run because validateCount() will run first. 

#[Validatepattern()] is a powerful way to control input but uses Regex which is hard to use.
#You can also use [Validatelength(1,10)] which will ensure names are 1 to 10 letters long only (including spaces of course, which shouldn't be there)
# In ISE, Type in [Validate then press CTRL + Space

#This is useless (no error handling & is a terminating error)... [ValidateScript({Test-path $_}) to see if your target is reachable!
Function Test-Location{
[cmdletbinding()]
Param(
[parameter(Mandatory=$true)]
[ValidateScript({Test-Path $_})]
[string] $location
)
Begin {}
Process {Get-Content $location}
End {}
}#function

Test-Location C:\temp\servers.txt
Test-Location C:\PSTemp\servers.txt

#Help about-Functions_Advanced_Parameters

#Trick - To quickly get back to a command you typed, put #a few letters of the command and then TAB!
