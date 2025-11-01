@echo off
echo Cleaning Gradle cache to fix JDK image transformation issues...
echo.

echo Removing Gradle transform cache...
if exist "%USERPROFILE%\.gradle\caches\transforms-3" (
    rmdir /s /q "%USERPROFILE%\.gradle\caches\transforms-3"
    echo Transform cache cleared.
) else (
    echo Transform cache not found.
)

echo.
echo Removing build directories...
if exist "build" (
    rmdir /s /q "build"
    echo Root build directory cleared.
)
if exist "app\build" (
    rmdir /s /q "app\build"
    echo App build directory cleared.
)

echo.
echo Cleaning Gradle build cache...
if exist "%USERPROFILE%\.gradle\caches\build-cache-1" (
    rmdir /s /q "%USERPROFILE%\.gradle\caches\build-cache-1"
    echo Build cache cleared.
)

echo.
echo Cache cleanup complete!
echo Now try running: gradlew clean build
pause

