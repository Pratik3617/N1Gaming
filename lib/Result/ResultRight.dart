import 'package:bet/Result.dart';
import 'package:flutter/material.dart';
import 'package:bet/providers/ShowResult.dart';
import 'package:provider/provider.dart';

class ResultRight extends StatelessWidget {
  List<String> listAlpha = ["Time", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"];

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowResultProvider>(
      builder: (context, showResultProvider, child) {
        List<dynamic> result = showResultProvider.data;
        if (result.isEmpty){
          return Center(
            child: Text("No data available for the selected date!!!!"),
          );
        }else{
          return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                21,
                    (index) {
                  double width = index == 0 ? 100.0 : 50.0;
                  return Container(
                    color: Colors.amberAccent,
                    width: width,
                    height: 30.0,
                    child: Text(
                      listAlpha[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                      ),
                    ),
                  );
                },
              ),
            ),
            // Scrollable content
            Expanded(
              child: ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      21,
                          (col) {
                        double width = col == 0 ? 100.0 : 50.0;
                        Color bgcolor = col == 0 ? Colors.teal : Colors.lightGreen;
                        return Container(
                          width: width,
                          color: bgcolor,
                          height: 30.0,
                          margin: EdgeInsets.only(top: 2.0),
                          padding: EdgeInsets.only(top: 2.0),
                          child: Text(
                            result[row][col].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
        }
      },
    );
  }
}
