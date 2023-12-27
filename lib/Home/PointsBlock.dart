import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PointsBlock extends StatelessWidget {
  const PointsBlock({super.key, required this.text1, required this.text2, this.color=Colors.amberAccent, this.textColor=Colors.white});
  final String text1;
  final String text2;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context){
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width * 0.1,
      height: mediaQuery.size.height * 0.05,
      margin: const EdgeInsets.fromLTRB(4.0, 2.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: mediaQuery.size.width * 0.049,
              height: mediaQuery.size.height * 0.05,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius : BorderRadius.circular(2.0),
                border: Border.all(
                    color: Colors.white,
                    width: 1.0
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: textColor
                    ),
                  )
                ],
              )
          ),
          Container(
              width: mediaQuery.size.width * 0.049,
              height: mediaQuery.size.height * 0.05,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                      color: Colors.white,
                      width: 1.0
                  ),
                  borderRadius : BorderRadius.circular(2.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text2,
                    style: TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: textColor
                  ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}