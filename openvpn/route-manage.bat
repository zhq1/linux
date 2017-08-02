@Echo Off&Title sicdt
cd /d %~dp0
mode con cols=42 lines=22
color 2F
>nul 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>nul
    Exit /b
)
:Menu
Cls
Echo.
Echo.&Echo     添加内网路由 → 1
Echo.&Echo     删除内网路由 → 2
Echo.&Echo     退出管理终端 → 3
Echo.
:Menu
Set /p a=输入数字按回车：
If "%a%"=="1" Goto In
If "%a%"=="2" Goto Un
If "%a%"=="3" Goto Ex
Echo.&Echo 输入无效，请重新输入！
pause >nul
Goto Menu
:In
route -p add 10.10.66.0 mask 255.255.255.0 10.10.6.1
route -p add 59.252.101.32 mask 255.255.255.224 10.10.6.1
Echo.&Echo                完成...
Goto fanhui
:Un
route -p delete 10.10.66.0 mask 255.255.255.0 10.10.6.1
route -p delete 59.252.101.32 mask 255.255.255.224 10.10.6.1
Goto fanhui
:EX
exit
:fanhui
Echo.&Echo                完成...
ping -n 2 10>nul
goto menu


