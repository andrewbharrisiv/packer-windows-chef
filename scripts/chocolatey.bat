:: Install chocolatey
powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" <NUL

:: Setup PATH environment variable for use in chocolety installs
:: PATH being saved in windows temp folder between provisioners
<nul set /p ".=;C:\Chocolatey\bin" >> C:\Windows\Temp\PATH
set /p PATH=<C:\Windows\Temp\PATH
setx PATH "%PATH%" /m