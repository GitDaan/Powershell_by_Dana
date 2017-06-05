Function Restart-Server {
<#
    
    Script Name: Restart-Server.ps1
    Creation Date: April 5, 2017
    Last Modify: N/A
    Author: D Andrews
    Location: Grant County, Wisconsin
.Synopsis
  Restarts a remote workstation/server and initiates continuous ping.  
.Description
   This function restarts remote installations. It then starts a continuous ping 
   to allow monitoring of restart progress (user will have to use Ctrl+C to 
   stop the ping)
.Parameter ServerName
  Name of the computer to be restarted. No path data is needed for domain machines.
  This parameter is mandatory
.Example
   # Restart a server
   Restart-Server  -ServerName  <computername> (if you leave the parameter out, you will be asked to provide it)
#>
[Alias('RSS')]

[cmdletbinding()]    
param (
        [parameter (mandatory=$true, position=0)]
        [string] $ServerName
       )

Begin {}#begin

Process {
         Restart-Computer -ComputerName $ServerName -Force
         PING.EXE -t $ServerName
      }#process

End {}#end
}#function