# SDK Plan: Social Media App Development Agent

## Overview
Agent AI yang dapat secara otonom mengembangkan aplikasi mobile media sosial lengkap menggunakan Flutter dan Firebase.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    Main Orchestrator Agent                       │
│                  (Task Manager + Coordinator)                    │
└─────────────────────────────┬───────────────────────────────────┘
                              │
         ┌────────────────────┼────────────────────┐
         │                    │                    │
         ▼                    ▼                    ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│  Planning Agent │  │   Code Agent   │  │  QA Agent       │
│  (Research &     │  │  (Writing &    │  │ (Testing &      │
│   Architecture)  │  │   Editing)     │  │  Validation)    │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

## Agent Components

### 1. Main Orchestrator Agent
**Role**: Coordinator utama yang menerima task dari user dan mendelegasikan ke sub-agents.

**Tools**:
- TaskTrackerTool (task management)
- TerminalTool (execute commands)
- TaskToolSet (sub-agent delegation)

**System Prompt**: 
```
You are an expert software development coordinator. Your role is to:
1. Receive software development requests
2. Plan the development workflow
3. Delegate tasks to specialized agents
4. Monitor progress and ensure quality
5. Report results to the user

You specialize in mobile app development using Flutter and Firebase.
```

### 2. Planning Agent
**Role**: Menganalisis requirements dan membuat architectural decisions.

**Tools**:
- FileEditorTool (create documentation)
- TerminalTool (research, Flutter analysis)

**System Prompt**:
```
You are an expert software architect specializing in Flutter mobile development.
Create detailed technical specifications including:
- App architecture (Clean Architecture / BLoC pattern)
- Data models
- Firebase schema
- API endpoints
- UI/UX flow
- Feature breakdown for MVP
```

### 3. Code Agent
**Role**: Mengimplementasikan semua kode aplikasi.

**Tools**:
- TerminalTool (Flutter commands, git)
- FileEditorTool (create/edit all files)
- GrepTool (code search)

**System Prompt**:
```
You are an expert Flutter developer. Implement complete, production-ready code:
- Flutter/Dart code for all screens and features
- Firebase configuration and services
- State management (BLoC/Riverpod)
- Navigation and routing
- API integrations
- UI components following Material Design 3

Code must be clean, well-structured, and ready for production.
```

### 4. QA Agent
**Role**: Testing dan quality assurance.

**Tools**:
- TerminalTool (run tests, build verification)
- FileEditorTool (create test files)

**System Prompt**:
```
You are an expert in mobile app quality assurance. Your tasks:
1. Write unit tests for business logic
2. Write widget tests for UI components
3. Verify code quality and best practices
4. Check Firebase security rules
5. Validate app builds successfully
6. Ensure all features are implemented as specified
```

## Development Workflow

### Phase 1: Planning
1. User provides task description
2. Main agent receives and analyzes task
3. Planning agent creates SPEC.md with:
   - App requirements
   - Technical architecture
   - Firebase schema
   - Feature list
   - Development timeline

### Phase 2: Project Setup
1. Code agent creates Flutter project
2. Configures Firebase
3. Sets up project structure (Clean Architecture)
4. Creates shell project with dependencies
5. Verifies build

### Phase 3: Feature Implementation
For each feature:
1. Create data models
2. Implement Firebase services
3. Create BLoC/Cubit
4. Build UI screens
5. Add navigation
6. Write tests

### Phase 4: Quality Assurance
1. Run unit tests
2. Verify widget builds
3. Check code quality
4. Review Firebase rules
5. Final build verification

## Project Structure

```
social_app/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── core/
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   ├── data/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── services/
│   ├── domain/
│   │   ├── entities/
│   │   └── repositories/
│   └── presentation/
│       ├── blocs/
│       ├── pages/
│       └── widgets/
├── test/
├── firebase/
│   ├── firestore.rules
│   └── storage.rules
└── pubspec.yaml
```

## Features to Implement

### Authentication
- Email/password signup
- Google sign-in
- Phone verification
- Password reset

### User Profile
- Profile creation/edit
- Avatar upload
- Bio and info
- Settings

### Social Graph
- Follow/unfollow
- Followers/following lists
- User search

### Posts & Feed
- Create post (text/image/video)
- Feed timeline
- Like/unlike
- Comments
- Share/repost

### Stories
- Create story
- View stories
- Story reactions

### Messaging
- Direct messages
- Group chats
- Media sharing
- Online status

### Video/Audio Calls
- Initiate calls
- Video call UI
- Audio call UI
- Call notifications

### Live Streaming
- Start live stream
- Watch live
- Live reactions
- Stream comments

### Groups & Communities
- Create group
- Join/leave group
- Group posts
- Group settings

### Notifications
- Real-time notifications
- Push notifications
- Notification settings

### Monetization (Freemium)
- Premium features
- In-app purchases
- Subscription management
- Ad integration points

## Firebase Services

### Authentication
- Email/password
- Google OAuth
- Phone (optional)

### Firestore Collections
- users
- posts
- stories
- messages
- conversations
- groups
- notifications
- calls

### Cloud Functions
- Send notifications
- Process payments
- Content moderation
- Live stream management

### Storage
- Profile images
- Post media
- Story media
- Live stream recordings

## LLM Configuration

### Default Model
- Provider: OpenHands (configurable)
- Model: claude-sonnet-4-5-20250929

### Environment Variables
```bash
LLM_API_KEY=<your-api-key>
LLM_BASE_MODEL=openhands/claude-sonnet-4-5-20250929
```

## Output Location
- Agent code: `/workspace/project/output/`
- Generated app: `/workspace/project/output/social_app/`
- Documentation: `/workspace/project/output/SPEC.md`

## Success Criteria
1. ✅ Agent can understand and plan complex app development
2. ✅ Generates complete, runnable Flutter project
3. ✅ Implements all requested features
4. ✅ Code follows best practices
5. ✅ Project builds successfully
6. ✅ Tests pass

## Future Enhancements
- Add deployment automation (Firebase App Distribution)
- CI/CD integration
- App Store/Play Store submission
- Analytics integration
- Multi-language support (already specified)
