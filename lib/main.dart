import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/screens/chose_screen.dart';
import 'package:piyomiru_application/screens/home/home_driver_screen.dart';
import 'package:piyomiru_application/screens/home/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/home/start_drive/start_drive_screen.dart';
import 'package:piyomiru_application/screens/splash_screen.dart';

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
        '/': (BuildContext context) => const HomeDriverScreen(),
        //'/home': (BuildContext context) => StartDriveScreen(),
      },
    );
  }
}
