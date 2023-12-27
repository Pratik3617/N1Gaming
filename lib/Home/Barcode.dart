import 'package:bet/Home/ButtonG.dart';
import 'package:bet/Home/Head_Input.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _editingController = TextEditingController(text: "");
    String data = "Prateek";
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: 300.0,
        child: Column(
          children: [
            Head_Input(label: "Barcode", controller: TextEditingController()),
            Button_G(
                text: "REDEEM",
                onPressed: () {
                  setState(() {
                    data = _editingController.text;
                  });
                }),
            Center(
              child: QrImageView(
                data: data,
                version: QrVersions.auto,
                size: 200.0,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
