// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bet/providers/TransactionListProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Transaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    int cancelCount = Provider.of<TransactionProvider>(context).cancelCount;

    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        List<DataRow> rows = [];

        transactionProvider.transactionData.forEach((transactionId, rowList) {
          for (int i = 0; i < rowList.length; i++) {
            List<DataCell> cells = [];

            if (i == 0) {
              cells.add(DataCell(Text(transactionId, style: const TextStyle(color: Colors.white))));
            } else {
              cells.add(DataCell(const Text('')));
            }

            for (int j = 0; j < rowList[i].length; j++) {
              cells.add(
                DataCell(
                  Text(rowList[i][j], style: const TextStyle(color: Colors.white)),
                ),
              );
            }

            while (cells.length < 7) {
              cells.add(const DataCell(Text('')));
            }

            rows.add(DataRow(
              cells: cells,
            ));
          }
        });

        return Scaffold(
          appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.blueGrey,
          title: Text(
            "N.1 GAMING",
            style: TextStyle(
              fontFamily: 'YoungSerif',
              fontWeight: FontWeight.bold,
              fontSize: 60.0, // Adjust the font size as needed
              color: Color(0xFFF3FDE8),
              letterSpacing: 2.0,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true, // Center the title
        ),

          body: Scaffold(
            backgroundColor: const Color.fromARGB(255, 42, 41, 41),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 100, 30),
                            child: const Text("Click on TSN for Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                            child: const Text("Slips Cancelled: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                            child: Text("$cancelCount", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columnSpacing: 70.0,
                          columns: const <DataColumn>[
                            const DataColumn(
                              label: Text('Transaction ID', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            const DataColumn(
                              label: Text('TSN', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            const DataColumn(
                              label: Text('GAME', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            const DataColumn(
                              label: Text('Game Date Time', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            const DataColumn(
                              label: Text('Slip Date Time', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            const DataColumn(
                              label: Text('Points', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            const DataColumn(
                              label: Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ],
                          rows: rows,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
