import 'package:flutter/material.dart';

class Head_Input extends StatelessWidget {
  const Head_Input({super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 27.0,
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: controller,
        style: TextStyle(
            fontSize: 14.0, color: Colors.white, fontFamily: "SanSerif"),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          filled: true,
          fillColor: Colors.grey,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          labelStyle: const TextStyle(
              color: Colors.white,
              fontFamily: "SansSerif" // Floating label text color when focused
              ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          labelText: label,
        ),
      ),
    );
  }
}
