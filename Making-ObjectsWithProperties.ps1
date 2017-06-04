$items = 1..1000

foreach ($item in $items) {
    $obj = New-Object -TypeName psobject |
    Add-Member -MemberType NoteProperty -Name "Something" -Value $item -PassThru |
    Add-Member -MemberType NoteProperty -Name "Else" -Value (Get-Date) -PassThru |
    Add-Member -MemberType NoteProperty -Name "Again" -Value $item++
        Write-Output $Obj
    }
    


foreach ($item in $items) {
    $props = @{'Something'=$item;
                'Else'=(Get-Date);
                'Again'=$item++}
        New-Object -TypeName psobject -Property $props
}

