import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/nomal_button.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/main.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';
import 'package:piyomiru_application/screens/parent/home_parent_screen.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool pushN = false;
  bool pushP = false;
  bool loginState = true;
  bool mailAdressValidation = true;
  String name = '';
  var busList;
  final controllerN = TextEditingController();
  // final controllerP = TextEditingController();
  //FocusNode _focusNode = FocusNode();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .requestPermission(alert: true, announcement: true, badge: true);

    _firebaseMessaging.getToken().then((value) {
      print("トークン:$value");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("フォアグラウンドでメッセージを受け取りました");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        print("分岐までこれた:${channel.id}!");
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                icon: 'launch_background',
              ),
            ));
        print(channel.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 状態管理している値を操作できるようにする
    //ユーザID
    final userIdNotifier = ref.watch(userProvider.notifier);

    //ファミリーID
    final familyIdNotifier = ref.watch(familyProvider.notifier);

    //運転手か、保護者か
    final roleNotifier = ref.watch(roleProvider.notifier);

    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kSubBackgroundColor,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: deviceH * 1 / 6),
                  alignment: Alignment.center,
                  child: const Text(
                    "PiyoMiru",
                    style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: kTitleColor,
                        fontFamily: 'Rajdhani-B'),
                  ),
                ),
                SizedBox(height: deviceH * 0.06),
                !loginState
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/sannkaku_keikoku.png'),
                          Text(
                            "メールアドレスまたはパスワードが正しくありません",
                            style: TextStyle(
                                fontSize: 11,
                                color: errorColor,
                                fontFamily: 'KiwiMaru-L'),
                          )
                        ],
                      )
                    : SizedBox(height: deviceH * 0.026),

                Stack(
                  //////////メールアドレス入力ボックス//////////
                  children: [
                    //!loginState || !mailAdressValidation?

                    Container(
                      height: deviceH * 0.10,
                      width: deviceW * 0.78,
                      decoration: BoxDecoration(
                        color: kInputColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1,
                            color: !mailAdressValidation || !loginState
                                ? errorColor
                                : Colors.transparent),
                      ),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          controller: controllerN,
                          //autofocus: true,
                          //focusNode: _focusNode,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            fontSize: 24,
                            color: kFontColor,
                          ),
                          cursorColor: kFontColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 24),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                mailAdressValidation =
                                    EmailValidator.validate(value);
                                pushN = true;
                                name = value;
                              });
                            } else {
                              setState(() {
                                pushN = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      top: 11,
                      left: 20,
                      child: Text(
                        "メールアドレス",
                        style: TextStyle(
                            fontSize: 12,
                            color: !mailAdressValidation || !loginState
                                ? errorColor
                                : kFontColor,
                            fontFamily: 'KiwiMaru-L'),
                      ),
                    )
                  ],
                ), //////////メールアドレス入力ボックス//////////

                !mailAdressValidation
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: errorColor,
                                ),
                                height: 15,
                                width: 15,
                              ),
                              Text(
                                "×",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: 'KiwiMaru-R'),
                              )
                            ],
                          ),
                          Text(
                            "メールアドレスのフォーマットで入力してください　",
                            style: TextStyle(
                                fontSize: 11,
                                color: errorColor,
                                fontFamily: 'KiwiMaru-L'),
                          )
                        ],
                      )
                    : SizedBox(height: deviceH * 0.024),

                SizedBox(height: deviceH * 0.03),

                Stack(
                  //////////パスワード入力ボックス//////////
                  children: [
                    Container(
                      height: deviceH * 0.10,
                      width: deviceW * 0.78,
                      decoration: BoxDecoration(
                        color: kInputColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1,
                            color:
                                loginState ? Colors.transparent : errorColor),
                      ),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          //controller: controllerP,
                          obscureText: true,
                          style: const TextStyle(
                            fontSize: 24,
                            color: kFontColor,
                            fontFamily: 'KiwiMaru-R',
                          ),
                          cursorColor: kFontColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 24),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                pushP = true;
                              });
                            } else {
                              setState(() {
                                pushP = false;
                              });
                            }
                            ;
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 11,
                      left: 20,
                      child: Text(
                        "パスワード",
                        style: TextStyle(
                            fontSize: 12,
                            color: loginState ? kFontColor : errorColor,
                            fontFamily: 'KiwiMaru-L'),
                      ),
                    )
                  ],
                ), //////////パスワード入力ボックス//////////
              ],
            ),
            pushN && pushP
                ? Positioned(
                    bottom: deviceH * 1 / 8,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                        onTap: () {
                          Users().getMailIdUsers(name).then((value) => {
                                userIdNotifier.state = value,
                                Users().getroleUser(value).then((value) => {
                                      roleNotifier.state = value,
                                      if (value == true)
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeDriverScreen()))
                                        }
                                      else
                                        {
                                          Users()
                                              .getFamilyUsers(name)
                                              .then((value) => {
                                                    familyIdNotifier.state =
                                                        value,
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeParentScreen(
                                                                    familyId:
                                                                        value)))
                                                  })
                                        }
                                    })
                              });

                          setState(() {
                            loginState = false;
                          });

                          // controllerN.clear();
                          // controllerP.clear();
                          //_focusNode.requestFocus();
                          print(mailAdressValidation);
                          print(loginState);
                        },
                        child: NomalButton(
                          text: "ログイン",
                          pushable: true,
                        )),
                  )
                : Positioned(
                    bottom: deviceH * 1 / 8,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                        onTap: () {},
                        child: NomalButton(
                          text: "ログイン",
                          pushable: false,
                        )),
                  ),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: deviceH * 1 / 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("アカウントをお持ちでない場合",
                        style: TextStyle(
                          color: kFontColor,
                          fontFamily: "KiwiMaru-L",
                          fontSize: 17,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/lp");
                      },
                      child: const Text("登録はこちら",
                          style: TextStyle(
                              color: kFontColor,
                              fontFamily: "KiwiMaru-M",
                              fontSize: 17,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                )),
          ],
        ));
  }
}
