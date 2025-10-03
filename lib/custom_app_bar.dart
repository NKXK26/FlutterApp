import 'package:flutter/material.dart';
import 'my_booking_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: PopupMenuButton<String>(
        icon: const Icon(Icons.menu), // small button on left
        onSelected: (value) {
          switch (value) {
            case 'my_booking':
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MyBookingPage()));
              break;
            case 'profile':
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
              break;
            case 'settings':
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(value: 'my_booking', child: Text('My Booking')),
          const PopupMenuItem<String>(value: 'profile', child: Text('Profile')),
          const PopupMenuItem<String>(value: 'settings', child: Text('Settings')),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
