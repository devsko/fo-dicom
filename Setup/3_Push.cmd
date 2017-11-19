@echo off
pushd %~dp0

echo.
echo fo-dicom NuGet package publisher
echo ================================
echo. 
echo This Windows batch file uses NuGet to automatically
echo push the fo-dicom package to the gallery.
echo. 

timeout /T 5

:: Directory settings
set output=.\bin\nupkg
set current=..\..

echo.
echo Current directory: %current%
echo Output  directory: %output%
echo.

forfiles /p %output% /m *.nupkg /c "cmd /c %current%\NuGet.exe push @file -ApiKey VSTS -Source https://dktechnologies.pkgs.visualstudio.com/_packaging/dktech/nuget/v3/index.json"

pause