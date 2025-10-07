import 'package:flutter/material.dart';
import '../my_booking_page.dart';
import '../profile_page.dart';
import '../settings_page.dart';
import '../notification_page.dart'; // make sure this file exists

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
                MaterialPageRoute(builder: (_) => const MyBookingPage()),
              );
              break;

            case 'notifications': // 👈 new case added
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
              break;

            case 'profile':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
              break;

            case 'settings':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
              break;
          }
        },

        // 👇 Updated menu list
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'my_booking', child: Text('My Booking')),
          PopupMenuItem(value: 'notifications', child: Text('Notifications')), // 👈 Added here
          PopupMenuItem(value: 'profile', child: Text('Profile')),
          PopupMenuItem(value: 'settings', child: Text('Settings')),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
