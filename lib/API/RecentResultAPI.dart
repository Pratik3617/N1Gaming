import 'package:http/http.dart' as http;
import 'dart:convert';


Future<Map<String, dynamic>> recentResult() async {
  final apiUrl = 'http://3.108.237.235/recentResult';


  final response = await http.get(Uri.parse('$apiUrl'));
  
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }else {
    throw Exception('Failed to fetch data');
  }
}