import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> ReprintSlip(String tsnId) async {
  final apiUrl = 'http://3.108.237.235:8000/reprintSlip/$tsnId';
  try {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['data'];
    } else {
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      throw Exception('Failed to reprint slip: ${response.statusCode}, ${response.reasonPhrase}');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to reprint slip: $error');
  }
}
