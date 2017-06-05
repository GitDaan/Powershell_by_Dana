#Requires -Version 3.0

function Find-ParameterAlias
{
<#
.Synopsis
   find aliases for parameters in a command
.DESCRIPTION
   Parameters have aliases too! Who knew!!
.EXAMPLE
   Find-ParameterAlias Get-Command
.INPUTS
   [PSObject] Command to be queried
.OUTPUTS
   [String] Alias(es) for parameters
.NOTES
   File Name: Find-ParameterAlias   
   Date Create: May 8, 2017
   Author: Dana C. Andrews
   Contact: dandrews@co.grant.wi.gov
   Current Version: 1.0
.COMPONENT
   Unknown
.ROLE
   HelpDesk
.FUNCTIONALITY
   Help
#>

    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$true
                  #HelpUri = 'http://www.microsoft.com/',
                  #ConfirmImpact='Medium'
                  )]
    [Alias('FPA')]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(1,1)]
        #[ValidateLength([int] minLength, [int] maxLength)]
        #[ValidatePattern([string]regexString)]
        #[ValidateRange([object] minValue, [object] maxValue)]
        #[ValidateSet([string] "Value","Value"...)]
        [array] $cmd        
    )

    Begin
    {
    }#end Begin
    Process
    {
        if ($pscmdlet.ShouldProcess("Target", "Operation"))
        { (Get-Command $cmd).Parameters.GetEnumerator() | Select-Object Key,@{n='Aliases';e={$_.Value.Aliases}}
        }#End 'If $pscmdlet'
    }#end Process
    End
    {
    }#end End
}#End Function