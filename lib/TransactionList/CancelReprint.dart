import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CancelReprint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, List<List<String>>> transactionData = {
      'T00030392031': [
        ['A0253TUW120341', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120342', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120343', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120344', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
      ],
      'T00030392032': [
        ['A0253TUW120345', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120346', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120347', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120348', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
      ],
      'T00030392033': [
        ['A0253TUW120349', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120350', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120351', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
        ['A0253TUW120352', '2D coupon', '29/11/2023 04:30PM', '29/11/2023 04:30PM', '10', 'N'],
      ],
    };


    void _showModal(BuildContext context, String transactionId, String tsn) {
      // Show modal with information for the clicked TSN
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Details for Transaction ID: $transactionId'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TSN: $tsn'),
                // Add more information as needed
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }

    List<DataRow> rows = [];

    transactionData.forEach((transactionId, rowList) {
      for (int i = 0; i < rowList.length; i++) {
        List<DataCell> cells = [];

        // Add the transaction ID cell only in the first row of the group
        if (i == 0) {
          cells.add(DataCell(Text(transactionId,style: TextStyle(color: Colors.white))));
        } else {
          // Add an empty cell for the transaction ID in subsequent rows
          cells.add(DataCell(Text('')));
        }

        // Add the other cells for the row
        for (int j = 0; j < rowList[i].length; j++) {
          cells.add(
            DataCell(
              // Wrap TSN cells only with GestureDetector and MouseRegion
              j == 0
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          // Show modal for the clicked TSN
                          _showModal(context, transactionId, rowList[i][j]);
                        },
                        child: Text(rowList[i][j],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,),),
                      ),
                    )
                  : Text(rowList[i][j],style: TextStyle(color: Colors.white)),
            ),
          );
        }

        // Ensure that each row has the correct number of cells
        while (cells.length < 7) {
          cells.add(DataCell(Text('')));
        }

        // Set the background color based on the row index
        // Color backgroundColor = i % 2 == 0 ? Color.fromARGB(255, 226, 224, 224)! : Colors.white;

        // Add the DataRow to the list with the specified background color
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
              // color: Colors.white,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 100, 30),
                      child: Text("Click on TSN for Details", style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                      child: Text("Slips Cancelled: ", style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                      child: Text("0", style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                  columnSpacing: 70.0,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('Transaction ID', style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('TSN', style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('GAME', style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Game Date Time', style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Slip Date Time', style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Points', style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Cancel', style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: rows,
                ),
                )
              ],
            ),
            )
          ),
      ),
      )
    );
  }
}
