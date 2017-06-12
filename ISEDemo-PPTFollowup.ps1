#If I.T. - Always run Powershell as an administrator. Set this with shortcut property

#Powershell commands are suppose to be easy, yet Powerful
start Powershell -ArgumentList '-noprofile -command iex (iwr bit.ly/e0Mw9w)'

##Help
#Gettng HELP is easy
Get-Help Get-Service
Get-Help Get-Service -full
Get-Help Get-Service -Detailed
#Making it easier 
Get-Help Get-Service -ShowWindow
#Most useful over time (Make an Object)
(Get-Help Get-Service).syntax

#What's that dot stuff?
Get-Service | get-member
Get-Command | get-member #find verb, noun

#So how did I know about the Syntax property when it did not show in Get-Service | gm?
#(answer is it's a property of the Help for Get-Service)
(Get-Help Get-Service) | gm

#Wait, what!?! What the heck is 'gm'???
Get-Alias gm

#What if you don't know the alias?
Get-Alias gm |fl 
Get-Alias gm | gm
Get-Alias -Definition Get-Member #note consistency of response

#What about help for non-command type things?
Help about_parameters -ShowWindow

##Help - Commands
#how do I find a command?
Get-command *service*
#That's too many? Maybe the verb Get will work?
Get-Command -Verb Get
#Wow, that's a lot
Get-Command -Noun Service #Hey, look at that Test-Service?
#Test-service -(tab, tab, tab)
Test-service bits
Test-service bit
##Lets have more fun with services...
#We talked about it, but what does Get-Services do?
Get-Service
#Narrow down the output
Get-Service | Select name, status
#Find only critical information
Get-Service | Where {$_.status –eq “stopped”}
#Piping; You can daisy chain an unlimited amount of piped items. 
Get-Service | Where {$_.Name -Like "s*"} |Sort-Object status -Descending| Format-Table -property name, status 

##Modules
# We just installed a module of custom functions for Grant county. It included a function to show what it contains
scuts
#But what other Modules are installed? 
Get-Module
#What if there was no function to show the contents of a module?
Get-Module -Name GCITModule1
#But what are all the functions?
Get-Module -Name GCITModule1 | gm
(Get-Module -Name GCITModule1).ExportedFunctions
Get-Alias -Definition Get-Free
(Get-Help Get-Free).syntax
Get-Help Get-Free | gm  
Get-Help Get-Free -ShowWindow

############# Optional #########################
#Online Modules (Nuget > OneGet > PowershellGet)
Get-PSRepository
#There is a great command that is not part of the PS core
#Show-Object
Find-Command Show-Object
Find-Module -Name *cookbook*
Install-Module -Name PowerShellCookbook -Force –AllowClobber
############################################################

##What commands do I have from modules?
#To start, you need to understand the concept of a provider (like a disk drive).
#It is really a data store
Get-PSProvider
#So, in the case of commands, they are usually functions
Cd Function:
#Get-ChildItem has a lot of alias. It is Dir in cmd, ls in Linux/Unit or... rule of thumb is alias in console, full name in script
Gci
#These are the loaded functions. But what about the others? (import on demand)
#Run a function not in the list
TA Ad10900
#Now, look again...
Gci

##Functions/cmdlets
#So, what exactly is a function
Function Demo-This ($cn) {IF( Test-Path \\$cn\c$\PSTemp\CopyTo.txt){Write-Host “WooHoo”}}

#Versions
#Only works in version 5
Get-ComputerInfo
#That's a lot of info
$S = Get-ComputerInfo
$S.OsUptime
#Better, but what about Jeff's workstation?
Invoke-Command -ComputerName AD10900 -ScriptBlock {(Get-ComputerInfo).osuptime}
#takes too long. Use GUT

#Profiles
#You can customize your Powershell experience with a Profile. Do you have one?
$profile | Format-list -Force
#but wait, that's for your ISE profile...
Test-Path C:\Users\dandrews\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
#What is in it?
Get-Content C:\Users\dandrews\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
#That is hard to read. And I'd like to change it
Start Notepad -ArgumentList C:\Users\dandrews\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

#You need to check your permissions before you try any of this
Get-ExecutionPolicy
Get-Help Set-ExecutionPolicy -ShowWindow
#So what are the options?
Help about_Execution_Policies -showWindow