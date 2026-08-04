# Social Media App - Technical Specification

## Version: 1.0.0

---

## 1. Project Overview

### 1.1 Project Name
**SocialHub** - All-in-One Social Media Platform

### 1.2 Description
A comprehensive social media application combining features from major platforms (Facebook, Instagram, Twitter, WhatsApp, TikTok) into a unified mobile experience.

### 1.3 Target Platforms
- **Android**: API 21+ (Android 5.0+)
- **iOS**: iOS 12.0+

### 1.4 Target Audience
- General users (13+ years)
- Gen Z users (13-27 years)
- Professional users
- Niche communities (gaming, crypto, hobbies)
- Regional markets (Indonesia, Southeast Asia)

### 1.5 Monetization Strategy (Mixed)
- **Freemium**: Basic features free, premium features paid
- **Ads-based**: Ad integration at strategic points
- **Subscription**: Monthly/yearly premium plans
- **Marketplace**: Transaction fees for in-app purchases
- **Data-driven**: Analytics services for businesses

---

## 2. Technical Architecture

### 2.1 Technology Stack

| Component | Technology |
|-----------|------------|
| **Framework** | Flutter 3.x |
| **Language** | Dart 3.x |
| **State Management** | flutter_bloc (BLoC pattern) |
| **Navigation** | go_router |
| **Backend** | Firebase |
| **Authentication** | Firebase Auth |
| **Database** | Cloud Firestore |
| **Storage** | Firebase Storage |
| **Functions** | Cloud Functions for Firebase |
| **Notifications** | Firebase Cloud Messaging |
| **Analytics** | Firebase Analytics |
| **Architecture** | Clean Architecture |
| **Localization** | flutter_localizations + intl |

### 2.2 Clean Architecture Structure

```
lib/
├── main.dart                      # Entry point
├── app.dart                        # App configuration
├── injection_container.dart       # Dependency injection
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart     # App-wide constants
│   │   ├── firebase_constants.dart
│   │   └── assets_constants.dart
│   ├── theme/
│   │   ├── app_theme.dart         # Material 3 theme
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   └── extensions.dart
│   ├── errors/
│   │   ├── failures.dart
│   │   └── exceptions.dart
│   └── widgets/
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       ├── loading_indicator.dart
│       └── error_widget.dart
│
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── post_model.dart
│   │   ├── story_model.dart
│   │   ├── message_model.dart
│   │   ├── conversation_model.dart
│   │   ├── group_model.dart
│   │   ├── notification_model.dart
│   │   ├── call_model.dart
│   │   └── live_stream_model.dart
│   ├── repositories/
│   │   ├── auth_repository_impl.dart
│   │   ├── user_repository_impl.dart
│   │   ├── post_repository_impl.dart
│   │   └── ... (other implementations)
│   └── services/
│       ├── firebase_auth_service.dart
│       ├── firebase_firestore_service.dart
│       ├── firebase_storage_service.dart
│       ├── firebase_messaging_service.dart
│       └── notification_service.dart
│
├── domain/
│   ├── entities/
│   │   ├── user.dart
│   │   ├── post.dart
│   │   ├── story.dart
│   │   ├── message.dart
│   │   ├── conversation.dart
│   │   ├── group.dart
│   │   ├── notification.dart
│   │   ├── call.dart
│   │   └── live_stream.dart
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── user_repository.dart
│   │   ├── post_repository.dart
│   │   └── ... (interfaces)
│   └── usecases/
│       ├── auth/
│       ├── user/
│       ├── post/
│       └── ... (business logic)
│
└── presentation/
    ├── blocs/
    │   ├── auth/
    │   │   ├── auth_bloc.dart
    │   │   ├── auth_event.dart
    │   │   └── auth_state.dart
    │   ├── user/
    │   ├── post/
    │   ├── story/
    │   ├── chat/
    │   ├── call/
    │   ├── live/
    │   ├── group/
    │   ├── notification/
    │   └── settings/
    ├── pages/
    │   ├── splash_page.dart
    │   ├── onboarding_page.dart
    │   ├── auth/
    │   │   ├── login_page.dart
    │   │   ├── register_page.dart
    │   │   └── forgot_password_page.dart
    │   ├── home/
    │   │   └── home_page.dart
    │   ├── feed/
    │   │   ├── feed_page.dart
    │   │   └── create_post_page.dart
    │   ├── profile/
    │   │   ├── profile_page.dart
    │   │   ├── edit_profile_page.dart
    │   │   └── settings_page.dart
    │   ├── search/
    │   │   └── search_page.dart
    │   ├── story/
    │   │   └── story_viewer_page.dart
    │   ├── chat/
    │   │   ├── chat_list_page.dart
    │   │   └── chat_page.dart
    │   ├── call/
    │   │   ├── call_page.dart
    │   │   └── incoming_call_page.dart
    │   ├── live/
    │   │   ├── live_list_page.dart
    │   │   ├── live_viewer_page.dart
    │   │   └── go_live_page.dart
    │   ├── group/
    │   │   ├── groups_page.dart
    │   │   ├── group_detail_page.dart
    │   │   └── create_group_page.dart
    │   └── notification/
    │       └── notifications_page.dart
    └── widgets/
        ├── post_card.dart
        ├── story_circle.dart
        ├── chat_bubble.dart
        ├── group_card.dart
        └── ... (reusable UI components)
```

