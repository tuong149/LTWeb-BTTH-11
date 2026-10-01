@echo off
chcp 65001 >nul
echo ======================================================================
echo    TỰ ĐỘNG BẬT TCP/IP VÀ MIXED AUTH CHO SQL SERVER (PORT 1433)
echo ======================================================================
echo.
echo Đang yêu cầu quyền Administrator để cấu hình...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"Write-Host ''[1/3] Dang bat giao thuc TCP/IP (Port 1433)...'' -ForegroundColor Cyan; Set-ItemProperty -Path ''HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\Tcp'' -Name ''Enabled'' -Value 1; Write-Host ''[2/3] Dang bat che do SQL Server Authentication (Mixed Mode)...'' -ForegroundColor Cyan; Set-ItemProperty -Path ''HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQLServer'' -Name ''LoginMode'' -Value 2; Write-Host ''[3/3] Dang khoi dong lai dich vu SQL Server...'' -ForegroundColor Cyan; Restart-Service -Name ''MSSQLSERVER'' -Force; Write-Host ''`n=== HOAN TAT: SQL SERVER DA SAN SANG CHO DU AN! ==='' -ForegroundColor Green; Start-Sleep -Seconds 3\"'"
