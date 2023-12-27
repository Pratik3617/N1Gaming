import 'package:bet/providers/TransactionListProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Transaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionListProvider, child) {
        List<DataRow> rows = [];

        transactionListProvider.transactionData.forEach((transactionId, rowList) {
          for (int i = 0; i < rowList.length; i++) {
            List<DataCell> cells = [];

            if (i == 0) {
              cells.add(DataCell(Text(transactionId, style: TextStyle(color: Colors.white))));
            } else {
              cells.add(DataCell(Text('')));
            }

            for (int j = 0; j < rowList[i].length; j++) {
              cells.add(
                DataCell(
                  Text(rowList[i][j], style: TextStyle(color: Colors.white)),
                ),
              );
            }

            while (cells.length < 7) {
              cells.add(DataCell(Text('')));
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
            actions: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    "N.1 GAMING",
                    style: TextStyle(
                      fontFamily: 'YoungSerif',
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                      color: Color(0xFFF3FDE8),
                      letterSpacing: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          body: Scaffold(
            backgroundColor: const Color.fromARGB(255, 42, 41, 41),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 100, 30),
                            child: Text("Click on TSN for Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                            child: Text("Slips Cancelled: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                            child: Text("0", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columnSpacing: 70.0,
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text('Transaction ID', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('TSN', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('GAME', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Game Date Time', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Slip Date Time', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Points', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
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
