#This is about making a class object using Powershell 5.1
#Author Dana C. Andrews
#I've forgotten which website this came from
#Note Date: June 4, 2017

class InfoObject
{
    [string]$BiosVersion
    [datetime]$Date
    [string]$env:User

    InfoObject($Biosversion,$Date,$User)
    {
        $this.BiosVersion = $Biosversion
        $this.Date = $Date
        $this.User = $User
        }
    }
