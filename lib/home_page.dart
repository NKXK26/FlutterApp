import 'package:flutter/material.dart';
import 'room_detail_page.dart';
import 'my_booking_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

// -------------------- Custom AppBar --------------------
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: PopupMenuButton<String>(
        icon: const Icon(Icons.menu),
        onSelected: (value) {
          switch (value) {
            case 'my_booking':
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const MyBookingPage()));
              break;
            case 'profile':
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()));
              break;
            case 'settings':
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()));
              break;
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'my_booking', child: Text('My Booking')),
          PopupMenuItem(value: 'profile', child: Text('Profile')),
          PopupMenuItem(value: 'settings', child: Text('Settings')),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// -------------------- Home Page --------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> rooms = const [
    {"name": "Deluxe Room", "price": 80, "image": "assets/deluxe.jpg"},
    {"name": "Suite Room", "price": 120, "image": "assets/suite.jpg"},
    {"name": "Standard Room", "price": 60, "image": "assets/standard.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Room Booking Demo"),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: Image.asset(
                room["image"],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint("❌ Failed to load image: ${room["image"]}");
                  return const Icon(Icons.broken_image, size: 60);
                },
              ),
              title: Text(room["name"]),
              subtitle: Text("\$${room["price"]}/night"),
              trailing: ElevatedButton(
                child: const Text("Book"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomDetailPage(room: room),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
