import 'package:bet/Result/ResultLeft.dart';
import 'package:bet/Result/ResultRight.dart';
import 'package:flutter/material.dart';
import 'package:bet/providers/ShowResult.dart';

class Result extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  color: Colors.blueGrey,
                  child: ResultLeft(),
                )
            ),
            Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: ResultRight(),
                )
            ),
          ],
        ),
    );
  }
}