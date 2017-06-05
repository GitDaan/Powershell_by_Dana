#requires -Version 2.0

function Export-Module {
<#
.SYNOPSIS
    Exports Modules For IT
.DESCRIPTION
    This function copies a module directory, and all files within,
    to any servers/computers listed in a pre-defined CopyTo.txt document.    
.EXAMPLE
   Export-Module <moduleName>    
.INPUTS
   Name of module (folder name should match. If not, folder name goes here)
.OUTPUTS
   Fileobject(s) moved to target computers
.NOTES
   Version: 1.0
   Creation Date: May 3, 2017
   Last Modify: N/A
   Author: Dana Andrews (modified from a script by David Hall - see link)
   Location: Grant County, Wisconsin
   Contact: dandrews@co.grant.wi.gov   
.COMPONENT
   Windows
.ROLE
   I.T. Management
.FUNCTIONALITY
   Provides distribution channel  
.Link
    http://www.co.grant.wi.gov
    http://www.signalwarrant.com
    http://www.signalwarrant.com/2012/10/04/copy-a-folder-and-files-to-multiple-computers-powershell/          
#>

[Alias('EMOD')]
[cmdletbinding()]
Param (

# This is the folder that represents the module being exported. 
[parameter(Mandatory=$true)]
[string]$Module
)

Begin {
        [string]$Success = "Successfully Deployed to " #File to write at the end
        $computers = (Get-Content "C:\PSTemp\CopyTo.txt") #list of machines to get a copy
        $source = "C:\Program Files\WindowsPowerShell\Modules\$Module" #This is the path to the folder(s) to be copied
        $dest = "\C$\Program Files\WindowsPowerShell\Modules\$Module"} #This is where the folder(s) will be copied to on each machine.

Process {
        If (-not(Test-Path $source)) {Throw [IO.FileNotFoundException] 'Folder/File Not Found! Check Spelling...'} 
        #the above checks that the file name given matches what is in the source directory 
        Try {    
            Foreach ($computer in $computers) {
                If (Test-Connection $computer -Quiet) {
                Copy-Item $source -Destination \\$computer\$dest -Recurse
                $Success = $Success + $computer + "`n"
                        }#end If 
                    Else {Write-Error -Message "Unable to contact $computer" `
                        -ErrorId "Check that the machine is online"
                        }#end of Else (You will see a message in the console for each unreachable machine
                    }#end Foreach
                }#end Try
        Catch {        
                [string]$FailMsg = 'Function failed to deploy '
                }#end Catch        
    }#end Process
End {Write-Output $FailMsg, $Success}#These let you know what worked or not

}#end Function
