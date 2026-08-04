# 🤖 Social Media Development Agent

Agent AI otonom yang dapat mengembangkan aplikasi mobile media sosial lengkap menggunakan Flutter dan Firebase.

## 🎯 Overview

Agent ini dapat secara mandiri:
- ✅ Merencanakan arsitektur aplikasi
- ✅ Membuat proyek Flutter lengkap
- ✅ Mengimplementasi semua fitur media sosial
- ✅ Mengkonfigurasi backend Firebase
- ✅ Menjalankan tes dan validasi

## 📱 Fitur yang Diimplementasi

### Core Features
- **Authentication** - Email/password, Google Sign-In, password reset
- **User Profiles** - Profil lengkap dengan avatar, bio, statistik
- **Social Graph** - Follow/unfollow, followers, following
- **Posts & Feed** - Buat post, timeline, likes, comments, shares
- **Stories** - Stories 24 jam dengan foto/video
- **Messaging** - Direct messages, group chats, media sharing
- **Video/Audio Calls** - Panggilan video dan audio
- **Live Streaming** - Siaran langsung dengan viewer interaction
- **Groups** - Grup dan komunitas dengan admin controls
- **Notifications** - Real-time push notifications
- **Monetization** - Freemium model dengan subscription

### Technical Stack
- **Framework**: Flutter 3.x
- **Backend**: Firebase (Auth, Firestore, Storage, Cloud Functions)
- **Architecture**: Clean Architecture + BLoC
- **Localization**: Indonesia & English

## 🚀 Quick Start

### Prerequisites

1. **Python 3.8+**
   ```bash
   python --version
   ```

2. **Flutter SDK**
   ```bash
   flutter --version
   ```

3. **LLM API Key**
   ```bash
   export LLM_API_KEY='your-api-key-here'
   ```

4. **OpenHands SDK**
   ```bash
   pip install openhands-sdk
   ```

### Installation

```bash
# Clone atau salin agent
cd /workspace/project/output

# Install dependencies
pip install -r requirements.txt
```

### Usage

#### Mode Interaktif
```bash
python social_media_dev_agent.py --interactive
```

#### Mode Tugas Tunggal
```bash
python social_media_dev_agent.py "Build a social media app with chat and video calls"
```

## 📁 Project Structure

```
output/
├── social_media_dev_agent.py    # Main agent script
├── SPEC.md                     # Technical specification
├── README.md                   # This file
├── requirements.txt            # Python dependencies
└── social_app/                 # Generated Flutter app (after run)
    ├── lib/
    ├── pubspec.yaml
    ├── firebase.json
    └── android/
```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `LLM_API_KEY` | API key untuk LLM | Required |
| `LLM_BASE_MODEL` | Model yang digunakan | openhands/claude-sonnet-4-5-20250929 |
| `LLM_BASE_URL` | Base URL untuk LLM API | None |

### Firebase Setup

1. Buat proyek Firebase di [Firebase Console](https://console.firebase.google.com)
2. Aktifkan Authentication (Email/Password, Google)
3. Buat Firestore Database
4. Aktifkan Storage
5. Download configuration files:
   - `google-services.json` → Android
   - `GoogleService-Info.plist` → iOS

## 📋 Workflow

```
User Input → Main Agent → Planning Agent → Code Agent → QA Agent → Output
     ↑           ↓
     └───────────┘ (Loop if needed)
```

### Phase 1: Planning
Agent planner membuat SPEC.md dengan:
- Arsitektur teknis lengkap
- Firebase schema
- Data models
- Feature specifications

### Phase 2: Implementation
Agent coder mengimplementasi:
- Flutter project setup
- Clean Architecture structure
- Semua fitur yang diminta
- Firebase integration

### Phase 3: Quality Assurance
Agent QA memvalidasi:
- Flutter analyze
- Build verification
- Feature completeness
- Code quality

## 🎨 Generated App Features

### Authentication
```dart
// Services
- FirebaseAuthService
- GoogleSignInService
- PasswordResetService
```

### Data Layer
```dart
// Models
- UserModel
- PostModel
- StoryModel
- MessageModel
- ConversationModel
- GroupModel
- NotificationModel
- CallModel
- LiveStreamModel

// Repositories
- AuthRepository
- UserRepository
- PostRepository
- ChatRepository
- GroupRepository
```

### Presentation Layer
```dart
// BLoCs
- AuthBloc
- UserBloc
- PostBloc
- StoryBloc
- ChatBloc
- CallBloc
- LiveBloc
- GroupBloc
- NotificationBloc

// Pages
- SplashPage
- Auth pages (login, register, forgot password)
- HomePage with bottom navigation
- FeedPage
- ProfilePage
- SearchPage
- ChatListPage
- ChatPage
- CallPage
- LivePage
- GroupsPage
- NotificationsPage
- SettingsPage
```

## 📊 Firebase Collections

```
/users/{userId}
/follows/{followId}
/posts/{postId}
/likes/{likeId}
/posts/{postId}/comments/{commentId}
/stories/{storyId}
/conversations/{conversationId}
/conversations/{conversationId}/messages/{messageId}
/groups/{groupId}
/notifications/{userId}/items/{notificationId}
/liveStreams/{streamId}
```

## 🧪 Testing

```bash
# Run unit tests
cd social_app
flutter test

# Run widget tests
flutter test --widget

# Run integration tests
flutter test --integration
```

## 📈 Deployment

### Android
```bash
cd social_app
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS
```bash
cd social_app
flutter build ios --release
# Output: build/ios/iphoneos/Runner.app
```

## 🔒 Security

- Firebase Security Rules dikonfigurasi dengan ketat
- User authentication required untuk write operations
- Data isolation berdasarkan user ID
- Storage rules untuk media access control

## 📝 Customization

### Menambah Fitur Baru

1. Update `SPEC.md` dengan feature specification
2. Jalankan agent dengan requirements baru
3. Agent akan regenerate kode dengan fitur tambahan

### Mengubah UI Theme

Edit file:
```dart
lib/core/theme/app_theme.dart
lib/core/theme/app_colors.dart
```

### Menambah Bahasa

1. Tambah translation file di `lib/l10n/`
2. Update `l10n.yaml`
3. Regenerate translations

## 🐛 Troubleshooting

### Build Error
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Firebase Connection Error
1. Check google-services.json placement
2. Verify Firebase project settings
3. Check internet connection

### Agent Not Responding
1. Check LLM_API_KEY validity
2. Increase timeout if needed
3. Check API rate limits

## 🤝 Contributing

Kontribusi terbuka! Silakan:
1. Fork repository
2. Buat feature branch
3. Submit pull request

## 📄 License

MIT License - Bebas digunakan untuk proyek komersial maupun non-komersial.

## 🙏 Credits

- Built with [OpenHands SDK](https://github.com/OpenHands/software-agent-sdk)
- Powered by AI language models
- Flutter & Firebase

---

**Catatan**: Agent ini adalah prototype. Untuk production use, diperlukan:
- Error handling yang lebih robust
- Rate limiting
- Caching strategy
- Monitoring dan logging
- CI/CD pipeline

Untuk pertanyaan atau bantuan, silakan buka issue di repository.
