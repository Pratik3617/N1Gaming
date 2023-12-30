import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> redeemSlip(String transactionId) async {
    final apiUrl = 'http://127.0.0.1:8000/redeem'; 

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'transaction_id': transactionId}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        return {'error': 'Error redeem slip: ${response.statusCode}'};
      }
    } catch (error) {
      print('Error: $error');
      return {'error': 'Error while fetching redeem slip details: $error'};
    }
  }
