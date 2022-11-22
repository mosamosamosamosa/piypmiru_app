import 'package:flutter/material.dart';

import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/providers/login_provider.dart';

import 'package:piyomiru_application/screens/driver/home_driver_screen.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_screen.dart';
import 'package:piyomiru_application/screens/login/login_screeen.dart';
import 'package:piyomiru_application/screens/parent/home_parent_screen.dart';
import 'package:piyomiru_application/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
        '/home': (BuildContext context) => HomeParentScreen(),
      },
    );
  }
}
