@echo off
set "inputfile=repo-list-from-json.txt"
set "outputfile=new_repo_file.txt"

if exist "%outputfile%" del "%outputfile%"

for /f "tokens=*" %%a in ('type "%inputfile%" ^| findstr /v /c:"/plugins/"') do (
    echo %%a >> "%outputfile%"
)

echo Done. Check "%outputfile%" for the result.