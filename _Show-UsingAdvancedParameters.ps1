function Get-Advanced {
<#
    This quick clip shows how to set up -confirm, -verbose, and this whole thing about risk.
#>
  
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact="Medium")]
    param (
        [parameter (Mandatory=$True, position=1, valueFromPipeline=$true)]
        [String] $Hi
     )
    PROCESS {
         if ($pscmdlet.ShouldProcess($param1)) {
            Write "Deleting..."
        }
        Write-Output "`n Hello $Hi"
    }
}