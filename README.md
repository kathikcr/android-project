# 📱 EdTechTube - Student Learning Platform

EdTechTube is a Flutter-based Android application that serves as a centralized educational hub for students. The app integrates various academic resources—videos, PDFs, notes—and combines them with interactive and personalized learning features. Built with Firebase backend services, EdTechTube offers a secure, scalable, and user-friendly platform for students to access and share study materials.

---

## 📂 Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Advantages](#advantages)
- [Limitations](#limitations)
- [Contributors](#contributors)
- [License](#license)

---

## 🚀 Features

- 🔐 **Secure Authentication** – Firebase Authentication for sign-in and registration.
- 🏠 **Personalized Home** – View recommended videos tailored to user preferences.
- 📁 **Content Upload** – Upload videos, PDFs, and notes.
- 📺 **Video Channel Management** – Create and manage your own educational video channel.
- 💬 **Collaborative Learning** – Comment on videos and engage in academic discussions.
- 📥 **Downloadable PDFs** – Access and download essential study materials.
- 🔎 **Resource Discovery** – Search and explore educational content from other users.
- 🌐 **Cross-Platform Ready** – Designed for deployment across mobile platforms.

---

## 🛠 Tech Stack

| Layer              | Technology       |
|-------------------|------------------|
| Frontend          | Flutter (Dart)   |
| Backend (BaaS)    | Firebase         |
| Authentication    | Firebase Auth    |
| Database          | Firebase Firestore |
| Storage           | Firebase Storage |
| State Management  | Provider / setState (based on your code) |

User
└──> Authentication (Firebase Auth)
└──> Home Page
├──> View Channels
├──> Upload Video/PDF/Notes
├──> My Channel
└──> Comment & Collaborate
Backend: Firebase Firestore & Storage

yaml
Copy
Edit

---

## 🧰 Installation

> Ensure you have Flutter SDK and Firebase CLI set up.

```bash
git clone https://github.com/kathikcr/android-project.git
cd android-project

flutter pub get

# To run on emulator or connected device
flutter run
🔑 Firebase Setup
Create a Firebase project at console.firebase.google.com

Enable Authentication, Firestore, and Storage

Add google-services.json to the /android/app directory

Configure Firebase in your Flutter app using firebase_core and firebase_auth packages.

🗂 Project Structure
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
