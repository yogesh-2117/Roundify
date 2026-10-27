@echo off
setlocal
cd /d "%~dp0"

set "ISCC="
if exist "%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe" set "ISCC=%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe"
if not defined ISCC if exist "%ProgramFiles%\Inno Setup 6\ISCC.exe" set "ISCC=%ProgramFiles%\Inno Setup 6\ISCC.exe"
if not defined ISCC if exist "%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe" set "ISCC=%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe"

if not defined ISCC (
  echo Inno Setup 6 was not found.
  echo Install it from https://jrsoftware.org/isinfo.php, then run this script again.
  exit /b 1
)

if not exist "publish\win-x64\Roundify.exe" (
  echo Published Roundify files were not found.
  echo Run publish-win-x64.cmd before building the installer.
  exit /b 1
)

echo Building the Roundify installer...
"%ISCC%" installer\Roundify.iss
if errorlevel 1 (
  echo.
  echo Installer build failed.
  exit /b 1
)

echo.
echo Installer created:
echo %CD%\publish\Roundify-Setup.exe
endlocal
