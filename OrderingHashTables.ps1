#Ordered HashTables
#Unordered
$prop0 =@{
'Computername' = 'Vaio'
'OS Name' = 'Win 10'
'FreeSpace' = '256gb'
} 
#Ordered
$prop1 = [ordered]@{
'Computername' = 'Vaio'
'OS Name' = 'Win 10'
'FreeSpace' = '256gb'
} 

$prop0
$prop1

#don jones style "Let objects be objects. You never know how they'll be used. Pipe to Sort-Object if sorted output is desired"
$Prop0.GetEnumerator() | Sort-Object -Property Name #hashtables need to be enumerated for Name (but not value for some strange reason)
#official explanation - Enumerate processes the hash table object into its individual entries. Sort-Object can then see the differences
$prop0.GetEnumerator() | gm
$prop0.GetEnumerator() | Sort-Object Key
$prop0.GetEnumerator() | Sort-Object Value
$prop0 | Sort-Object Value #This shouldn't work

#One last thing... You should make stuff like this objects before you send them out
$obj = New-Object -TypeName psobject -Property $prop0
Write-Output $prop0
Write-Output $obj

#And finally...
$obj | Select-Object -Property computerName, 'OS Name', FreeSpace  #Look, I'm sorted!
