function Check-Expires {
"`nExpired Password List"            
Get-ADUser -Filter {pwdLastSet -eq 0} |
 Select-Object Name, DistinguishedName | ogv 
 }

