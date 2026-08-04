# SocialHub - Complete Social Media App

A full-featured social media mobile application built with Flutter and Firebase.

## ✨ Features

### Core Features
- 🔐 **Authentication** - Email/password, Google Sign-In
- 👤 **User Profiles** - Avatar, bio, stats, privacy settings
- 📝 **Posts & Feed** - Text, images, videos, likes, comments, shares
- 📸 **Stories** - 24hr ephemeral content
- 💬 **Messaging** - Direct messages and group chats
- 📹 **Video Calls** - Real-time video and audio calling
- 🎥 **Live Streaming** - Broadcast and watch live streams
- 👥 **Groups** - Communities with admin controls
- 🔔 **Notifications** - Real-time push notifications
- 💰 **Monetization** - Freemium model

### Technical Stack
- **Framework**: Flutter 3.x
- **Backend**: Firebase (Auth, Firestore, Storage, Cloud Functions)
- **State Management**: BLoC
- **Architecture**: Clean Architecture
- **Navigation**: go_router

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.x
- Dart 3.x
- Firebase project
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone https://github.com/antono4/myagent.git
cd myagent/output/social_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a Firebase project at https://console.firebase.google.com
   - Add Android/iOS apps to your project
   - Download configuration files:
     - `google-services.json` → `android/app/`
     - `GoogleService-Info.plist` → `ios/Runner/`

4. Update `lib/main.dart` with your Firebase config

5. Run the app:
```bash
flutter run
```

## 📱 Screens

### Authentication
- Login with email/password
- Register with username
- Password reset
- Google Sign-In

### Home & Feed
- Post feed with infinite scroll
- Like, comment, share posts
- Create new posts

### Profile
- View/edit profile
- Profile stats
- Posts grid
- Settings

### Messaging
- Conversation list
- Real-time chat
- Media sharing
- Video/Audio calls

### Groups
- Browse/join groups
- Create groups
- Group posts
- Member management

### Live
- Live streams list
- Watch live
- Go live
- Live reactions

## 🏗️ Architecture

```
lib/
├── main.dart
├── core/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/
│   ├── entities/
│   └── repositories/
└── presentation/
    ├── blocs/
    ├── pages/
    └── widgets/
```

## 🔧 Configuration

### Firebase Setup

1. Enable Authentication (Email/Password, Google)
2. Create Firestore Database
3. Enable Storage
4. Enable Cloud Functions
5. Set up Cloud Messaging

### Environment Variables

Create `lib/firebase_options.dart` with your Firebase config.

## 📦 Build

### Android
```bash
flutter build apk --debug
flutter build apk --release
```

### iOS
```bash
flutter build ios
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

MIT License

## 👨‍💻 Author

Created with ❤️ using Flutter & Firebase
