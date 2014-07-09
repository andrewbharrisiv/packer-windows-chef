:: Setup PATH environment variable for use in chocolety installs
:: PATH being saved in windows temp folder between provisioners
<nul set /p ".=;C:\Chocolatey\bin" >> C:\Windows\Temp\PATH
set /p PATH=<C:\Windows\Temp\PATH
setx PATH "%PATH%" /m

:: Setup environment variables needed for pacakge install
setx ChocolateyInstall "%SYSTEMDRIVE%\Chocolatey" /m
set ChocolateyInstall=%SYSTEMDRIVE%\Chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Environment]::SetEnvironmentVariable('ChocolateyInstall', '%SYSTEMDRIVE%\Chocolatey', [System.EnvironmentVariableTarget]::User)"

:: Install chocolatey packages
cmd /c chocolatey install 7zip -Version 9.22.01.20130618
cmd /c chocolatey install mingw-get -Version 1.0.2
cmd /c chocolatey install chef-client -Version 11.12.4.1
cmd /c chocolatey install ruby1.9 -Version 1.9.3.54500
cmd /c chocolatey install ruby.devkit -Version 4.5.2.20111231 
cmd /c chocolatey install nodejs.install -Version 0.10.28
cmd /c chocolatey install git.install -Version 1.9.0.20140303
cmd /c chocolatey install UrlRewrite -Version 2.0.2
cmd /c chocolatey install VisualStudio2012Professional -Version 11.0.1
cmd /c chocolatey install VisualStudio2013Professional -Version 12.0.21005.20140406 -InstallArguments "/Features:'WebTools SQL' /ProductKey:BBJ4B-WBV7Q-DFHJG-G97DD-GXXKR"

:: Install rsync via mingw-get
cmd /c %SYSTEMDRIVE%\MinGW\bin\mingw-get.exe install msys-rsync

:: Create npm module folder for vagrant user
mkdir %USERPROFILE%\AppData\Roaming\npm

:: Ensure PATH
powershell -NoProfile -ExecutionPolicy Bypass -File "A:\ensure-path.ps1"
