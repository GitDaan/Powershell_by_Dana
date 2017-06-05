#requires -Version 3.0

$AlertColors = @{ForegroundColor = "White"; BackgroundColor = "Red"}
 
Function Send-Quick  {
<# 
 .NOTES
    Script Name: Send-Quick.ps1 (NOT Quick-Send!) 
    Version: 1.1
    Creation Date: April 26, 2017
    Last Modify: April 27, 2017
    Author: Dana Andrews
    Location: Grant County, Wisconsin
    Contact: dandrews@co.grant.wi.gov

.Version History
    1.0 - Initial Creation
    1.1 - Add all this header stuff. Add and format the message to the console.
          Embedded credentials in case they are ever needed (un-commented out)

.Synopsis
  Pre-configured email function that only needs a 'body'  

.Description
   Powershell's email function with default properties set for fields (except Body).
   Can be used to send traditional email, just over-ride the defaults. 

.Functionality
    Quickly send short messages (snippets) to yourself (although it can do full emails)
    
.Inputs
    [string] Body is mandatory. TO/FROM/SUBJECT optional and pre-filled out.

.Outputs
    [Net.Mail.SmtpClient] and console listing of header information

.Link
  https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.utility/send-mailmessage

.Component
  Net.Mail.SmtpClient  

.Role
  Send email. Be sure to enclose body in quotes (single or double)    

.Message
    Enclose your message in quotes. ex - "Hello World"
    
.Example 
   Send-Quick "Hello World"

.Example 
   Send-Quick -To_Who user@co.grant.wi.gov -From_Who me@co.grant.wi.gov -Subject "A Test Message" -Body "Some text"

#>
[Alias('Send')]
[cmdletbinding()]
Param(
[parameter(Mandatory=$false,Position=2)][string]$SendTo='dandrews@co.grant.wi.gov',
[parameter(Mandatory=$false,Position=3)][string]$SentFrom='tmpusr@co.grant.wi.gov',
[parameter(Mandatory=$false,Position=4)][string]$SubjectIs='Quick Send From Powershell',
[parameter(Mandatory=$true,Position=1)][string]$Body
)
BEGIN {
        #$secpasswd = ConvertTo-SecureString “<password>” -AsPlainText -Force
        #$Creds = New-Object System.Management.Automation.PSCredential (“<username>”, $secpasswd)
        }#end Begin
PROCESS {
        Send-MailMessage -To $SendTo `
        -From $SentFrom `
        -Subject $SubjectIs `
        -Body $Body `
        -SmtpServer mail.co.grant.wi.gov `
        #-Credential $creds
        }#end Process
END {
        Write-Host "`n************* Email Sent *****************"
        Write-Host 'To:      '$SendTo
        Write-Host 'From:    '$SentFrom 
        Write-Host 'Subject: '$SubjectIs
        Write-Host 'Message: '$body
        Write-Host '******************************************'
        }#end End
}#end function
