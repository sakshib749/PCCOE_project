# Build Directory Cleanup Instructions

## Problem
Windows sometimes locks files in the build directories, preventing deletion. This typically happens when:
- Android Studio is running
- Gradle daemon processes are active
- File Explorer has these directories open
- Antivirus software is scanning these files

## Quick Fix (PowerShell)

Run this PowerShell command (right-click in project folder > "Open in Terminal"):

```powershell
Stop-Process -Name java -Force -ErrorAction SilentlyContinue; Remove-Item -Path "build","app\build" -Recurse -Force -ErrorAction SilentlyContinue
```

## Using the Provided Scripts

### Option 1: PowerShell Script (Recommended)
```powershell
.\force_clean.ps1
```

### Option 2: Batch Script
```cmd
force_clean.bat
```

## Manual Steps

1. **Close Android Studio completely**
   - Not just the window, but quit the application

2. **Stop Gradle Daemons**
   ```cmd
   gradlew.bat --stop
   ```

3. **Kill Java Processes**
   - Open Task Manager (Ctrl+Shift+Esc)
   - Find any `java.exe` or `javaw.exe` processes
   - End Task on all of them

4. **Close File Explorer Windows**
   - Close any File Explorer windows showing the project folder

5. **Delete Build Directories**
   ```cmd
   rmdir /s /q build
   rmdir /s /q app\build
   ```

## If Files Are Still Locked

### Use Unlocker Tool
1. Download a tool like "LockHunter" or "IObit Unlocker"
2. Right-click the locked folder → Unlock
3. Then delete the folder

### Using PowerShell with Handle Closing
```powershell
# Stop Java processes
Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force

# Wait a moment
Start-Sleep -Seconds 2

# Remove directories
Remove-Item -Path "build","app\build" -Recurse -Force
```

### Alternative: Restart Computer
If nothing else works, restarting your computer will release all file locks.

## Prevention

- Always close Android Studio before running `gradlew clean`
- Use `gradlew --stop` before cleaning
- Avoid opening build directories in File Explorer while building

## After Cleanup

Once cleaned, you can rebuild:
```cmd
gradlew clean build
```

