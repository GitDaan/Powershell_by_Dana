function Show-LookForParameter {
[Cmdletbinding()]
Param (
        [switch] $Quick = $false,
        [switch] $Full = $false
        ) #end of Params
If ($Quick) {
    "Quick was set" }
    ElseIf ($Full) {
    "Full was set"}
    Else {"Nothing was set, raw to follow"}




} #end of function