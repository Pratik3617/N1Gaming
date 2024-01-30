// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bet/API/CancelAPI.dart';
import 'package:bet/API/ReprintSlipAPI.dart';
import 'package:bet/API/TransactionApi.dart';
import 'package:bet/providers/TransactionListProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/rendering.dart';

class CancelReprint extends StatefulWidget {
  @override
  CancelReprintWidget createState() => CancelReprintWidget();
}


class CancelReprintWidget extends State<CancelReprint> {
  late SharedPreferences loginData;
  String? userName;

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState((){
        userName = loginData.getString('username');
    });
  }
  @override
  void initState() {
    super.initState();
    initial();
  }

  late Map<String, dynamic> reprintData;
  late List<String> gameData;


  void ReprintTsnSlip(String tsnId) async {
    try {
      reprintData = await ReprintSlip(tsnId);
      gameData = (reprintData['Gameplay'] as List<dynamic>).map((dynamic item) => item.toString()).toList();
    } catch (error) {
      print('Error: $error');
    }
  }

  
  @override
  Widget build(BuildContext context) {

    int cancelCount = Provider.of<TransactionProvider>(context).cancelCount;
    
    void _showModal(BuildContext context, String tsnId,int j) {
      if (j == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                width: 500,
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TSN: $tsnId',style: const TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w400
                    ),),
                    const Text('Are you sure you want to cancel this?',style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w400
                    ),),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () async{
                          await CancelTsn(tsnId);
                          Navigator.of(context).pop();
                          TransactionProvider transactionProvider = Provider.of<TransactionProvider>(context, listen: false);

                                  await fetchTransactionList(userName??"", transactionProvider);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CancelReprint()));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white),
                          side: MaterialStateProperty.all<
                              BorderSide>(
                            const BorderSide(
                                color: Colors.yellow,
                                width: 2.0),
                          ),
                          textStyle: MaterialStateProperty.all<
                              TextStyle>(
                            TextStyle(
                                fontFamily: "SansSerif",
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        child: const Text("Yes",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontFamily: "SansSerif")),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white),
                          side: MaterialStateProperty.all<
                              BorderSide>(
                            const BorderSide(
                                color: Colors.yellow,
                                width: 2.0),
                          ),
                          textStyle: MaterialStateProperty.all<
                              TextStyle>(
                            const TextStyle(
                                fontFamily: "SansSerif",
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        child: const Text("No",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontFamily: "SansSerif")),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        );
      } else if (j == 2) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Details for TSN ID: $tsnId'),
              content: Container(
                width: 500,
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TSN: $tsnId',style: const TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w400
                    ),),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () async{
                          ReprintTsnSlip(tsnId);
                          await _generatePdf(reprintData['transaction_id'], reprintData['slipdatetime'], reprintData['gamedate_time'],gameData,reprintData['playedpoints']);
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white),
                          side: MaterialStateProperty.all<
                              BorderSide>(
                            const BorderSide(
                                color: Colors.yellow,
                                width: 2.0),
                          ),
                          textStyle: MaterialStateProperty.all<
                              TextStyle>(
                            const TextStyle(
                                fontFamily: "SansSerif",
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        child: const Text("Reprint",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontFamily: "SansSerif")),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white),
                          side: MaterialStateProperty.all<
                              BorderSide>(
                            const BorderSide(
                                color: Colors.yellow,
                                width: 2.0),
                          ),
                          textStyle: MaterialStateProperty.all<
                              TextStyle>(
                            const TextStyle(
                                fontFamily: "SansSerif",
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        child: const Text("Close",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontFamily: "SansSerif")),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        );
      } 
    }

    List<DataRow> rows = [];

    Provider.of<TransactionProvider>(context,listen:false).transactionData.forEach((transactionId, rowList) {
      for (int i = 0; i < rowList.length; i++) {
        List<DataCell> cells = [];

        if (i == 0) {
          cells.add(DataCell(Text(transactionId, style: const TextStyle(color: Colors.white))));
        } else {
          cells.add(const DataCell(Text('')));
        }

        for (int j = 0; j < rowList[i].length; j++) {
          cells.add(
            DataCell(
              MouseRegion(
                cursor: (j == 0 || j == 2) ? SystemMouseCursors.click : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: () {
                    if(j==2){
                      ReprintTsnSlip(rowList[i][0]);
                    }
                    _showModal(context, rowList[i][0],j);
                  },
                  child: Text(
                    rowList[i][j],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      decoration: (j == 0 || j == 2) ? TextDecoration.underline : TextDecoration.none,
                      decorationColor: Colors.blue,
                    ),
                  ),
                ),
              ),
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
                        child: Text("$cancelCount", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 70.0,
                      columns: const <DataColumn>[
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
  }

  Future<void> _generatePdf(String txnId, String slipDate, String selectedTimes, List<String> selectedCharacters, int totalPoints) async {
  final pdf = pw.Document(compress: true);
  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Container(
          width: 80.0 * PdfPageFormat.mm,
          margin: const pw.EdgeInsets.all(0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "N.1 GAMING",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 12.0,
                  color: PdfColors.black,
                  letterSpacing: 2.0,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "FOR AMUSEMENT ONLY",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 11.0,
                  color: PdfColors.black,
                  letterSpacing: 1.0,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "${userName?.toUpperCase()}",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 11.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "ID: $txnId",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 11.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "Slip DT: $slipDate",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 9.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "Game Date: ",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 9.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                selectedTimes,
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 9.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                selectedCharacters.join("  "),
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 9.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "Total Quantity: $totalPoints Total Points: $totalPoints",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 9.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              _buildBarcodeWidget(txnId),
              pw.SizedBox(height: 4),
            ],
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async {
      return pdf.save();
    },
  );
}


  pw.Widget _buildBarcodeWidget(String txnId) {
    return pw.BarcodeWidget(
      barcode: Barcode.code128(
                              useCode128A: false,
                              useCode128C:
                                  false),
      data: txnId,
      width: 280,
      height: 40,
    );
  }
}
