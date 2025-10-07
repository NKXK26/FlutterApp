import 'package:flutter/material.dart';
import 'room_detail_page.dart';
import 'my_booking_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'custom_app_bar.dart'; // ✅ Import your separate custom bar

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> rooms = const [
    {"name": "Deluxe Room", "price": 80, "image": "assets/deluxe.jpg"},
    {"name": "Suite Room", "price": 120, "image": "assets/suite.jpg"},
    {"name": "Standard Room", "price": 60, "image": "assets/standard.jpg"},
    {"name": "Budget Room", "price": 40, "image": "assets/standard.jpg"},
  ];

  double? minPrice;
  double? maxPrice;

  @override
  Widget build(BuildContext context) {
    final filteredRooms = rooms.where((room) {
      final price = room["price"] as int;
      if (minPrice != null && price < minPrice!) return false;
      if (maxPrice != null && price > maxPrice!) return false;
      return true;
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: "Room Booking Demo"), // ✅ clean
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Min Price",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        minPrice = value.isEmpty ? null : double.tryParse(value);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Max Price",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        maxPrice = value.isEmpty ? null : double.tryParse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredRooms.length,
              itemBuilder: (context, index) {
                final room = filteredRooms[index];
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
          ),
        ],
      ),
    );
  }
}
