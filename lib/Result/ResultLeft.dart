import 'package:bet/Home.dart';
import 'package:bet/Result/ResultDateForm.dart';
import 'package:flutter/material.dart';

class ResultLeft extends StatefulWidget{
  @override
  _Left createState() => _Left();
}

class _Left extends State<ResultLeft>{

  void goBack() {
    Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
  }

  DateTime _dateTime = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
    ).then((value) => {
      setState(() {
        _dateTime = value!;
      })
    });
  }


  @override
  Widget build(BuildContext context){
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("N.1 GAMING", style: TextStyle(
          fontFamily: 'YoungSerif',
          fontWeight: FontWeight.bold,
          fontSize: mediaQuery.size.width * 0.025,
          color: Color(0xFFF3FDE8),
          letterSpacing: 2.0,
          
        ),),

        ResultDateForm(),

        Container(
          width: 100.0,
          height: 40.0,
          margin: EdgeInsets.only(top: 300),
          child: ElevatedButton(
            onPressed: goBack,
            child: Text("Back", style: TextStyle(
              color: Colors.indigo,
              fontSize: 20.0,
              fontFamily: "SansSerif",
            ),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3FDE8)),
              ),
            ),
          ),

      ],
    );
  }
}