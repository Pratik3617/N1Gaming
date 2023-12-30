import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchAccountDetails(String username, DateTime date1, DateTime date2) async {
  final apiUrl = 'http://127.0.0.1:8000/showAccount';

  final payload = {
    'username': username,
    'date1': date1,
    'date2': date2,
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to Fetch account Details');
  }
}