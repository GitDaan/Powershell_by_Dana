Param(
     [Parameter(Mandatory=$true, Position=0, HelpMessage="Password?")]
     [SecureString]$password
   )

   $pw = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

   #Get password with Write-Output $pw