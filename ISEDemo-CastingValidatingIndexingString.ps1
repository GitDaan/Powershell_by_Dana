#Advanced Powershell 3.0 - Part 2 (Dauren Amanbayev)
Clear-Host

[datetime]$Xmas = "12/25/2017"
$Xmas.Day
$Xmas.DayOfWeek
$Xmas.AddDays(-90)
[datetime]$Today = Get-Date
$Today
$Till = ($XMas - $Today).Days
$Till
$Xmas.GetType().Name
$Today.GetType().Name
$Till.GetType().Name
$Msg = "There are $Till days until Christmas!"
$Msg
$BadMsg = $till + " days until Christmas!"
$BadMsg = ($Till -as [string]) + " days until Christmas"

$Types = @('int', 'long','string','char','byte','bool','decimal','single','double','datetime','array','hashtable')
ForEach ($type in $Types) {write-output $type}

[Validateset('a','b','c')][string]$x = "a"
[Validateset('a','b','c')][string]$x = "test"
$x = "test"
$x

$i = "Powershell"
"This is the variable `$i, and its value is $i"

$p = Get-Process lsass
"process id = $p.id)" #does not do what you think it will
"Process id = $($p.id)" #here is the fix

#Here String Example
$Snip = @'
    $i = "Powershell"
    "This is the variable `$i, and its value is $i"

    $p = Get-Process lsass
    "process id = $p.id)" #does not do what you think it will
    "Process id = $($p.id)" #here is the fix
'@

#More working with strings
$Service = Get-Service -Name bits
$Msg="Service Name is $($Service.name.ToUpper())"
$Msg

#Using index numbers
$Services = Get-Service
$Services[5..1]
$Services.count
$Services[253].Name
$Services[-1].Name

#Old vs New (PS version 3)
"ComputerName,IPAddress" | Out-file c:\computers.csv
"Vaio_nb1,192.168.0.6" | Out-File c:\computers.csv -Append
Get-Service -Name BITS -ComputerName (Import-Csv c:\computers.csv | Select-Object -ExpandProperty ComputerName) #0ld (Version 2 or lower Powershell) turns object to string
Get-Service -Name BITS -ComputerName (Import-Csv c:\computers.csv).Computername #New
