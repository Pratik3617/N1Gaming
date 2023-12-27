import 'package:bet/Login/LoginForm.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginCard> {
  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("N.1 GAMING",
            style: TextStyle(
              fontFamily: "YoungSerif",
              fontSize: 50.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: Colors.deepPurpleAccent
            ),
            ),

            SizedBox(height: 20),

            Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
