@echo off
@set "VS17COMMONTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\Preview\Enterprise\Common7\Tools\"
@if NOT EXIST "%VS17COMMONTOOLS%" goto error_VS17_notfound
@call "%VS17COMMONTOOLS%VsDevCmd.bat"

pushd %~dp0

echo.
echo fo-dicom NuGet package builder
echo ==============================
echo. 
echo This Windows batch file uses NuGet to automatically
echo build the fo-dicom NuGet packages.
echo. 

timeout /T 5

:: Set version info
call version.cmd
set output=.\bin\nupkg

:: Create output directory
IF NOT EXIST %output%\nul (
    mkdir %output%
)

dir ..\Native\Universal\bin\x86\Release\DICOM.Native.Universal
dir ..\Platform\Universal\bin\x86\Release
dir ..\Native\Universal\bin\x86\Release\DICOM.Native.Universal
dir ..\Platform\Universal\bin\x64\Release
dir ..\Native\Universal\bin\x64\Release\DICOM.Native.Universal
dir ..\Platform\Universal\bin\ARM\Release
dir ..\Native\Universal\bin\ARM\Release\DICOM.Native.Universal

copy ..\Platform\Universal\bin\x86\Release\Dicom.Core.dll .\
corflags /32BITREQ- /FORCE .\Dicom.Core.dll

pause

:: Remove old files
forfiles /p %output% /m *.nupkg /c "cmd /c del @file"


echo.
echo Creating packages...

forfiles /m fo-dicom.Universal.nuspec /c "cmd /c nuget.exe pack @File -Version %version% -OutputDirectory %output%"

pause

:eof