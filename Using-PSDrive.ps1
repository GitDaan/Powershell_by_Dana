#New-PSDrive is how you map drives using Powershell
#New-PSDrive is session only unless you specify -persist
#New-PSDrive -presist is ONLY for remote nodes
#Or is it?
New-PSDrive -Name "Q" -PSProvider FileSystem -Root "\\vaio_nb1\C$\Users\Windaan\Documents\MyPowerShell\Scripts" -Persist