---

## 3. Firebase Configuration

### 3.1 Authentication

**Methods:**
- Email/Password
- Google Sign-In
- Phone Number (optional)

**Collections:**
```
users/
  {userId}/
    - uid: string
    - email: string
    - displayName: string
    - photoURL: string
    - bio: string
    - phoneNumber: string
    - isPremium: boolean
    - premiumExpiry: timestamp
    - createdAt: timestamp
    - updatedAt: timestamp
```

### 3.2 Firestore Collections

#### Users
```
/users/{userId}
  - uid, email, displayName, photoURL
  - bio, username, website
  - followersCount, followingCount, postsCount
  - isPrivate, isVerified, isPremium
  - language (en/id)
  - notificationSettings: map
  - privacySettings: map
  - createdAt, updatedAt
```

#### Follows
```
/follows/{followId}
  - followerId, followingId
  - createdAt
```

#### Posts
```
/posts/{postId}
  - authorId, content, mediaUrls[]
  - mediaType (text/image/video)
  - likesCount, commentsCount, sharesCount
  - isEdited, isPinned
  - location: map (lat, lng, name)
  - createdAt, updatedAt
```

#### Likes
```
/likes/{likeId}
  - userId, postId
  - createdAt
```

#### Comments
```
/posts/{postId}/comments/{commentId}
  - authorId, content
  - likesCount
  - parentId (for replies)
  - createdAt
```

#### Stories
```
/stories/{storyId}
  - authorId, mediaUrl, mediaType
  - duration (seconds)
  - viewers: array
  - viewersCount
  - createdAt, expiresAt (createdAt + 24h)
```

#### Conversations
```
/conversations/{conversationId}
  - type (direct/group)
  - participants: array
  - groupName, groupPhoto (for groups)
  - adminIds: array (for groups)
  - lastMessage: map
  - lastMessageAt
  - createdAt
```

#### Messages
```
/conversations/{conversationId}/messages/{messageId}
  - senderId, content
  - type (text/image/video/audio/file)
  - mediaUrl
  - isRead, readBy: array
  - replyToId
  - createdAt
```

#### Groups
```
/groups/{groupId}
  - name, description, photoURL
  - adminIds: array
  - memberIds: array
  - isPrivate, isPublic
  - postsCount, membersCount
  - rules: array
  - createdAt, updatedAt
```

#### Notifications
```
/notifications/{userId}/items/{notificationId}
  - type (like/comment/follow/message/call/live/group)
  - fromUserId
  - referenceId (postId, commentId, etc.)
  - title, body
  - isRead
  - createdAt
```

#### Live Streams
```
/liveStreams/{streamId}
  - hostId, title, description
  - thumbnailUrl
  - viewersCount, likesCount
  - isLive, endedAt
  - createdAt
```

### 3.3 Storage Buckets

```
/avatars/{userId}           # Profile pictures
/posts/{postId}/{filename}    # Post media
/stories/{storyId}/{filename} # Story media
/chat/{conversationId}/{filename} # Chat attachments
/groups/{groupId}/{filename}  # Group photos
/live/{streamId}/{filename}   # Live stream data
```

### 3.4 Cloud Functions

#### Notifications
- `sendPushNotification` - Trigger on new notification
- `sendLikeNotification` - When post is liked
- `sendCommentNotification` - When comment is added
- `sendFollowNotification` - When user follows
- `sendMessageNotification` - New message

#### Content
- `processMediaUpload` - Image/video compression
- `generatePostThumbnail` - Create thumbnails
- `moderateContent` - Basic content moderation

#### Live Streaming
- `onLiveStreamStart` - Update live streams list
- `onLiveStreamEnd` - Archive and stats

