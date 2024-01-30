// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bet/Home.dart';
import 'package:bet/Login/Login.dart';
import 'package:flutter/material.dart';
import '../API/Login_Api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late Box box1;


  String message = "";
  bool isChecked = false;

  late SharedPreferences loginData;
  late SharedPreferences creditData;
  late bool newuser;

  Future<void> _login(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response = await userLogin(username, password);
      if (response['message'] == 'Login successful') {
        int credit = response['credit'];
        // await SessionManager.setLastLoginTime(); // Set the last login time
        loginData.setBool('login', false);
        loginData.setString("username", username);
        creditData.setString("credit", credit.toString());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        print('User does not exist');
      }
    } catch (e) {
      setState(() {
        message = "Invalid Username or Password!!!";
      });
      print('Error during login: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    check_if_already_login();
    createBox();
  }

  void getData() async{
    if(box1.get('username')!=null){
      _usernameController.text = box1.get('username');
      isChecked = true;
      setState(() {
        
      });
    }
    if(box1.get('password')!=null){
      _passwordController.text = box1.get('password');
      isChecked = true;
      setState(() {
        
      });
    }
  }

  void createBox() async {
    box1 = await Hive.openBox('loginData');
    getData();
  }

  void check_if_already_login() async {
  loginData = await SharedPreferences.getInstance();
  creditData = await SharedPreferences.getInstance();
  newuser = loginData.getBool('login') ?? true;
}



  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Enter your username',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
            ),
          ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Remember Me",style: TextStyle(color: Colors.black),),
              Checkbox(
                value: isChecked,
                onChanged: (value){
                  isChecked = !isChecked;
                  setState(() {

                  });
                },
              ),
            ],
          ),
          SizedBox(height: 22),
          ElevatedButton(
            onPressed: () {
              _login(context);
              saveUserData();
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
            ),
            child: Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
          ),
          SizedBox(height: 10,),
          if(message != "")
            Text(
              message.isEmpty ? 
              "" : "$message",
              style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  void saveUserData(){
    if(isChecked){
      box1.put('username', _usernameController.text);
      box1.put('password', _passwordController.text);
    }
  }

}
