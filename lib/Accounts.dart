import 'package:bet/Accounts/AccountsBottom.dart';
import 'package:bet/Accounts/AccountsTop.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Accounts extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.blueGrey,
        actions: [
          Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text("N.1 GAMING", style: TextStyle(
                  fontFamily: 'YoungSerif',
                  fontWeight: FontWeight.bold,
                  fontSize: 60.0,
                  color: Color(0xFFF3FDE8),
                  letterSpacing: 2.0,
                ),
                  textAlign: TextAlign.center,
                ),
              )
          ),
        ],
    ),
      body: Container(
        color: HexColor("#121b2f"),
        child: Flex(
          direction: Axis.vertical,
          children: [
            AccountsTop(),
            AccountsBottom(),
          ],
        ),
      )
    );
  }
}