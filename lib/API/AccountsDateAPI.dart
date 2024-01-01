import 'package:bet/providers/AccountProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


Future<void> fetchAccountDateDetails(
      BuildContext context, String username,String date1,String date2) async {
    final apiUrl = 'http://3.108.237.235:8000/showAccount';

    final payload = {
      'username': username,
      'date1': date1,
      'date2': date2,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        Provider.of<AccountDetailsProvider>(context, listen: false)
            .setAccountDetails(decodedData['data']);
      } else {
        throw Exception('Failed to Fetch account Details');
      }
    } catch (e) {
      print('Error during fetchAccountDetails: $e');
      // Handle errors here
    }
  }