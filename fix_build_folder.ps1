# PowerShell script to fix build folder access issues
# Run this script as Administrator if needed

Write-Host "=== Fixing Build Folder Access Issues ===" -ForegroundColor Cyan

# Step 1: Kill Java processes
Write-Host "`n1. Stopping Java processes..." -ForegroundColor Yellow
$javaProcesses = Get-Process -Name java,javaw,gradle -ErrorAction SilentlyContinue
if ($javaProcesses) {
    $javaProcesses | Stop-Process -Force
    Write-Host "   Stopped $($javaProcesses.Count) process(es)" -ForegroundColor Green
} else {
    Write-Host "   No Java/Gradle processes found" -ForegroundColor Green
}

# Step 2: Wait a bit
Write-Host "`n2. Waiting 3 seconds..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# Step 3: Try to delete build folder
Write-Host "`n3. Attempting to delete build folder..." -ForegroundColor Yellow
$buildPath = "app\build"
if (Test-Path $buildPath) {
    try {
        Remove-Item -Path $buildPath -Recurse -Force
        Write-Host "   Build folder deleted successfully!" -ForegroundColor Green
    } catch {
        Write-Host "   ERROR: Could not delete build folder" -ForegroundColor Red
        Write-Host "   $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "`n   MANUAL STEPS REQUIRED:" -ForegroundColor Yellow
        Write-Host "   1. Close Android Studio completely" -ForegroundColor White
        Write-Host "   2. Pause OneDrive sync (Right-click OneDrive icon > Pause syncing)" -ForegroundColor White
        Write-Host "   3. Open Task Manager (Ctrl+Shift+Esc)" -ForegroundColor White
        Write-Host "   4. End all 'java.exe' and 'javaw.exe' processes" -ForegroundColor White
        Write-Host "   5. Manually delete the folder: $((Resolve-Path $buildPath -ErrorAction SilentlyContinue).Path)" -ForegroundColor White
    }
} else {
    Write-Host "   Build folder doesn't exist (already deleted)" -ForegroundColor Green
}

Write-Host "`n=== Done ===" -ForegroundColor Cyan
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Pause OneDrive sync (if you haven't already)" -ForegroundColor White
Write-Host "2. Open Android Studio" -ForegroundColor White
Write-Host "3. Build > Clean Project" -ForegroundColor White
Write-Host "4. Build > Rebuild Project" -ForegroundColor White


