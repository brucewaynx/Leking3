import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            'LeBron James',
            'started following you',
            '2 min ago',
            'assets/images/pfp.jpg',
          ),
          _buildNotificationItem(
            'Lakers',
            'liked your post',
            '1 hour ago',
            'assets/images/3.jpg',
          ),
          _buildNotificationItem(
            'NBA',
            'commented on your post',
            '3 hours ago',
            'assets/images/4.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String name, String action, String time, String image) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' $action',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      subtitle: Text(
        time,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: action.contains('following')
          ? ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(80, 32),
              ),
              child: const Text('Follow'),
            )
          : null,
    );
  }
}