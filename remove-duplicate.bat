@echo off
set "inputfile=new_repo_file.txt"
set "outputfile=unique_repo_file.txt"
set "tempfile=temp_repo_file.txt"

echo Checking if output file exists...
if exist "%outputfile%" (
    echo Output file exists. Deleting existing output file...
    del "%outputfile%"
)

echo Checking if temporary file exists...
if exist "%tempfile%" (
    echo Temporary file exists. Deleting existing temporary file...
    del "%tempfile%"
)

echo Sorting input file and adding line numbers...
sort "%inputfile%" | findstr /n "^" > "%tempfile%"

echo Processing each line...
for /f "delims=" %%a in ('type "%tempfile%"') do (
    set "line=%%a"
    setlocal enabledelayedexpansion
    set "line=!line:*:=!"
    if not exist "!line!" (
        echo !line! >> "%outputfile%"
        echo !line! > "!line!"
    )
    endlocal
)

echo Cleaning up temporary files...
for /f "delims=" %%a in ('type "%tempfile%"') do (
    set "line=%%a"
    setlocal enabledelayedexpansion
    set "line=!line:*:=!"
    if exist "!line!" (
        del "!line!"
    )
    endlocal
)

del "%tempfile%"

echo Done. Check "%outputfile%" for the unique entries.
