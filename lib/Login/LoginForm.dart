import 'package:bet/Home.dart';
import 'package:bet/Login/Login.dart';
import 'package:flutter/material.dart';
import '../API/Login_Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String keyLastLoginTime = 'last_login_time';

  static Future<void> setLastLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt(keyLastLoginTime, currentTime);
  }

  static Future<int?> getLastLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyLastLoginTime);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> isSessionExpired() async {
    final lastLoginTime = await getLastLoginTime();
    if (lastLoginTime != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      const int oneDayInMilliseconds = 86400000; // 24 hours in milliseconds
      // const int oneDayInMilliseconds = 10000;
      return currentTime - lastLoginTime > oneDayInMilliseconds;
    }
    return false; // If last login time is not set, assume the session is not expired
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String message = "";

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
        await SessionManager.setLastLoginTime(); // Set the last login time
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
  }

  void check_if_already_login() async {
  loginData = await SharedPreferences.getInstance();
  creditData = await SharedPreferences.getInstance();
  newuser = loginData.getBool('login') ?? true;

  if (!newuser) {
    if (await SessionManager.isSessionExpired()) {
      // Logout the user if the session is expired
      await SessionManager.logout();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
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
          
          SizedBox(height: 44),
          ElevatedButton(
            onPressed: () {
              _login(context);
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
}
