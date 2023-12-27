import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Result_Display_Box extends StatelessWidget {
  const Result_Display_Box({super.key, required this.text1,required this.text2,required this.text3,required this.text4});
  final String text1;
  final String text2;
  final String text3;
  final String text4;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width * 0.135,
      height: mediaQuery.size.height * 0.05,
      margin: const EdgeInsets.fromLTRB(4.0, 2.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 50.0,
              height: 38.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.yellow,
                      width: 2.0
                  ),
                  borderRadius : BorderRadius.circular(2.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    text1,
                    style: const TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  )
                ],
              )
          ),
          Container(
              width: 50.0,
              height: 38.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.yellow,
                      width: 2.0
                  ),
                  borderRadius : BorderRadius.circular(2.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    text2,
                    style: const TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  )
                ],
              )
          ),
          Container(
              width: 50.0,
              height: 38.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.yellow,
                      width: 2.0
                  ),
                  borderRadius : BorderRadius.circular(2.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    text3,
                    style: const TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  )
                ],
              )
          ),
          Container(
              width: 50.0,
              height: 38.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.yellow,
                      width: 2.0
                  ),
                  borderRadius : BorderRadius.circular(2.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text4,
                    style: const TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
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