# PowerShell script for force cleaning build directories
Write-Host "Force Cleaning Build Directories..." -ForegroundColor Yellow
Write-Host ""
Write-Host "WARNING: Please close Android Studio before running this script!" -ForegroundColor Red
Write-Host ""
$null = Read-Host "Press Enter to continue"

# Step 1: Stop Gradle daemons
Write-Host ""
Write-Host "Step 1: Stopping Gradle daemons..." -ForegroundColor Cyan
try {
    & .\gradlew.bat --stop 2>&1 | Out-Null
} catch {
    Write-Host "Gradle wrapper not found or already stopped" -ForegroundColor Yellow
}
Start-Sleep -Seconds 3

# Step 2: Kill Java processes
Write-Host ""
Write-Host "Step 2: Stopping Java processes..." -ForegroundColor Cyan
Get-Process -Name java,javaw -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Function to remove directory with retries
function Remove-DirectoryWithRetry {
    param(
        [string]$Path,
        [int]$MaxRetries = 5
    )
    
    if (-not (Test-Path $Path)) {
        return $true
    }
    
    for ($i = 1; $i -le $MaxRetries; $i++) {
        Write-Host "Attempt $i of $MaxRetries: Removing $Path..." -ForegroundColor Gray
        try {
            Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
            Write-Host "Successfully removed: $Path" -ForegroundColor Green
            return $true
        } catch {
            if ($i -lt $MaxRetries) {
                Write-Host "Directory locked, waiting before retry..." -ForegroundColor Yellow
                Start-Sleep -Seconds 2
            } else {
                Write-Host "Failed to remove: $Path" -ForegroundColor Red
                Write-Host "Error: $_" -ForegroundColor Red
                return $false
            }
        }
    }
    return $false
}

# Step 3: Remove build directories
Write-Host ""
Write-Host "Step 3: Removing build directories..." -ForegroundColor Cyan

$buildDir = Join-Path $PSScriptRoot "build"
$appBuildDir = Join-Path $PSScriptRoot "app\build"

Remove-DirectoryWithRetry -Path $buildDir
Remove-DirectoryWithRetry -Path $appBuildDir

# Step 4: Clear transform cache
Write-Host ""
Write-Host "Step 4: Clearing Gradle transform cache..." -ForegroundColor Cyan
$transformCache = Join-Path $env:USERPROFILE ".gradle\caches\transforms-3"
if (Test-Path $transformCache) {
    Remove-DirectoryWithRetry -Path $transformCache
}

Write-Host ""
Write-Host "Cleanup completed!" -ForegroundColor Green
Write-Host ""
Write-Host "If some directories couldn't be removed:" -ForegroundColor Yellow
Write-Host "1. Close Android Studio completely" -ForegroundColor White
Write-Host "2. Close any File Explorer windows showing these directories" -ForegroundColor White
Write-Host "3. Check if anti-virus is scanning these directories" -ForegroundColor White
Write-Host "4. Run this script again" -ForegroundColor White
Write-Host ""
$null = Read-Host "Press Enter to exit"

