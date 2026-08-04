import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/auth/register_page.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/feed/create_post_page.dart';
import '../../presentation/pages/profile/profile_page.dart';
import '../../presentation/pages/profile/edit_profile_page.dart';
import '../../presentation/pages/chat/chat_list_page.dart';
import '../../presentation/pages/chat/chat_page.dart';
import '../../presentation/pages/notifications/notifications_page.dart';
import '../../presentation/pages/groups/groups_page.dart';
import '../../presentation/pages/groups/group_detail_page.dart';
import '../../presentation/pages/live/live_page.dart';
import '../../presentation/pages/settings/settings_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash
      GoRoute(path: '/', builder: (_, __) => const SplashPage()),
      
      // Auth
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      
      // Home (Main Navigation)
      ShellRoute(
        builder: (_, __, child) => HomePage(child: child),
        routes: [
          GoRoute(path: '/feed', builder: (_, __) => const FeedContent()),
          GoRoute(path: '/search', builder: (_, __) => const SearchContent()),
          GoRoute(path: '/chat', builder: (_, __) => const ChatListPage()),
          GoRoute(path: '/chat/:id', builder: (_, state) => ChatPage(chatId: state.pathParameters['id']!)),
          GoRoute(path: '/notifications', builder: (_, __) => const NotificationsPage()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
          GoRoute(path: '/profile/:id', builder: (_, state) => ProfilePage(userId: state.pathParameters['id'])),
          GoRoute(path: '/groups', builder: (_, __) => const GroupsPage()),
          GoRoute(path: '/groups/:id', builder: (_, state) => GroupDetailPage(groupId: state.pathParameters['id']!)),
          GoRoute(path: '/live', builder: (_, __) => const LivePage()),
          GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
        ],
      ),
      
      // Create Post
      GoRoute(path: '/create-post', builder: (_, __) => const CreatePostPage()),
      
      // Edit Profile
      GoRoute(path: '/edit-profile', builder: (_, __) => const EditProfilePage()),
    ],
  );
}
