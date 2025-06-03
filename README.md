# 📱 EdTechTube - Student Learning Platform

EdTechTube is a Flutter-based Android application developed to simplify the educational experience by centralizing learning resources like videos, notes, and PDFs into a single mobile platform. Built with Firebase for its backend, EdTechTube ensures secure authentication, cloud-based storage, and scalability, making it a reliable tool for students.

## Features

- Secure login and signup using Firebase Authentication.
- Upload and view educational videos.
- Upload and download study materials in PDF format.
- Create and manage personal educational channels.
- Comment on videos and engage in peer-to-peer discussions.
- Personalized video recommendations based on user preferences.
- Clean, modern user interface with smooth navigation.
- Cross-platform compatibility and cloud-based infrastructure.

## Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase
- **Authentication:** Firebase Auth (Email/Password)
- **Database:** Firebase Firestore
- **Storage:** Firebase Storage
- **State Management:** Provider / setState

User
└──> Firebase Authentication
└──> Home Page
├──> View Channels
├──> Upload Video/PDF/Notes
├──> My Channel
└──> Comment & Collaborate
Backend: Firebase Firestore & Firebase Storage


## Installation

Make sure Flutter SDK and Firebase CLI are installed on your machine.

```bash
git clone https://github.com/kathikcr/android-project.git
cd android-project
flutter pub get
flutter run


## Project Structure

lib/
├── main.dart
├── screens/
│   ├── login.dart
│   ├── home.dart
│   ├── my_channel.dart
│   ├── upload_content.dart
│   └── view_content.dart
├── services/
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   └── storage_service.dart
└── models/
    └── video_model.dart


![image](https://github.com/user-attachments/assets/b14333c8-1c10-4007-9f49-c8bf4d9fce67)