#### Monetization
- `processSubscription` - Handle premium upgrade
- `validatePremium` - Check subscription status

---

## 4. Feature Specifications

### 4.1 Authentication

#### Login Screen
- Email input field with validation
- Password input field with show/hide toggle
- "Forgot Password" link
- Google Sign-In button
- "Don't have an account? Sign up" link

#### Registration Screen
- Full name input
- Username input (unique, lowercase, alphanumeric)
- Email input
- Password input (min 8 chars, 1 uppercase, 1 number)
- Confirm password
- Terms of service checkbox
- "Already have an account? Sign in" link

#### Forgot Password Screen
- Email input
- Send reset link button
- Success/error feedback

### 4.2 User Profile

#### Profile Screen
- Cover photo (optional)
- Avatar photo with edit button
- Display name and username
- Bio text
- Stats row: Posts | Followers | Following
- Edit Profile button (own profile) / Follow/Message buttons (others)
- Tab bar: Posts | Reels | Tagged
- Grid/list of user's posts

#### Edit Profile Screen
- Avatar picker (camera/gallery)
- Cover photo picker
- Full name input
- Bio textarea (150 chars max)
- Username input
- Website input
- Location input

### 4.3 Social Graph

#### Follow System
- Follow button (primary action)
- Following/Followers lists
- Mutual followers indicator
- Follow requests (for private accounts)

#### Search
- Search bar with recent searches
- Search by username or name
- Filter: People, Posts, Groups, Hashtags
- Trending topics

### 4.4 Posts & Feed

#### Feed Screen
- Stories row at top
- Post list with infinite scroll
- Pull to refresh
- Floating action button for new post

#### Post Card
- Author avatar, name, timestamp
- Post content (text + media)
- Media gallery (swipeable)
- Like, Comment, Share, Save buttons
- Like count, Comment count

#### Create Post Screen
- Text input (2000 chars max)
- Media picker (camera/gallery, max 10)
- Location picker
- Audience selector (public/friends/private)
- Post button

#### Post Detail Screen
- Full post view
- Comments list
- Add comment input
- Likes list

### 4.5 Stories

#### Stories Row
- My story (+ button)
- Circular avatars of users with unseen stories
- Ring indicator for unseen

#### Story Viewer
- Full-screen vertical stories
- Progress bar at top
- Tap to advance, hold to pause
- Swipe to next/previous story
- Reply to story
- View viewers list

#### Create Story
- Camera viewfinder
- Photo/video capture
- Text overlay
- Filters
- Duration selector (3-24 hours)

### 4.6 Messaging

#### Chat List
- Conversations list
- Unread indicator
- Last message preview
- Online status
- Unread count

#### Chat Screen
- Messages list (grouped by date)
- Message bubbles (sent/received)
- Media messages
- Reply to message
- Scroll to bottom FAB

#### Conversation Actions
- View profile
- Mute notifications
- Search in chat
- Clear chat
- Delete chat

### 4.7 Video/Audio Calls

#### Initiate Call
- From profile or chat
- Video/Audio toggle
- Call button

#### Call Screen
- Video preview (PiP for video)
- Call duration timer
- Mute toggle
- Speaker toggle
- Camera toggle
- End call button

#### Incoming Call Screen
- Caller avatar and name
- Video/Audio indicator
- Accept/Decline buttons
- Call timeout (30s)

### 4.8 Live Streaming

#### Go Live
- Title input
- Description
- Start live button

#### Live Viewer
- Full-screen video
- Viewer count
- Like button
- Comment input
- Share button
- Live indicator
- Host info bar

#### Live List
- Live streams grid
- Live badge
- Viewer count
- Host info

### 4.9 Groups

#### Groups List
- My groups
- Discover groups
- Create group button

#### Group Detail
- Cover photo
- Group name and description
- Member count
- Join/Leave button
- Admin controls (for admins)
- Group feed
- Members list
- Settings

#### Create Group
- Name input
- Description
- Privacy toggle (public/private)
- Cover photo
- Create button

### 4.10 Notifications

#### Notifications List
- Notification cards
- Profile/action icons
- Notification text
- Timestamp
- Mark all as read

#### Notification Types
- Like (on your post)
- Comment (on your post)
- Follow (new follower)
- Mention (tagged you)
- Message (new DM)
- Live (friend went live)
- Group (group activity)
- System (app updates)

### 4.11 Monetization

#### Premium Features
- Ad-free experience
- Highlight stories (30 days)
- See who viewed your story
- Post translations
- Priority support
- Exclusive filters
- Analytics (profile insights)

