function New-SheriffEmailAccount {
[cmdletbinding()]
param(
    [parameter(Mandatory=$true,
               Position=0,
               HelpMessage="User's first name")]
               [Alias('fn')]
               [String] $FirstName,
    [parameter(Mandatory=$true,
               Position=1,
               HelpMessage="User's last name")]
               [Alias('ln')]
    [string] $LastName,
    [parameter(Mandatory=$true,
               Position=2,
               HelpMessage="Last 4 of social security")]
               [Alias('ssan')]
    [int]    $LastFour
)
Begin {
        $FullName = $FirstName + " " + $LastName
        $Last1stLetter = $LastName.Substring(0,1)
        $SAM = $FirstName + $Last1stLetter
        }#begin

Process {
        #Do not ever show this to Don Jones! Warning - Back ticks in use for formatting (`)
        $User = New-ADUser -Name $FullName`
                -SAMAccountName $SAM`
                -DisplayName $FullName`
                -GivenName $FirstName`
                -Surname $LastName`
                -UserPrincipalName "zachf@co.grant.wi.gov"`
                -AccountPassword (ConvertTo-SecureString "f9793" -AsPlainText -Force)`
                -EmailAddress "zfischer@co.grant.wi.gov"`
                -Department "Sheriff's Office"`
                -PasswordNeverExpires $true`
                -Path "OU=SheriffsDept,OU=Grant County Users,DC=co,DC=grant,DC=wi,DC=gov"`
                -enabled $true`
                -PassThru

        Add-ADGroupMember -Identity "cn=Grant County,cn=Users,DC=co,DC=grant,DC=wi,DC=gov" -Members $User 
        Add-ADGroupMember -Identity "cn=Sheriff Department,OU=SheriffsDept,OU=Grant County Users,DC=co,DC=grant,DC=wi,DC=gov" -Members $User 
        Add-ADGroupMember -Identity "cn=JailStaff,OU=SheriffsDept,OU=Grant County Users,DC=co,DC=grant,DC=wi,DC=gov" -Members $User 
}#process

End {  }#end

}#function