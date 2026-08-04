import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  final String? userId;
  
  const ProfilePage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    final isOwnProfile = userId == null || userId == 'me';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isOwnProfile ? 'Profile' : 'User Profile'),
        actions: [
          if (isOwnProfile)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.go('/settings'),
            ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return _ProfileContent(user: state.user, isOwnProfile: isOwnProfile);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final dynamic user;
  final bool isOwnProfile;

  const _ProfileContent({required this.user, required this.isOwnProfile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Cover Photo
          Container(
            height: 150,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: user.photoURL != null
                ? Image.network(user.photoURL!, fit: BoxFit.cover)
                : null,
          ),
          Transform.translate(
            offset: const Offset(0, -50),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  backgroundImage: user.photoURL != null 
                      ? NetworkImage(user.photoURL!) 
                      : null,
                  child: user.photoURL == null
                      ? Text(
                          user.displayName[0].toUpperCase(),
                          style: const TextStyle(fontSize: 40),
                        )
                      : null,
                ),
                const SizedBox(height: 8),
                // Name
                Text(
                  user.displayName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '@${user.username}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                if (user.bio != null) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      user.bio!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _StatItem(label: 'Posts', value: '${user.postsCount}'),
                    const SizedBox(width: 32),
                    _StatItem(label: 'Followers', value: '${user.followersCount}'),
                    const SizedBox(width: 32),
                    _StatItem(label: 'Following', value: '${user.followingCount}'),
                  ],
                ),
                const SizedBox(height: 16),
                // Actions
                if (isOwnProfile)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/edit-profile'),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Follow'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () => context.go('/chat'),
                          child: const Icon(Icons.chat_bubble_outline),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Posts Grid
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.grid_on)),
                    Tab(icon: Icon(Icons.video_library_outlined)),
                    Tab(icon: Icon(Icons.bookmark_border)),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.all(2),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.grey[600],
                              ),
                            ),
                          );
                        },
                      ),
                      const Center(child: Text('Reels')),
                      const Center(child: Text('Saved')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }
}
