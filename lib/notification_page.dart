import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, String>> notifications = const [
    {
      "title": "Limited Offer!",
      "message": "Get 20% off on Deluxe Rooms this weekend only!"
    },
    {
      "title": "Recommended for You",
      "message": "You might like our new Suite Room with sea view 🌊"
    },
    {
      "title": "Booking Reminder",
      "message": "Don’t forget your upcoming stay on Oct 15, 2025."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.blue),
              title: Text(
                notif["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notif["message"]!),
            ),
          );
        },
      ),
    );
  }
}
