<#
Tools should produce the rawest output possible. Use format etc to clean it up
Don't make assumptions on where the tool will be run
Tools accept input by parameters only (no read-host)
Write-Output $obj (Means output objects for consumption by the pipeline)

Tools....

....CREATE INPUT FOR OTHER TOOLS
    Get-
    Import-
    ConvertFrom-

....PROCESS SOMETHING AND MAY PRODUCE OUTPUT
    Get-
    Set-
    New-
    Remove-
    Write-

....ACCEPT OUTPUT AND MAKE IT PRETTY
    Export-
    ConvertTo
    Format-
    Out- [maybe]

CONTROLLERS....

- Use one or more tools to automate a business process
- Are single-purpose
- Encapsulate input, processing, and output
- May not have a cmdlet-style name
- May display information directly to the screen [but might not]

- Menus, provisioning scripts, GUIs, report generators, etc.

#>