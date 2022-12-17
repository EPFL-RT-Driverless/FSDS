@echo off

setlocal
set ROOT_DIR=%~dp0

set powershell=powershell
where powershell > nul 2>&1
if ERRORLEVEL 1 goto :pwsh
echo found Powershell && goto start
:pwsh
set powershell=pwsh
where pwsh > nul 2>&1
if ERRORLEVEL 1 goto :nopwsh
set PWSHV7=1
echo found pwsh && goto start
:nopwsh
echo Powershell or pwsh not found, please install it.
goto :eof

:start
chdir /d %ROOT_DIR% 

set dir=%USERPROFILE%\Formula-Student-Driverless-Simulator
set file=%USERPROFILE%\Formula-Student-Driverless-Simulator\settings.json
set AREYOUSURE=Y

IF EXIST %dir% (
    echo Folder %dir% already exists
) ELSE (
    echo Creating %dir%
    mkdir %dir%
)

IF EXIST %file% (
    :PROMPT
    SET /P AREYOUSURE=Settings file already exists, do you want to override it ? (Y/[N])
    IF /I "%AREYOUSURE%" NEQ "Y" ( 
        echo Previous settings file kept
        GOTO END
    )
    goto CREATEFILE
    
) ELSE (
    :CREATEFILE
    echo Creating settings file
    if "%PWSHV7%" == "" (
        %powershell% -command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iwr https://raw.githubusercontent.com/EPFL-RT-Driverless/FSDS/master/settings.json -OutFile settings.json }"
    ) else (
        %powershell% -command "iwr https://raw.githubusercontent.com/EPFL-RT-Driverless/FSDS/master/settings.json -OutFile settings.json"
    )
    move settings.json %dir% >nul
)

:END
echo Setup finished !
endlocal