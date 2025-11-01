# Smart Home Control - Project Structure

## Complete File Structure

```
pccoe project/
├── app/
│   ├── build.gradle                          # App-level Gradle configuration
│   ├── proguard-rules.pro                    # ProGuard rules
│   └── src/
│       └── main/
│           ├── AndroidManifest.xml           # App manifest with all activities
│           ├── java/com/smarthome/control/
│           │   ├── SplashActivity.java      # Flash screen (2 second splash)
│           │   ├── MainActivity.java        # Home screen with controls
│           │   ├── SetTemperatureActivity.java   # Temperature setting screen
│           │   └── SystemModeActivity.java  # System mode selection screen
│           └── res/
│               ├── drawable/
│               │   └── splash_background.xml # Splash screen background
│               ├── layout/
│               │   ├── activity_splash.xml  # Splash screen layout
│               │   ├── activity_main.xml    # Home screen layout
│               │   ├── activity_set_temperature.xml  # Temperature screen layout
│               │   └── activity_system_mode.xml     # System mode layout
│               ├── menu/
│               │   └── bottom_navigation.xml # Bottom navigation menu
│               └── values/
│                   ├── colors.xml           # Color definitions
│                   ├── strings.xml         # String resources
│                   └── themes.xml          # App themes
├── build.gradle                              # Project-level Gradle configuration
├── settings.gradle                           # Gradle settings
├── gradle.properties                         # Gradle properties
├── gradlew.bat                               # Gradle wrapper (Windows)
└── README.md                                 # Project documentation
```

## Key Features Implemented

### ✅ Splash Screen
- Displays for 2 seconds on app launch
- Shows app icon and name
- Automatically navigates to MainActivity

### ✅ Home Screen (MainActivity)
- Room name display
- Temperature and humidity information card
- "Heat to 50°" card (clickable, opens SetTemperatureActivity)
- "Cool to 90°" card (clickable, opens SetTemperatureActivity)
- Hold duration buttons (15 min, 1 hr, 4 hrs, 8 hrs)
- Bottom navigation (Home, System, Fan, Priority)

### ✅ Set Temperature Screen
- Large temperature display (50°F - 100°F)
- SeekBar for temperature adjustment
- Save button (shows Toast, returns to home)
- Cancel button (returns to home without saving)

### ✅ System Mode Screen
- List of available modes:
  - Auto
  - Cool
  - Heat
  - Off
- Tap to select (shows Toast, returns to home after 1 second)

## Navigation Flow

1. **Launch** → SplashActivity (2 sec) → MainActivity
2. **MainActivity** → Tap "Heat to 50°" or "Cool to 90°" → SetTemperatureActivity
3. **MainActivity** → Tap "System" in bottom nav → SystemModeActivity
4. **SetTemperatureActivity** → Tap "Save" → Toast → MainActivity
5. **SetTemperatureActivity** → Tap "Cancel" → MainActivity
6. **SystemModeActivity** → Tap mode → Toast → MainActivity (after 1 sec)

## Design Specifications

- **Background**: White (#FFFFFF)
- **Primary Color**: Blue (#2196F3)
- **Cards**: White with rounded corners (12dp radius)
- **Elevation**: 2-4dp shadows
- **Typography**: Material Design guidelines
- **Icons**: Material Icons + Emojis

## Technical Notes

- **Min SDK**: 24 (Android 7.0 Nougat)
- **Target SDK**: 34 (Android 14)
- **Language**: Java
- **Layout System**: ConstraintLayout
- **UI Framework**: Material Design Components
- **SeekBar Compatibility**: Uses 0-50 range to represent 50-100°F (for API 24+ compatibility)

