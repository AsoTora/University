Get-Process | Convertto-html -Property Name, CPU > Processes.html
Invoke-Item Processes.html

Get-wmiobject -Class Win32_Processor | Format-list *.

# Получение информации о процессах
Get-Process | %{ 
    if ($_.VM -gt 100mb){ 
        Write-Host ($_.ProcessName, $_.VM) -separator "-" -BackgroundColor Red 
    } else { 
        write-Host ($_.ProcessName, $_.vm) -separator "-" -BackgroundColor green
    }  
}

# Получение информации о файлах в папке c параметром
[CmdletBinding()] 
Param( 
    [parameter(Mandatory = $true, HelpMessage = "Enter extension")] 
    [string[]]$skip 
) 

$sum = 0 

Get-ChildItem "C:\Windows" -force | %{ if($_.GetType().Name -eq "FileInfo" -and !$skip.Contains($_.Extension)) {$sum += $_.Length/1Mb}} 

"$sum Mb"  