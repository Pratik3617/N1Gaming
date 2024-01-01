import 'package:bet/providers/AccountProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountsBottom extends StatefulWidget {
  final String date1;
  final String date2;
  AccountsBottom({required this.date1, required this.date2});
  @override
  _Bottom createState() => _Bottom();
}

class _Bottom extends State<AccountsBottom> {
  List<String> listHeading = [
    "",
    " Play Points ",
    " Earn Points ",
    " End Points ",
    " Profit ",
    " Agent Bonus ",
    " Net Points "
  ];

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
    // Use the provider to get the account details
    List<String> account = Provider.of<AccountDetailsProvider>(context).accountDetails;
    

    return Container(
      width: 1000.0,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  listHeading.length,
                  (index) {
                    double width = index == 0 ? 50.0 : 150.0;
                    return Container(
                      margin: EdgeInsets.only(top: 20.0),
                      color: Colors.white,
                      width: width,
                      height: 30.0,
                      child: Text(
                        listHeading[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            Container(
              margin: EdgeInsets.fromLTRB(0, 3, 0, 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  listHeading.length,
                  (index) {
                    double width = index == 0 ? 50.0 : 150.0;

                    // Check if the index is within the bounds of the account list
                    if (index < account.length) {
                      return Container(
                        margin: EdgeInsets.only(top: 5.0),
                        color: Colors.white,
                        width: width,
                        height: 30.0,
                        child: Text(
                          "${account[index]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      // Return an empty container or handle the case when the index is out of range
                      return Container();
                    }
                  },
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () async{
                DateTime today = DateTime.now();
                await _generatePdf(userName??"", today, widget.date1, widget.date2,account[0],account[1],account[2],account[3],(int.parse(account[2])-int.parse(account[3])).toString());
              },
              child: Text(
                "Print",
                style: TextStyle(
                  fontFamily: "SansSerif",
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> _generatePdf(String username, DateTime date, String date1,String date2, String PlayPoints, String EarnPoints, String EndPoints, String Benefit, String NetToPay) async {
  final pdf = pw.Document(compress: true);
  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Container(
          width: 80.0 * PdfPageFormat.mm,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Terminal Name : $username",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 12.0,
                  color: PdfColors.black,
                  letterSpacing: 2.0,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "Account as on: $date",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 12.0,
                  color: PdfColors.black,
                  letterSpacing: 2.0,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "From : $date1  To : $date2",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 12.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "______________________________",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 12.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "PlayPoints : $PlayPoints",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 10.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "EarnPoints : $EarnPoints",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 10.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "____________________________",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 10.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "EndPoints : $EndPoints",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 10.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "Benefit : $Benefit",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 10.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "Retailer Bonus : 0.0",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 10.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "____________________________",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 10.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "Net To Pay : $NetToPay",
                style: pw.TextStyle(
                  font: pw.Font.helveticaBold(),
                  fontSize: 10.0,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 3),
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
}
