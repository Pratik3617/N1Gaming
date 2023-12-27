import 'package:flutter/material.dart';

class Button_G extends StatelessWidget {
  @override
  final String text;
  final VoidCallback onPressed;

  Button_G({required this.text, required this.onPressed});

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
              color: Colors.yellow,
              width: 2.0
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
              fontFamily: "SansSerif",
              fontWeight: FontWeight.bold
          ),
        ),
      ),

      child: Text(text),

    );
  }
}
