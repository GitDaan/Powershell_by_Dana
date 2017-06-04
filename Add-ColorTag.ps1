#requires -version 2.0
function Add-ColorTag {
<#
.SYNOPSIS
    Colorizes tags (status in this case)

.DESCRIPTION 
    This is just an example script/function. I'm not crazy 
    about it because of its heavy use of .NET/C# [enums] but
    it is an example of what can be done to flag tags for 
    readability.

.FUNCTIONALITY 
    Saves a function method for re-use in future coding

.PARAMETER KeyColor
    Splatted color array 
      
.INPUTTYPE [System.file]
    It reads a file
        
.RETURNVALUE [String]
    
.LINK
   https://www.petri.com/color-coding-with-powershell 
     
.NOTES
  File Name: Add-ColorTag
  Creation Date: April 13, 2017
  Last Modified: N/A
  Version: 1.0
  Author: Dana C. Andrews (cut and paste from website)
  Contact: dandrews@co.grant.wi.gov

.VERSION HISTORY
    1.0 Initial creation

.EXAMPLE
    Add-ColorTag

#>

$split = get-content C:\Temp\Servers.txt
$keycolor = @{
Stopped = "Red"
Running = "Green"
StartPending = "Magenta"
ContinuePending = "Cyan"
StopPending = "Magenta"
PausePending = "Cyan"
Paused = "Yellow"
}

$keys = $keycolor.keys -join "|"

foreach ($line in $split) {
    If ($line -match $keys) {
        [string]$m = $matches.Values[0].trim()
        #get index of match
        $i = $line.IndexOf($m)
        $line.Substring(0,$i) | Write-Host -NoNewline
        $line.Substring($i) | Write-Host -ForegroundColor $keyColor.item($m)
    }
    else {
        #just write line
        Write-Host $line
        }
    }
}