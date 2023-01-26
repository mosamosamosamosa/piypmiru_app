import 'package:flutter/material.dart';

import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';
import 'package:piyomiru_application/screens/login/login_screeen.dart';

import 'package:piyomiru_application/screens/signup/chose_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/', //初期画面

      // 遷移する画面を定義する
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => LoginScreen(),
        '/home': (BuildContext context) => HomeDriverScreen(),
        '/signup': (BuildContext context) => ChoseScreen(),
      },
    );
  }
}
