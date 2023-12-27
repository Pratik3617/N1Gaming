import 'package:http/http.dart' as http;
import 'dart:convert';


Future<Map<String, dynamic>> fetchDataForDate(DateTime date) async {
  final apiUrl = 'http://127.0.0.1:8000/showResultApp';

  final formattedDate = '${date.year}-${date.month}-${date.day}';

  final response = await http.get(Uri.parse('$apiUrl?date=$formattedDate'));

  if (response.statusCode == 200 || response.statusCode == 404) {
    return json.decode(response.body);
  }else if (response.statusCode == 404) {
    return {'result': []};
  }else {
    throw Exception('Failed to fetch data for the date');
  }
}