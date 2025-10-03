import 'package:flutter/material.dart';
import 'room_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> rooms = const [
    {
      "name": "Deluxe Room",
      "price": 80,
      "image": "deluxe.jpg",
    },
    {
      "name": "Suite Room",
      "price": 120,
      "image": "suite.jpg",
    },
    {
      "name": "Standard Room",
      "price": 60,
      "image": "standard.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Room Booking Demo")),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: Image.asset(room["image"], width: 60, fit: BoxFit.cover),
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
