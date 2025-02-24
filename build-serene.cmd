@echo off
ECHO *** RUNNING BUILD ***
dotnet run --project build\build-serene.csproj %*
if %ERRORLEVEL% GEQ 1 GOTO :error
SET VSINSTALLDIR=%ProgramFiles%\Microsoft Visual Studio\2022\Community
ECHO *** RESTORING PACKAGES FOR TEMPLATE PROJECT***
Serenity\build\tools\NuGet\NuGet Restore Template\Serene.Template.sln
if %ERRORLEVEL% GEQ 2 GOTO :error
ECHO *** BUILDING TEMPLATE PACKAGE ***
"%VSINSTALLDIR%\MSBuild\Current\Bin\MSBuild.exe" "Template\Serene.Template.sln" -verbosity:m
if %ERRORLEVEL% GEQ 1 GOTO :end
start Template\bin\Debug
start https://visualstudiogallery.msdn.microsoft.com/559ec6fc-feef-4077-b6d5-5a99408a6681/edit?newSession=True
pause
EXIT /B 0
:error
ECHO ERROR %ERRORLEVEL%
pause
EXIT /B 1