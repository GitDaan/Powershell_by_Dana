Function Filter-NewFile($Day)
{
    begin {$today = Get-Date}
    process {if ($_.LastWriteTime.AddDays($Day) -gt $today) {$_} }
    }

# Where-Object is just an ad-hoc scriptblock with a built-in 'if' clause. It can be easily turned into a named (reusable) function

    