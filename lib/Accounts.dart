// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bet/Accounts/AccountsBottom.dart';
import 'package:bet/Accounts/AccountsTop.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Accounts extends StatefulWidget {
  @override
  AccountsWidget createState() => AccountsWidget();
}

class AccountsWidget extends State<Accounts>{
  late String date1 = "";
  late String date2 = "";

  void updateDate(String date1, String date2) {
    setState(() {
      date1 = date1;
      date2 = date2;
    });
  }
  
  @override
  Widget build(BuildContext context){

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

      body: Container(
        color: HexColor("#121b2f"),
        child: Flex(
          direction: Axis.vertical,
          children: [
            AccountsTop(onDateChanged: updateDate),
            AccountsBottom(date1: date1,date2:date2),
          ],
        ),
      )
    );
  }
}