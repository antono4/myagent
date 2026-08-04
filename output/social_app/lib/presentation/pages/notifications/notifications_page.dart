import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          final isRead = index > 5;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                index % 4 == 0
                    ? Icons.favorite
                    : index % 4 == 1
                        ? Icons.chat_bubble
                        : index % 4 == 2
                            ? Icons.person_add
                            : Icons.video_call,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              _getNotificationText(index),
              style: TextStyle(
                fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${index + 1}h ago',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            trailing: isRead ? null : Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }

  String _getNotificationText(int index) {
    switch (index % 4) {
      case 0:
        return 'John Doe liked your post';
      case 1:
        return 'Jane Smith commented: "Great post!"';
      case 2:
        return 'Mike Johnson started following you';
      case 3:
        return 'Video call from Sarah';
      default:
        return 'New notification';
    }
  }
}
