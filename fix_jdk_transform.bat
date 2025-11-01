@echo off
echo Fixing JDK Image Transformation Error...
echo.

echo Step 1: Stopping Gradle daemon...
call gradlew --stop
timeout /t 3 /nobreak >nul

echo.
echo Step 2: Removing locked transform cache...
if exist "%USERPROFILE%\.gradle\caches\transforms-3\transforms-3.lock" (
    del /f /q "%USERPROFILE%\.gradle\caches\transforms-3\transforms-3.lock"
    echo Lock file removed.
)

timeout /t 2 /nobreak >nul

if exist "%USERPROFILE%\.gradle\caches\transforms-3" (
    echo Attempting to remove transform cache...
    rmdir /s /q "%USERPROFILE%\.gradle\caches\transforms-3" 2>nul
    if exist "%USERPROFILE%\.gradle\caches\transforms-3" (
        echo Some files might still be locked. Please close Android Studio and try again.
    ) else (
        echo Transform cache cleared successfully.
    )
)

echo.
echo Step 3: Cleaning build directories...
if exist "build" (
    rmdir /s /q "build"
)
if exist "app\build" (
    rmdir /s /q "app\build"
)

echo.
echo Cleanup complete!
echo.
echo Now try building your project with: gradlew build
echo.
pause

