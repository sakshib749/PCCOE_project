# Solution for Access Denied Errors

## Quick Fix Steps:

### Step 1: Close Android Studio
- **File → Exit** (or close all Android Studio windows)
- Make sure Android Studio is completely closed

### Step 2: End All Java/Gradle Processes
1. Press **Ctrl + Shift + Esc** to open Task Manager
2. Look for these processes and end them:
   - `java.exe`
   - `javaw.exe`
   - `gradle.exe`
   - `gradlew.exe`
   - Any process with "Android" in the name
3. Right-click each → **End Task**

### Step 3: Pause OneDrive Sync (IMPORTANT!)
1. Click the **OneDrive icon** in system tray (bottom-right)
2. Click **Settings** → **Pause syncing** → **2 hours**
   - This prevents OneDrive from locking files

### Step 4: Delete Build Folder Manually
1. Open File Explorer
2. Navigate to: `C:\Users\hp\OneDrive\Desktop\pccoe project\app`
3. Delete the **`build`** folder
   - If it says "in use", wait 10 seconds and try again
   - If still locked, restart your computer

### Step 5: Rebuild in Android Studio
1. Open Android Studio
2. **Build → Clean Project**
3. Wait for completion
4. **Build → Rebuild Project**

---

## Permanent Solution: Exclude Build Folder from OneDrive

### Method 1: Exclude Specific Folder
1. Right-click **OneDrive icon** → **Settings**
2. Go to **Sync and backup** → **Advanced settings**
3. Click **Files On-Demand** settings
4. Find your project folder
5. Right-click → **Free up space** (makes it online-only)

### Method 2: Move Project Outside OneDrive (BEST SOLUTION)
1. Close Android Studio
2. Move project folder to: `C:\AndroidProjects\pccoe project`
3. Open Android Studio → **Open** → Select new location
4. Sync Gradle and rebuild

### Method 3: Use .gitignore (Already Created)
- The `.gitignore` file will help, but OneDrive may still sync
- You need to manually exclude the build folder from OneDrive

---

## Why This Happens:
- OneDrive tries to sync the `build` folder
- Android build process needs exclusive file access
- OneDrive locks files during sync → Access Denied error

## Prevention:
**Best Practice**: Always keep Android projects outside OneDrive or exclude `build` folders from sync.


