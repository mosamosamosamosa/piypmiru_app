import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/firebase_options.dart';
import 'package:piyomiru_application/riverpod_samp/my_widget.dart';

import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';
import 'package:piyomiru_application/screens/login/login_screeen.dart';

import 'package:piyomiru_application/screens/signup/chose_screen.dart';
import 'package:piyomiru_application/screens/signup/lp_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(ProviderScope(child: MyApp()));
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
        '/lp': (BuildContext context) => LpScreen(),
      },
    );
  }
}
