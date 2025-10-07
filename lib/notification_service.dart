import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  final String baseUrl = 'https://flutterapp-jj7n.onrender.com/api/notifications';

  Future<List<dynamic>> getNotifications() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> sendNotification(String from, String to, String message) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'from': from,
        'to': to,
        'message': message,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send notification');
    }
  }
}
