set PATH=C:\CI-Tools\vcs\git\cmd;%PATH%
call npm install -g grunt-cli
call npm install -g vulcanize
call npm install -g bower
call npm install
call bower update
pause
::https://www.npmjs.com/package/grunt-build-atom-shell