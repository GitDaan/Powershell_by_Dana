Function Rename-GCComputer {
[cmdletbinding()]
Param(
	[parameter()]
	[string[]] $CurrentName,
	[parameter()]
	[string] $NewName,
	[parameter()]
	[string] $Dept	
)

BEGIN {  }#begin

PROCESS {
	Rename-Computer -ComputerName $CurrentName -NewName $NewName -DomainCredential grantcounty\administrator -force -restart
	get-adcomputer $NewName | Move-ADObject -TargetPath $((Get-ADOrganizationalUnit -ldapFilter '(name=$Dept)').DistinguishedName)
}#process

END {  }#end