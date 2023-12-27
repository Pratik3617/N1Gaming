import 'package:bet/Accounts.dart';
import 'package:bet/Login/Login.dart';
import 'package:bet/Result.dart';
import 'package:bet/TransactionList/Transaction.dart';
import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'package:bet/providers/ShowResult.dart';
import 'package:bet/providers/LoginProvider.dart';
import 'package:bet/providers/TransactionListProvider.dart';


const TextStyle customTextStyle = TextStyle(
  fontFamily: 'SansSerif', // Use the font family you specified in pubspec.yaml
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GameSelector()
        ),

        ChangeNotifierProvider(
          create: (context) => ShowResultProvider()
        ),

        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText2: customTextStyle,
          ),
        ),
        home: const Login(),
        routes: {
          '/result': (_) => Result(),
          '/accounts': (_) => Accounts(),
          '/home': (_) =>  Home(),
          '/transaction': (_) => Transaction(),
        },

      ),
    ),
  );
}

