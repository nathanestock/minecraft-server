@echo off
setlocal enabledelayedexpansion

REM List file (same folder as bat)
set "LIST=%~dp0_client-only.txt"

REM Correct target directory = same folder as bat
set "TARGET=%~dp0"

echo Target directory: %TARGET%
echo Using list: %LIST%
echo.

for /f "usebackq delims=" %%A in ("%LIST%") do (
    for /f "tokens=2 delims=()" %%B in ("%%A") do (
        set "file=%%B"

        REM trim spaces
        for /f "tokens=* delims= " %%C in ("!file!") do set "file=%%C"

        set "fullpath=%TARGET%!file!"

	echo DEBUG FILE = "!fullpath!"

        if exist "!fullpath!" (
            echo Deleting: !fullpath!
            del /f /q "!fullpath!"
        ) else (
            echo Not found: !file!
        )
    )
)

echo.
echo Done.
pause