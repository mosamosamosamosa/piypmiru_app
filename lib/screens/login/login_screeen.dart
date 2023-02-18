//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/nomal_button.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';
import 'package:piyomiru_application/screens/parent/home_parent_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool pushN = false;
  bool pushP = false;
  String name = '';
  var busList;

  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // @override
  // void initState() {
  //   super.initState();

  //   _firebaseMessaging.getToken().then((value) {
  //     print("$value");
  //   });
  // }

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
                Stack(
                  children: [
                    Container(
                      height: deviceH * 0.10,
                      width: deviceW * 0.78,
                      decoration: BoxDecoration(
                        color: kInputColor,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 3, color: kSubBackgroundColor),
                      ),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          //controller: controllerN,
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
                    const Positioned(
                      top: 11,
                      left: 20,
                      child: Text(
                        "メールアドレス",
                        style: TextStyle(
                            fontSize: 12,
                            color: kFontColor,
                            fontFamily: 'KiwiMaru-L'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: deviceH * 0.03),
                Stack(
                  children: [
                    Container(
                      height: deviceH * 0.10,
                      width: deviceW * 0.78,
                      decoration: BoxDecoration(
                        color: kInputColor,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 3, color: kSubBackgroundColor),
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
                    const Positioned(
                      top: 11,
                      left: 20,
                      child: Text(
                        "パスワード",
                        style: TextStyle(
                            fontSize: 12,
                            color: kFontColor,
                            fontFamily: 'KiwiMaru-L'),
                      ),
                    ),
                  ],
                ),
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
