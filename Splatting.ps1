#These two do the same thing. But the second is more readable and understandable.

Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName localhost -Filter 'DriveType=3' #is that a backtick or a single quote?


$params = @{'ClassName'    = 'Win32_LogicalDisk';
            'ComputerName' = 'localhost';
            'Filter'       = 'DriveType=3'}
Get-CimInstance @params

######### check this out! ####################################

Measure-Command {Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName localhost -Filter 'DriveType=3'}

Measure-Command {
                $params = @{'ClassName'    = 'Win32_LogicalDisk';
            'ComputerName' = 'localhost';
            'Filter'       = 'DriveType=3'}
}