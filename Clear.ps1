$BAM = "HKLM\SYSTEM\ControlSet001\Services\bam\State\UserSettings"
Takeown /f $BAM /r /d y
Icacls $BAM /grant Administrators:F /t
Remove-ItemProperty -Path $BAM -Recurse -Force
Icacls $BAM /remove Administrators /t

Remove-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32" -Force
Remove-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" -Force
Remove-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" -Force
Remove-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched" -Force
Remove-ItemProperty -Path "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" -Force
Remove-ItemProperty -Path "HKCR\Local Settings\Software\Microsoft\Windows\Shell" -Force
Remove-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Force

Stop-Process -Name explorer -Force
Stop-Service -Name EventLog

Remove-Item -Path "C:\Windows\Prefetch\*" -Force -Recurse
Remove-Item -Path "C:\Windows\System32\winevt\Logs\*" -Force -Recurse
Remove-Item -Path "$env:LOCALAPPDATA\ConnectedDevicesPlatform\*" -Force -Recurse
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\ConnectedDevicesCache\*" -Force -Recurse
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\ActivityCache\*" -Force -Recurse
Remove-Item -Path "$env:TEMP\*" -Force -Recurse
Remove-Item -Path "C:\Windows\appcompat\Programs\*" -Force -Recurse
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\*" -Force -Recurse
Remove-Item -Path "C:\Windows\appcompat\pca\*" -Force -Recurse
Remove-Item -Path "C:\Windows\System32\sru\SRUDB.dat" -Force
Remove-Item -Path "C:\ProgramData\NVIDIA Corporation\Drs\nvAppTimestamps" -Force
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Recent\*" -Force -Recurse
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Recent\CustomDestinations\*" -Force -Recurse
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\*" -Force -Recurse

Invoke-Expression "Rundll32.exe apphelp.dll,ShimFlushCache"

$drives = "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
foreach ($drive in $drives) {
    fsutil usn deleteJournal /d "$drive`:"
}

Start-Process explorer.exe
Start-Service -Name EventLog

Pause
