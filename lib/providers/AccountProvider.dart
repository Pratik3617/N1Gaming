import 'package:flutter/material.dart';

class AccountDetailsProvider extends ChangeNotifier {
  List<String> accountDetails = [];

  void setAccountDetails(List<dynamic> data) {
    // Convert the dynamic data to strings
    accountDetails = List.generate(
      data.length + 1,
      (index) => index == 0 ? "" : data[index - 1].toString(),
    );
    notifyListeners();
  }
}
