#Requires -Version 3.0

Function Check-Net462 
{
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   File Name:   
   Date Create:
   Author:
   Contact:
   Current Version:
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>

    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  ConfirmImpact='Low')]
    [Alias('C462')]
    [OutputType([String])]
    Param
    (
         #Param1 
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        $ComputerName        
    )

    Begin
    {
        
    }#end Begin
    Process
    {
        if ($pscmdlet.ShouldProcess($ComputerName)){
        Try {
        $ComputerName = Get-content -Path 'c:\PSTemp\dotNetServers.txt' | ForEach-Object -ErrorAction SilentlyContinue -ErrorVariable MyErrors {
            If (((Get-service winrm -computername $_).Status) -ne "running") {(Get-service winrm -computername $_).Start()}
        If ((invoke-command -computername $_ -scriptblock {test-path -Path "HKLM:\Software\Microsoft\.NetFramework\v4.0.30319\SKUs\.NetFramework,Version=v4.6.2"})-eq $true) {
    $IsCompliant += "$_ is .Net 4.6.2 compliant `n" } ELSE { $IsNotCompliant += "$_ Needs to be Upgraded `n"}
    }#end Foreach-Object
    } Catch {
        Write-Host "$ComputerName is not WinRM Compliant"
    } #end Try/Catch
        }#End If $pscmdlet
    }#end Process
    End  {
        Write-Host "Number of errors encountered "$MyErrors.Count
        $IsNotCompliant | Out-File -FilePath "c:\PSTemp\462CheckResults.txt" 
        $IsCompliant | Out-File -FilePath "c:\PSTemp\462CheckResults.txt" -Append
    }#end End
}#End Function


