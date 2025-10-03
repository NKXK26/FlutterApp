import 'package:flutter/material.dart';

class MyBookingPage extends StatelessWidget {
  const MyBookingPage({super.key});

  final List<Map<String, dynamic>> bookings = const [
    {"name": "Deluxe Room", "date": "2025-10-05"},
    {"name": "Suite Room", "date": "2025-10-10"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const Icon(Icons.hotel),
              title: Text(booking["name"]),
              subtitle: Text("Date: ${booking["date"]}"),
            ),
          );
        },
      ),
    );
  }
}