import 'package:bet/Login/LoginCard.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0,horizontal: 60.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 450,
                height: 500,
                child: LoginCard(),
              )
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Let's Play Together And Win!",
                style: TextStyle(
                  fontFamily: 'YoungSerif',
                  color: Colors.amber,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  decoration: TextDecoration.none
                ),
              )
            ],
          )
        ],
      ),
      )
    );
  }
}