# PowerShell script to forcefully remove locked build directories
Write-Host "Forcefully removing locked build directories..." -ForegroundColor Yellow
Write-Host ""

# Step 1: Stop all Java processes
Write-Host "Step 1: Stopping Java processes..." -ForegroundColor Cyan
Get-Process -Name java,javaw -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Step 2: Function to remove directory tree with aggressive retry
function Remove-LockedDirectory {
    param(
        [string]$Path,
        [int]$MaxRetries = 3
    )
    
    if (-not (Test-Path $Path)) {
        Write-Host "$Path does not exist, skipping..." -ForegroundColor Gray
        return $true
    }
    
    Write-Host "Removing: $Path" -ForegroundColor Yellow
    
    for ($i = 1; $i -le $MaxRetries; $i++) {
        try {
            # Try to remove files first, then directories
            $items = Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
            
            # Remove files first
            $items | Where-Object { -not $_.PSIsContainer } | ForEach-Object {
                try {
                    $_.Attributes = 'Normal'
                    Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
                } catch {
                    # Ignore individual file errors
                }
            }
            
            # Then remove directories from deepest to shallowest
            $dirs = $items | Where-Object { $_.PSIsContainer } | Sort-Object { $_.FullName.Length } -Descending
            foreach ($dir in $dirs) {
                try {
                    $dir.Attributes = 'Normal'
                    Remove-Item $dir.FullName -Force -Recurse -ErrorAction SilentlyContinue
                } catch {
                    # Ignore errors
                }
            }
            
            # Finally, remove the root directory
            Start-Sleep -Milliseconds 500
            if (Test-Path $Path) {
                (Get-Item $Path -Force).Attributes = 'Normal'
                Remove-Item $Path -Force -Recurse -ErrorAction Stop
            }
            
            Write-Host "Successfully removed: $Path" -ForegroundColor Green
            return $true
            
        } catch {
            if ($i -lt $MaxRetries) {
                Write-Host "Attempt $i failed, retrying..." -ForegroundColor Yellow
                Start-Sleep -Seconds 1
            } else {
                Write-Host "Failed to remove: $Path" -ForegroundColor Red
                Write-Host "Error: $_" -ForegroundColor Red
                Write-Host "You may need to:" -ForegroundColor Yellow
                Write-Host "  1. Close Android Studio completely" -ForegroundColor White
                Write-Host "  2. Close File Explorer windows" -ForegroundColor White
                Write-Host "  3. Restart your computer" -ForegroundColor White
                return $false
            }
        }
    }
}

# Step 3: Remove specific locked directories
$pathsToRemove = @(
    "app\build\intermediates\incremental\packageDebug\tmp",
    "app\build\intermediates",
    "app\build",
    "build"
)

foreach ($path in $pathsToRemove) {
    $fullPath = Join-Path $PSScriptRoot $path
    Remove-LockedDirectory -Path $fullPath
}

Write-Host ""
Write-Host "Cleanup completed!" -ForegroundColor Green
Write-Host ""
Write-Host "Note: If some directories couldn't be removed, don't worry." -ForegroundColor Yellow
Write-Host "You can proceed with building - Gradle will handle it." -ForegroundColor Yellow
Write-Host ""
$null = Read-Host "Press Enter to exit"

