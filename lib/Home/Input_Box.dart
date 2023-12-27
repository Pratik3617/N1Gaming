import 'package:flutter/material.dart';

class Input_Box extends StatelessWidget {
  final String text;
  final Color color;
  final TextEditingController controller;
  final ValueChanged<String> onChange;

  Input_Box(
      {super.key,
      required this.text,
      required this.color,
      required this.controller,
      required this.onChange}
  );
  

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width * 0.051,
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: mediaQuery.size.width * 0.0325,
                height: mediaQuery.size.height * 0.043,
                child: TextField(
                  onChanged: onChange,
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: "SanSerif",
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: color,
                    contentPadding:
                         EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 2.0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
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
