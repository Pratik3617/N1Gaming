import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final Color borderColor;

  Button({
    this.color = Colors.amber,
    this.borderColor = Colors.white,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                width: mediaQuery.size.width * 0.0325,
                height: mediaQuery.size.height * 0.041,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: color,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 2.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
