@echo off
REM //---------- set up variable ----------
setlocal
set ROOT_DIR=%~dp0

chdir /d %ROOT_DIR% 

IF EXIST %USERPROFILE%\Formula-Student-Driverless-Simulator (
    echo Folder already exists
) ELSE (
    echo Creating folder
    mkdir %USERPROFILE%\Formula-Student-Driverless-Simulator   
)

IF EXIST %USERPROFILE%\Formula-Student-Driverless-Simulator\settings.json (
    echo Settings file already exists
) ELSE (
    echo Creating settings files
    copy /y ..\settings.json %USERPROFILE%\Formula-Student-Driverless-Simulator\
)

echo Setup finished !