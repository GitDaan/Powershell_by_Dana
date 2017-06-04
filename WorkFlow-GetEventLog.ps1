WorkFlow Get-EventLogData

{

 Parallel

 {

   Get-EventLog -LogName application -Newest 1

   Get-EventLog -LogName system -Newest 1

   Get-EventLog -LogName ‘Windows PowerShell’ -Newest 1 } }

   #Can be called in such a way that this will run on multiple servers
   #Get-EventLogData -PSComputerName <svr1>, <svr2>, ...