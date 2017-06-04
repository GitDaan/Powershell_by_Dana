Function Calc-HeatIndex {

[cmdletbinding()]
param (
    [Parameter (Mandatory=$true, Position=1)]
    [double] $Temp,
    [Parameter (Mandatory=$true, position=2)]
    [double] $RH
    )


$Calc = (-42.379 + (2.04901523 * $Temp) + `
(10.14333127 * $RH) - (0.22475541 * $Temp * $RH)`
- (6.83783 * [Math]::pow(10,-3) * [Math]::pow($Temp,2)) `
- (5.481717 * [Math]::pow(10,-2) * [Math]::pow($RH,2)) `
+ (1.22874 * [Math]::pow(10,-3) * [Math]::pow($Temp,2) * $RH) `
+ (8.5282 * [Math]::pow(10,-4) * $Temp * [Math]::pow($RH,2)) `
- (1.99 * [Math]::pow(10,-6) * [Math]::Pow($Temp,2) * [Math]::pow($RH,2)))

Write-Output $Calc


}