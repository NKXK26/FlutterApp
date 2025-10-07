import 'package:flutter/material.dart';
import 'success_page.dart';
import 'notification_service.dart';

class PaymentPage extends StatefulWidget {
  final String roomName;
  final double totalPrice;

  const PaymentPage({super.key, required this.roomName, required this.totalPrice});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedMethod = "Card";

  void _confirmPayment() async {
  final notificationService = NotificationService();

  try {
    // Send notification to merchant and customer
    await notificationService.sendNotification(
      'customer', // sender
      'merchant', // receiver
      'A new booking has been made for ${widget.roomName} via $_selectedMethod payment.',
    );

    // Navigate to success page after notification is sent
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessPage(
          roomName: widget.roomName,
          totalPrice: widget.totalPrice,
          paymentMethod: _selectedMethod,
        ),
      ),
    );
  } catch (e) {
    // handle API error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment confirmed, but failed to send notification.')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Booking: ${widget.roomName}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Total Price: \$${widget.totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            const Text("Choose Payment Method:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            RadioListTile(
              title: const Text("Credit / Debit Card"),
              value: "Card",
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() => _selectedMethod = value.toString());
              },
            ),
            RadioListTile(
              title: const Text("E-Wallet / PayPal"),
              value: "Wallet",
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() => _selectedMethod = value.toString());
              },
            ),
            RadioListTile(
              title: const Text("Cash on Arrival"),
              value: "Cash",
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() => _selectedMethod = value.toString());
              },
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: _confirmPayment,
                child: const Text("Confirm & Pay"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
