// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:barcode_widget/barcode_widget.dart';
import 'package:bet/Home.dart';
import 'package:bet/Home/HomeMiddleOne.dart';
import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

class HomeBottom extends StatefulWidget {

  final int GrandTotal;
  final VoidCallback onButtonPressed;
  final Function(String transID, int endpoint) onDataChanged;
  const HomeBottom(
      {super.key,
      required this.GrandTotal,
      required this.onButtonPressed,
      required this.onDataChanged});

  @override
  _PrintingWidget createState() => _PrintingWidget();
  
}

class _PrintingWidget extends State<HomeBottom>{

  // GlobalKey<_PrintingWidget> homePageKey = GlobalKey<_PrintingWidget>();
  
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

  
  @override
  Widget build(BuildContext context) {
   
    final select = Provider.of<GameSelector>(context, listen: false);
    final GlobalKey _key = GlobalKey();

    String txnId = "TXN${DateTime.now().millisecondsSinceEpoch}";
    List<String> selectedCharacters = [];
    String selectedTimes = "";
    int totalPoints = 0;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String nextDayDate =
        DateFormat('dd/MM/yyyy').format(now.add(Duration(days: 1)));
    select.timesValues.forEach((key, value) {
      if (value.selected == true) {
        selectedTimes +=
            "${select.showNextDayTimes ? nextDayDate : formattedDate} $key,";
      }
    });

    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: !(select.selectedToday ?? false),
                child: SizedBox(
                  height: mediaQuery.size.height * 0.04,
                  child: ElevatedButton(
                    onPressed: () {
                      select.todayClicked();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "SansSerif",
                            color: Colors.white),
                      ),
                    ),
                    child: Text(" TODAY ",
                        style: TextStyle(
                            fontFamily: "SansSerif",
                            letterSpacing: 2.0,
                            fontSize: mediaQuery.size.width * 0.01)),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: select.selectedToday ?? false,
            child: SizedBox(
              height: mediaQuery.size.height * 0.04,
              child: ElevatedButton(
                onPressed: () {
                  select.nextDayClicked();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: Colors.yellow, width: 2.0),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "SansSerif",
                        color: Colors.white),
                  ),
                ),
                child: Text(" NEXT DAY ",
                    style: TextStyle(
                        fontFamily: "SansSerif",
                        letterSpacing: 2.0,
                        fontSize: mediaQuery.size.width * 0.01)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.04,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontFamily: "SansSerif",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    child: Text("Update Results",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: mediaQuery.size.width * 0.01,
                            fontFamily: "SansSerif")),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.04,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontFamily: "SansSerif",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    child: Text("Cancel & Reprint",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: mediaQuery.size.width * 0.01,
                            fontFamily: "SansSerif")),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.04,
                  child: ElevatedButton(
                    onPressed:(){
                      widget.onButtonPressed();
                      Provider.of<GameSelector>(context, listen: false).resetTimes();
                      Provider.of<GameSelector>(context, listen: false).resetCheckBox();
                      Provider.of<GameSelector>(context, listen: false).resetMatrixData();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontFamily: "SansSerif",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    child: Text("Reset All",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: mediaQuery.size.width * 0.01,
                            fontFamily: "SansSerif")),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.04,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedCharacters.clear();
                      final select =
                          Provider.of<GameSelector>(context, listen: false);
                      for (int i = 0; i < 10; i++) {
                        for (int j = 0; j < 10; j++) {
                          String? textValue = select.controllers[i][j].text;
                          if (select.activeMatrix.length == 1) {
                            select.matrixList[select.checkbox
                                    .indexOf(select.activeMatrix)][i][j] =
                                textValue != "" ? textValue : "";
                          } else if (select.activeMatrix == "AT") {
                            for (int k = 0; k < 20; k++) {
                              select.matrixList[k][i][j] =
                                  textValue != "" ? textValue : "";
                            }
                          } else if (select.activeMatrix == "AJ") {
                            for (int k = 0; k < 10; k++) {
                              select.matrixList[k][i][j] =
                                  textValue != "" ? textValue : "";
                            }
                          } else if (select.activeMatrix == "KT") {
                            for (int k = 10; k < 20; k++) {
                              select.matrixList[k][i][j] =
                                  textValue != "" ? textValue : "";
                            }
                          }
                        }
                      }

                      

                      for (int i = 0; i < 20; i++) {
                        for (int j = 0; j < 10; j++) {
                          for (int k = 0; k < 10; k++) {
                            if (select.matrixList[i][j][k] != "" &&
                                select.matrixList[i][j][k] != "0") {
                              selectedCharacters.add(
                                  "${select.checkbox[i]}-$j$k - ${int.parse(select.matrixList[i][j][k] ?? "0") * 2}");
                              totalPoints += (int.parse(
                                      select.matrixList[i][j][k] ?? "0") *
                                  2);
                            }
                          }
                        }
                      }

                      String slipDate = DateFormat('dd/MM/yyyy HH:MM:ss')
                          .format(DateTime.now());

                      final body = {
                        "username": "${userName}",
                        "transaction_id": txnId,
                        "gamedate_times": selectedTimes.split(",").map((time) => time.trim()).where((time) => time.isNotEmpty).toList(),
                        "slipdate_time": slipDate,
                        "points": totalPoints.toString(),
                        "GamePlay": selectedCharacters
                      };

                      Dialog printDialog = Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        backgroundColor: Colors.white,
                        child: Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.8),
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          clipBehavior: Clip.hardEdge,
                          padding: EdgeInsets.only(bottom: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RepaintBoundary(
                                  key: _key,
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "N.1 GAMING",
                                          style: TextStyle(
                                            fontFamily: 'YoungSerif',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.black,
                                            letterSpacing: 2.0,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "FOR AMUSEMENT ONLY",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "${userName?.toUpperCase()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "ID : ${txnId}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Slip DT : ${slipDate}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Game Date : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          selectedTimes,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          selectedCharacters.join(" "),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Total Quantity : $totalPoints Total Points : $totalPoints",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        BarcodeWidget(
                                          barcode: Barcode.code128(
                                              useCode128A: false,
                                              useCode128C:
                                                  false), // Barcode type and settings
                                          data: txnId, // Content
                                          width: 300,
                                          height: 50,
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 40.0,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // widget.onDataChanged(txnId, totalPoints);
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          side: MaterialStateProperty.all<
                                              BorderSide>(
                                            BorderSide(
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
                                        child: Text("Close",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontFamily: "SansSerif")),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40.0,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          widget.onDataChanged(txnId, totalPoints);

                                          widget.onButtonPressed();
                                          Provider.of<GameSelector>(context, listen: false).resetTimes();
                                          Provider.of<GameSelector>(context, listen: false).resetCheckBox();
                                          Provider.of<GameSelector>(context, listen: false).resetMatrixData();

                                          await _generatePdf(txnId, slipDate, selectedTimes,selectedCharacters,totalPoints);

                                    
                                          await select.postGameData(body);
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          side: MaterialStateProperty.all<
                                              BorderSide>(
                                            BorderSide(
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
                                        child: Text("Print",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontFamily: "SansSerif")),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => printDialog);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                            fontFamily: "SansSerif",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    child: Text("Play",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "SansSerif",
                            fontSize: mediaQuery.size.width * 0.01)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Grand Total: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SansSerif",
                          fontSize: mediaQuery.size.width * 0.01)),
                  SizedBox(
                    width: mediaQuery.size.width * 0.04,
                    height: mediaQuery.size.height * 0.04,
                    child: TextField(
                      controller: TextEditingController(text: "${widget.GrandTotal}"),
                      keyboardType:
                          TextInputType.number, // Set keyboard type to numeric
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        // Allow only digits
                      ],
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "SanSerif"),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      width: mediaQuery.size.width * 0.04,
                      height: mediaQuery.size.height * 0.04,
                      child: TextField(
                        controller: TextEditingController(text: "${widget.GrandTotal}"),
                        keyboardType: TextInputType
                            .number, // Set keyboard type to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                        ],
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "SanSerif"),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Net Total: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SansSerif",
                          fontSize: mediaQuery.size.width * 0.01)),
                  SizedBox(
                    width: mediaQuery.size.width * 0.04,
                    height: mediaQuery.size.height * 0.04,
                    child: TextField(
                      controller: TextEditingController(text: "${widget.GrandTotal}"),
                      keyboardType:
                          TextInputType.number, // Set keyboard type to numeric
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only digits
                      ],
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SanSerif"),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      width: mediaQuery.size.width * 0.04,
                      height: mediaQuery.size.height * 0.04,
                      child: TextField(
                        controller: TextEditingController(text: "${widget.GrandTotal}"),
                        keyboardType: TextInputType
                            .number, // Set keyboard type to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                        ],
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SanSerif"),
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Center(
              child: Text("N.1 GAMING",
                  style: TextStyle(
                    fontFamily: 'YoungSerif',
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQuery.size.width * 0.02,
                    color: Color(0xFFF3FDE8),
                    letterSpacing: 2.0,
                  )),
            ),
          ),
        ],
      ),
    );

    
  }
  
  Future<void> _generatePdf(String txnId, String slipDate, String selectedTimes,List<String> selectedCharacters, int totalPoints ) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        // pageFormat: PdfPageFormat.letter.copyWith(width: 200),
        build: (context) {
          return pw.Center(
            child: pw.Column(
            // mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "N.1 GAMING",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 18.0,
                  color: PdfColors.black,
                  letterSpacing: 2.0,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "FOR AMUSEMENT ONLY",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 18.0,
                  color: PdfColors.black,
                  letterSpacing: 2.0,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "${userName?.toUpperCase()}",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 14.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "ID : ${txnId}",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 14.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "Slip DT : ${slipDate}",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 14.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "Game Date : ",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 14.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                selectedTimes,
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 14.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                selectedCharacters.join("  "),
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 14.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                "Total Quantity : $totalPoints Total Points : $totalPoints",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 14.0,
                  color: PdfColors.black,
                ),
              ),
              
              pw.SizedBox(height: 5),
              _buildBarcodeWidget(txnId),
              pw.SizedBox(height: 10),
            ],
          )
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
                                  false), // Barcode type and settings
      data: txnId,
      width: 300,
      height: 50,
    );
  }
}
