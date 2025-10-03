import 'package:flutter/material.dart';
import 'payment_page.dart';

class RoomDetailPage extends StatefulWidget {
  final Map<String, dynamic> room;

  const RoomDetailPage({super.key, required this.room});

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  DateTime? checkIn;
  DateTime? checkOut;

  int get totalNights {
    if (checkIn != null && checkOut != null) {
      return checkOut!.difference(checkIn!).inDays;
    }
    return 0;
  }

  double get totalPrice {
    return totalNights * (widget.room["price"] as num).toDouble();
  }

  Future<void> _pickDate({required bool isCheckIn}) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime.now().add(const Duration(days: 365));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkIn = picked;
          // reset checkout if earlier than check-in
          if (checkOut != null && checkOut!.isBefore(checkIn!)) {
            checkOut = null;
          }
        } else {
          checkOut = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final room = widget.room;

    return Scaffold(
      appBar: AppBar(title: Text(room["name"])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(room["image"], height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              room["name"],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("\$${room["price"]}/night"),
            const SizedBox(height: 16),
            const Text("Room Description:"),
            const Text(
              "Spacious room with WiFi, Air Conditioning, and comfortable beds.",
            ),
            const SizedBox(height: 20),

            // Date pickers
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickDate(isCheckIn: true),
                    child: Text(
                      checkIn == null
                          ? "Select Check-in"
                          : "Check-in: ${checkIn!.toLocal()}".split(' ')[0],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: checkIn == null
                        ? null
                        : () => _pickDate(isCheckIn: false),
                    child: Text(
                      checkOut == null
                          ? "Select Check-out"
                          : "Check-out: ${checkOut!.toLocal()}".split(' ')[0],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Price summary
            if (totalNights > 0)
              Text(
                "Total: $totalNights nights = \$${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 30),

            // Proceed to payment
            Center(
              child: ElevatedButton(
                onPressed: totalNights > 0
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              roomName: room["name"],
                              totalPrice: totalPrice,
                            ),
                          ),
                        );
                      }
                    : null,
                child: const Text("Proceed to Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
