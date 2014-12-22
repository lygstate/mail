taskkill /f /t /im atom.exe
cd /d "%~dp0"
call "%CD%\build\win32\atom-shell\atom"
pause