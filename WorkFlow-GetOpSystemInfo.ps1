workflow myfirstworkflow {    Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, Version}
myfirstworkflow