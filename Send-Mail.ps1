#requires -Version 3.0

function Send-Mail {
<#
.NOTES
  File Name: Send-Mail.ps1
  Creation Date: April 23, 2017
  Last Modified: N/A
  Version: 1.0
  Author: Dana C. Andrews
  Contact: dandrews@co.grant.wi.gov

.VERSION HISTORY
    1.0 Initial Creation

.SYNOPSIS
    Sends an email from Powershell

.DESCRIPTION 
    Takes one (mandatory) parameter (the content you want in the body of the email)
    There is an optional parameter to specify the Subject Line

.FUNCTIONALITY 
    Send email from Powershell

.PARAMETER Body 
    Mandatory - What you want as the message in the email. Must be enclosed in quotes
    
.PARAMETER Subject 
    Optional - Allows you to set a different Subject Line than the default one.
    Must be enclosed in quotes 
 
.INPUTTYPE String
    Message must be enclosed in quotes

.RETURNVALUE
    SMTP

.LINK
    http://stackoverflow.com/questions/1252335/send-mail-via-gmail-with-powershell-v2s-send-mailmessage
     
.Body
    This is a required parameter. It is the message to be contained in the email.
    You must enclose it in either single (') or double (") quotes.

.Subject
    This is an optional parameter. It is the subject line of the email.
    You must enclose it in either single (') or double (") quotes.
    
.Alias Send

.EXAMPLE
    Send-Mail Hello World

#>
[cmdletbinding()]
param (
    [parameter (Mandatory=$true, Position=1)]
    [String] $Body,
    [parameter (Mandatory=$false, Position=2)]
    [String] $Subject = 'Email From Powershell',
    [parameter (Mandatory=$false, Position=3)]
    [String] $SendTo = 'dandrews@co.grant.wi.gov'
    )

$EmailFrom = "dcandrews@gamil.com"
$SMTPServer = "smtp.gmail.com" 
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
$SMTPClient.EnableSsl = $true 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("dcandrews", "Ironpen707"); 
$SMTPClient.Send($EmailFrom, $SendTo, $Subject, $Body)
} #end of function

If ((Test-Path alias:send) -eq $false) {New-Alias -name Send -value Send-Mail }