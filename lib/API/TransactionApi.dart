import 'dart:convert';
import 'package:bet/providers/TransactionListProvider.dart';
import 'package:http/http.dart' as http;

Future<void> fetchTransactionList(String username, TransactionProvider transactionProvider) async {
  final apiUrl = 'http://3.108.237.235/showTransaction';
  final response = await http.get(
    Uri.parse('$apiUrl?username=$username'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    Map<String, List<List<String>>> transactionData = {};
    int cancelCount = 0;

    if (responseData.containsKey('transactionlist')) {
      List<dynamic> transactions = responseData['transactionlist'];

      transactions.forEach((transaction) {
        if (transaction.containsKey('transaction_id') && transaction.containsKey('tsns')) {
          String transactionId = transaction['transaction_id'];
          List<dynamic> tsns = transaction['tsns'];

          List<List<String>> tsnsData = [];

          tsns.forEach((tsn) {
            if (tsn.containsKey('tsn_id') &&
                tsn.containsKey('gamedate_time') &&
                tsn.containsKey('slipdatetime') &&
                tsn.containsKey('playedpoints') &&
                tsn.containsKey('cancel')) {
              tsnsData.add([
                tsn['tsn_id'],
                '2D coupon',
                tsn['gamedate_time'],
                tsn['slipdatetime'],
                tsn['playedpoints'].toString(),
                tsn['cancel'].toString(),
              ]);

              // Increment cancel count if the transaction is canceled
              if (tsn['cancel'].toString().toLowerCase() == 'true') {
                cancelCount++;
              }
            }
          });

          transactionData[transactionId] = tsnsData;
        }
      });

      // Update the provider's state with the new data and cancel count
      transactionProvider.updateTransactionData(transactionData, cancelCount);
    }
  } else {
    print('Error: ${response.statusCode}, ${response.reasonPhrase}');
  }
}
