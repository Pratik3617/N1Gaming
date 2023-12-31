import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> CancelTsn(String tsnId) async {
  final apiUrl = 'http://3.108.237.235/cancelTsn/$tsnId';

  try {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
    } else {
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
    }
  } catch (error) {
    print('Error: $error');
  }
}