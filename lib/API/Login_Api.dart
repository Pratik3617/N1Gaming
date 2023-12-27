import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> userLogin(String username, String password) async {
  final apiUrl = 'http://127.0.0.1:8000/userlogin';

  final payload = {
    'username': username,
    'password': password,
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
    throw Exception('Failed to log in');
  }
}
