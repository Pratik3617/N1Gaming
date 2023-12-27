import 'package:flutter/foundation.dart';

class TransactionProvider extends ChangeNotifier {
  Map<String, List<List<String>>> _transactionData = {};

  Map<String, List<List<String>>> get transactionData => _transactionData;

  void updateTransactionData(Map<String, List<List<String>>> newData) {
    _transactionData = newData;
    notifyListeners();
  }
}
