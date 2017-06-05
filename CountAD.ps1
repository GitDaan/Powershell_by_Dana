
$filepath="c:\Users\dandrews\desktop\CompanyUsers.csv"
$outmatrix = @()
$ou=Get-ADOrganizationalUnit -filter * #-searchbase "OU=Grant County Users, DC=co, DC=grant, DC=wi, DC=gov" -filter * -searchscope 1
foreach ($o in $ou)
{$count=@(Get-ADUser -searchbase $o -searchscope 1 -filter * |Where-Object {$_.enabled -eq $True}).count

#Construct an object
$matrix = "" | Select "ou", "count"
$matrix.ou = $o
$matrix.count = $count
$outmatrix += $matrix
$matrix = $null
}
$outmatrix # |export-csv $filepath -notypeinformation