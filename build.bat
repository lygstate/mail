cd /d "%~dp0"
call grunt build:desktop:standalone --force
rd /s /q "%CD%\build\win32\atom-shell\resources\app"
pause