#### Subscription Flow
- Premium plans screen
- Monthly/Yearly toggle
- Feature comparison
- Purchase button
- Restore purchases

#### Ad Placements
- Feed ads (every 5 posts)
- Story ads
- Search results
- Profile page

---

## 5. Localization

### 5.1 Supported Languages
- English (en) - Default
- Indonesian (id)

### 5.2 Translation Keys Structure
```dart
{
  "common": {
    "save": "Save",
    "cancel": "Cancel",
    "delete": "Delete",
    "edit": "Edit",
    "loading": "Loading...",
    "error": "Error",
    "success": "Success"
  },
  "auth": {
    "login": "Log In",
    "register": "Sign Up",
    "email": "Email",
    "password": "Password",
    "forgotPassword": "Forgot Password?"
  },
  // ... more sections
}
```

---

## 6. UI/UX Design

### 6.1 Color Palette

| Name | Light Mode | Dark Mode | Usage |
|------|------------|-----------|-------|
| Primary | #6366F1 | #818CF8 | Main actions |
| Secondary | #EC4899 | #F472B6 | Highlights |
| Background | #FFFFFF | #0F172A | Screen bg |
| Surface | #F8FAFC | #1E293B | Cards |
| Text Primary | #0F172A | #F8FAFC | Main text |
| Text Secondary | #64748B | #94A3B8 | Subtle text |
| Error | #EF4444 | #F87171 | Errors |
| Success | #10B981 | #34D399 | Success |
| Warning | #F59E0B | #FBBF24 | Warnings |

### 6.2 Typography

| Style | Font | Size | Weight |
|-------|------|------|--------|
| Display | System | 32sp | Bold |
| Headline | System | 24sp | SemiBold |
| Title | System | 20sp | SemiBold |
| Body Large | System | 16sp | Regular |
| Body | System | 14sp | Regular |
| Caption | System | 12sp | Regular |
| Button | System | 14sp | SemiBold |

### 6.3 Spacing System (8pt Grid)

- xs: 4px
- sm: 8px
- md: 16px
- lg: 24px
- xl: 32px
- xxl: 48px

### 6.4 Component Guidelines

#### Buttons
- Primary: Filled with primary color
- Secondary: Outlined
- Text: No background
- Height: 48px
- Border radius: 12px

#### Input Fields
- Height: 56px
- Border radius: 12px
- Filled variant
- Label animation

#### Cards
- Border radius: 16px
- Elevation: 2dp
- Padding: 16px

#### Bottom Navigation
- 5 items max
- Icons + labels
- Active indicator

---

## 7. Security Rules

### 7.1 Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read any profile
    match /users/{userId} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
    
    // Posts visibility based on author
    match /posts/{postId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.authorId;
    }
    
    // Similar rules for other collections...
  }
}
```

### 7.2 Storage Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /avatars/{userId}/{fileName} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
    // Similar rules for other paths...
  }
}
```

---

## 8. Testing Strategy

### 8.1 Unit Tests
- Models serialization
- Use cases business logic
- BLoC state transitions
- Repository methods

### 8.2 Widget Tests
- Screen rendering
- User interactions
- Navigation flows
- Form validations

### 8.3 Integration Tests
- Authentication flow
- Post creation flow
- Messaging flow
- Full user journeys

---

## 9. Deployment

### 9.1 Android
- Minimum SDK: 21
- Target SDK: 34
- ProGuard enabled for release

### 9.2 iOS
- Minimum iOS: 12.0
- Xcode: 15+
- Bitcode disabled

### 9.3 Firebase Projects
- Development
- Staging
- Production

---

## 10. Development Timeline

### Phase 1: Foundation (Week 1-2)
- Project setup
- Architecture setup
- Authentication
- Basic navigation

### Phase 2: Core Features (Week 3-4)
- User profiles
- Social graph
- Posts and feed

### Phase 3: Engagement (Week 5-6)
- Stories
- Comments and reactions
- Notifications

### Phase 4: Communication (Week 7-8)
- Messaging
- Video/Audio calls
- Live streaming

### Phase 5: Community (Week 9-10)
- Groups
- Search and discovery
- Settings

### Phase 6: Monetization (Week 11-12)
- Premium features
- Ad integration
- Analytics

### Phase 7: Polish (Week 13-14)
- Performance optimization
- Testing
- Bug fixes
- Documentation

---

*Document Version: 1.0.0*
*Last Updated: 2024*
