Function Test-NetSmartRunning {

	[Alias('TNS')]
	[CmdletBinding()]
	Param (
	)
Begin { }#begin
Process {
	#$z = @{Expression={$_.Name};Label="Name";width=25},@{Expression={$_.Status};Label="Status";width=15}
	$S = foreach ($A in (Get-Service -name NHC_* -ComputerName Heall)) `
	{$A | Select-Object Name, Status}
	
	}#process
End {   $S | ogv 
	}#end
}#function