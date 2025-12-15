@echo off
setlocal

echo Checking if Node.js is installed...

where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js not found. Installing...
    
    rem Download Node.js LTS installer
    powershell -Command "Invoke-WebRequest -Uri https://nodejs.org/dist/latest-v18.x/node-v18.19.1-x64.msi -OutFile node_installer.msi"

    echo Running installer silently...
    msiexec /i node_installer.msi /qn

    echo Waiting for Node installation to finish...
    timeout /t 10 >nul

    where node >nul 2>nul
    if %errorlevel% neq 0 (
        echo Node install failed. Fix your system.
        pause
        exit /b
    )
    echo Node installed successfully.
) else (
    echo Node.js is already installed.
)

echo Starting server in background...
start "" cmd /c "node server.js"

echo Opening browser...
start http://localhost:3000

echo Done.
