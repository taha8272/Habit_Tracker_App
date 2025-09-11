🌱 Habit Tracker App








Build lasting habits. Break bad ones.
A Flutter + Firebase powered habit goals tracker with Google sign-in, real-time sync, and a clean UI.

✨ Features

📅 Create, update, and delete daily habits

🔔 Reminders & goal tracking

📊 Visual progress tracking with categories

🔑 Firebase Authentication (Google & Email/Password)

☁️ Cloud Firestore for real-time habit syncing

🖼️ Profile support with Firebase Storage

🎨 Custom UI with animations and Glassmorphism

🛠️ Tech Stack

Frontend: Flutter, Google Fonts, Glass UI

Backend: Firebase (Auth, Firestore, Storage)

State Management: Riverpod

Authentication: Firebase Auth + Google Sign-In

Other Tools: UUID for habit IDs

📦 Key Dependencies
firebase_core: ^4.0.0
firebase_auth: ^6.0.1
cloud_firestore: ^6.0.0
google_sign_in: ^7.1.1
flutter_riverpod: ^2.6.1
glass: ^2.0.0+2
google_fonts: ^6.3.0
uuid: ^4.5.1

🧪 Testing

Currently includes widget tests (test/widget_test.dart).
Planned:

Unit tests for habit model

Integration tests for Firebase Auth & Firestore (with mocks)

📸 Screenshots / Demo

(Add screenshots or a GIF demo here, e.g., from your emulator — strongly boosts repo appeal.)

📁 Project Structure
lib/
 ├── models/         # Data models (habit, category)
 ├── providers/      # Riverpod providers
 ├── screens/        # UI screens
 ├── widgets/        # Reusable UI components
 ├── firebase_options.dart
 └── main.dart

🚀 Getting Started
Prerequisites

Install Flutter SDK

Firebase project setup (add google-services.json / GoogleService-Info.plist)

Run the app
flutter pub get
flutter run

🤝 Contributing

Yes, contributions are welcome!

Fork the repo

Clone your fork:

git clone https://github.com/your-username/Habit_Tracker_App.git


Create a feature branch:

git checkout -b feature/your-feature


Commit & push:

git commit -m "Add feature"
git push origin feature/your-feature


Open a Pull Request

📜 License

This project is licensed under the MIT License.
