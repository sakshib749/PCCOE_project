# Smart Home Control - Android App

A complete Android Studio application built with Java and XML that provides a modern interface for controlling home temperature systems.

## Features

- **Splash Screen**: Beautiful flash screen on app launch
- **Home Screen**: Displays room information (temperature, humidity) with heat/cool controls
- **Temperature Control**: Adjust target temperature with a seekbar
- **System Mode Selection**: Choose between Auto, Cool, Heat, and Off modes
- **Bottom Navigation**: Easy navigation between Home, System, Fan, and Priority screens
- **Material Design**: Clean, modern UI with Material Components

## Project Structure

```
app/
├── src/main/
│   ├── java/com/smarthome/control/
│   │   ├── SplashActivity.java      # Flash screen activity
│   │   ├── MainActivity.java        # Home screen
│   │   ├── SetTemperatureActivity.java    # Temperature setting screen
│   │   └── SystemModeActivity.java  # System mode selection screen
│   ├── res/
│   │   ├── layout/
│   │   │   ├── activity_splash.xml
│   │   │   ├── activity_main.xml
│   │   │   ├── activity_set_temperature.xml
│   │   │   └── activity_system_mode.xml
│   │   ├── values/
│   │   │   ├── strings.xml
│   │   │   ├── colors.xml
│   │   │   └── themes.xml
│   │   ├── menu/
│   │   │   └── bottom_navigation.xml
│   │   └── drawable/
│   │       └── splash_background.xml
│   └── AndroidManifest.xml
├── build.gradle
└── settings.gradle
```

## How to Use

### Installation

1. Open Android Studio
2. Open this project folder
3. Sync Gradle files
4. Run the app on an emulator or physical device

### Navigation

- **Home Screen**: View room temperature and humidity
  - Tap "Heat to 50°" → Opens temperature setting screen
  - Tap "Cool to 90°" → Opens temperature setting screen
  - Tap bottom navigation items to navigate

- **Set Temperature Screen**:
  - Adjust temperature using the seekbar (50°F - 100°F)
  - Tap "Save" → Shows confirmation toast and returns to home
  - Tap "Cancel" → Returns to home without saving

- **System Mode Screen**:
  - Tap any mode (Auto, Cool, Heat, Off) to select
  - Shows confirmation toast and returns to home

## Technical Details

- **Minimum SDK**: 24 (Android 7.0)
- **Target SDK**: 34 (Android 14)
- **Language**: Java
- **Layout**: XML with ConstraintLayout
- **UI Components**: Material Design Components
- **Icons**: Material Icons and Emojis

## Requirements

- Android Studio Hedgehog or later
- JDK 8 or higher
- Android SDK 24+

## Dependencies

- androidx.appcompat:appcompat:1.6.1
- com.google.android.material:material:1.10.0
- androidx.constraintlayout:constraintlayout:2.1.4
- androidx.cardview:cardview:1.0.0
- androidx.navigation:navigation-fragment:2.7.5
- androidx.navigation:navigation-ui:2.7.5

## Code Style

- Well-commented code for beginners
- Clean and easy-to-understand structure
- Follows Android best practices
- Material Design guidelines

