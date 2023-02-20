import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/firebase_options.dart';
import 'package:piyomiru_application/riverpod_samp/my_widget.dart';

import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';
import 'package:piyomiru_application/screens/login/login_screeen.dart';

import 'package:piyomiru_application/screens/signup/chose_screen.dart';
import 'package:piyomiru_application/screens/signup/lp_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

// バックグラウンドの処理の実態
// トップレベルに定義
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("バックグラウンドでメッセージを受け取りました");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  //バックグラウンド用
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
