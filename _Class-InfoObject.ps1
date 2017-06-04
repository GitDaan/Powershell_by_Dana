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

#Here is one from Ed Wilson (Hey Scripting Guy)
# https://blogs.technet.microsoft.com/heyscriptingguy/2015/09/01/powershell-5-create-simple-class/

Class Car {
    [string] $Vin
    static [int] $NumberOfWheels = 4
    [int] $NumberOfDoors
    [datetime] $Year
    [string] $Model
}

$Chevy = New-Object car
$chevy::NumberOfWheels
$Chevy.Vin = 123456789
$MyCar = $Chevy.Vin
$MyCar   #(will show the vin number)