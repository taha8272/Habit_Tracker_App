Habit_Tracker_App
Flutter

📝 Description
Develop good habits and break bad ones with Habit Tracker! Built with Flutter, this app helps you track your progress, set goals, and stay motivated. While still under development and undergoing testing, Habit Tracker aims to provide a simple and effective way to improve your daily routines and achieve lasting change.

✨ Features
🧪 Testing
🛠️ Tech Stack
💙 Flutter
📦 Key Dependencies
name: Habit_Goals_Tracker
description: "A new Flutter project."
publish_to: 'none' # Remove this line if you wish to publish to pub.dev
version: 1.0.0+1
sdk: flutter
cupertino_icons: ^1.0.8
google_fonts: ^6.3.0
glass: ^2.0.0+2
firebase_core: ^4.0.0
firebase_auth: ^6.0.1
flutter_riverpod: ^2.6.1
uuid: ^4.5.1
cloud_firestore: ^6.0.0
google_sign_in: ^7.1.1
flutter_signin_button: ^2.1.1
📁 Project Structure
.
├── analysis_options.yaml
├── firebase.json
├── lib
│   ├── basic.dart
│   ├── data
│   │   └── dummy_data.dart
│   ├── firebase_options.dart
│   ├── main.dart
│   ├── models
│   │   ├── category.dart
│   │   └── habit.dart
│   ├── providers
│   │   ├── habit_stream.dart
│   │   └── habits_list_provider.dart
│   ├── screens
│   │   ├── add_new_habit.dart
│   │   ├── auth.dart
│   │   ├── email_verify.dart
│   │   ├── habits_details.dart
│   │   ├── habits_list.dart
│   │   └── tabs.dart
│   └── widgets
│       ├── bar.dart
│       ├── drawer.dart
│       ├── habit_detail_card.dart
│       ├── habit_tile.dart
│       ├── habits_with_category.dart
│       └── leaderboard.dart
├── linux
│   ├── CMakeLists.txt
│   ├── flutter
│   │   ├── CMakeLists.txt
│   │   ├── generated_plugin_registrant.cc
│   │   ├── generated_plugin_registrant.h
│   │   └── generated_plugins.cmake
│   └── runner
│       ├── CMakeLists.txt
│       ├── main.cc
│       ├── my_application.cc
│       └── my_application.h
├── macos
│   ├── Flutter
│   │   ├── Flutter-Debug.xcconfig
│   │   ├── Flutter-Release.xcconfig
│   │   └── GeneratedPluginRegistrant.swift
│   ├── Runner
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets
│   │   │   └── AppIcon.appiconset
│   │   │       ├── Contents.json
│   │   │       ├── app_icon_1024.png
│   │   │       ├── app_icon_128.png
│   │   │       ├── app_icon_16.png
│   │   │       ├── app_icon_256.png
│   │   │       ├── app_icon_32.png
│   │   │       ├── app_icon_512.png
│   │   │       └── app_icon_64.png
│   │   ├── Base.lproj
│   │   │   └── MainMenu.xib
│   │   ├── Configs
│   │   │   ├── AppInfo.xcconfig
│   │   │   ├── Debug.xcconfig
│   │   │   ├── Release.xcconfig
│   │   │   └── Warnings.xcconfig
│   │   ├── DebugProfile.entitlements
│   │   ├── Info.plist
│   │   ├── MainFlutterWindow.swift
│   │   └── Release.entitlements
│   ├── Runner.xcodeproj
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace
│   │   │   └── xcshareddata
│   │   │       └── IDEWorkspaceChecks.plist
│   │   └── xcshareddata
│   │       └── xcschemes
│   │           └── Runner.xcscheme
│   ├── Runner.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   └── xcshareddata
│   │       └── IDEWorkspaceChecks.plist
│   └── RunnerTests
│       └── RunnerTests.swift
├── pubspec.lock
├── pubspec.yaml
├── test
│   └── widget_test.dart
├── web
│   ├── favicon.png
│   ├── icons
│   │   ├── Icon-192.png
│   │   ├── Icon-512.png
│   │   ├── Icon-maskable-192.png
│   │   └── Icon-maskable-512.png
│   ├── index.html
│   └── manifest.json
└── windows
    ├── CMakeLists.txt
    ├── flutter
    │   ├── CMakeLists.txt
    │   ├── generated_plugin_registrant.cc
    │   ├── generated_plugin_registrant.h
    │   └── generated_plugins.cmake
    └── runner
        ├── CMakeLists.txt
        ├── Runner.rc
        ├── flutter_window.cpp
        ├── flutter_window.h
        ├── main.cpp
        ├── resource.h
        ├── resources
        │   └── app_icon.ico
        ├── runner.exe.manifest
        ├── utils.cpp
        ├── utils.h
        ├── win32_window.cpp
        └── win32_window.h
🛠️ Development Setup
Flutter Setup
Install Flutter SDK
Run: flutter pub get
Start the app: flutter run
👥 Contributing
Contributions are welcome! Here's how you can help:

Fork the repository
Clone your fork: git clone https://github.com/taha8272/Habit_Tracker_App.git
Create a new branch: git checkout -b feature/your-feature
Commit your changes: git commit -am 'Add some feature'
Push to your branch: git push origin feature/your-feature
Open a pull request
Please ensure your code follows the project's style guidelines and includes tests where applicable.
