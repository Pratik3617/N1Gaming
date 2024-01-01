import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getUserStatus(String username) async {
  final apiUrl = 'http://3.108.237.235/userStatus/$username';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      return {'error': 'Failed to fetch user status'};
    }
  } catch (error) {
    print('Error: $error');
    return {'error': 'Failed to fetch user status'};
  }
}