@echo off
echo Force Cleaning Build Directories...
echo.
echo WARNING: Please close Android Studio before running this script!
echo.
pause

echo.
echo Step 1: Stopping Gradle daemons...
call gradlew.bat --stop 2>nul
timeout /t 3 /nobreak >nul

echo.
echo Step 2: Killing any Java processes (Gradle daemons)...
taskkill /F /IM java.exe /T 2>nul
taskkill /F /IM javaw.exe /T 2>nul
timeout /t 2 /nobreak >nul

echo.
echo Step 3: Removing build directories with retry...
echo Attempting to remove build directories...

set MAX_RETRIES=5
set RETRY_COUNT=0

:RETRY_BUILD
set /a RETRY_COUNT+=1
echo Attempt %RETRY_COUNT% of %MAX_RETRIES%...

if exist "build" (
    echo Removing root build directory...
    rmdir /s /q "build" 2>nul
    if exist "build" (
        if %RETRY_COUNT% LSS %MAX_RETRIES% (
            timeout /t 2 /nobreak >nul
            goto RETRY_BUILD
        ) else (
            echo WARNING: Could not remove 'build' directory. Some files may be locked.
        )
    ) else (
        echo Root build directory removed successfully.
    )
)

set RETRY_COUNT=0

:RETRY_APP_BUILD
set /a RETRY_COUNT+=1

if exist "app\build" (
    echo Removing app build directory...
    rmdir /s /q "app\build" 2>nul
    if exist "app\build" (
        if %RETRY_COUNT% LSS %MAX_RETRIES% (
            timeout /t 2 /nobreak >nul
            goto RETRY_APP_BUILD
        ) else (
            echo WARNING: Could not remove 'app\build' directory.
            echo You may need to manually close any processes using these files.
            echo Try closing Android Studio, file explorers, or anti-virus software.
        )
    ) else (
        echo App build directory removed successfully.
    )
)

echo.
echo Step 4: Clearing Gradle transform cache...
if exist "%USERPROFILE%\.gradle\caches\transforms-3" (
    rmdir /s /q "%USERPROFILE%\.gradle\caches\transforms-3" 2>nul
    if exist "%USERPROFILE%\.gradle\caches\transforms-3" (
        echo WARNING: Transform cache could not be removed.
        echo You may need to close Android Studio and try again.
    ) else (
        echo Transform cache cleared.
    )
)

echo.
echo Cleanup attempt completed!
echo.
pause

