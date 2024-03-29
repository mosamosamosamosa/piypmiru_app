// ignore_for_file: await_only_futures

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/family.dart';
import 'package:piyomiru_application/api/users.dart';

import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/components/nomal_button.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';
import 'package:piyomiru_application/screens/parent/home_parent_screen.dart';

class SignupScreen2 extends ConsumerStatefulWidget {
  SignupScreen2({Key? key, required this.driver, required this.groupId})
      : super(key: key);

  final bool driver;
  final int groupId;

  @override
  _SignupScreen2 createState() => _SignupScreen2();
}

class _SignupScreen2 extends ConsumerState<SignupScreen2> {
  final _emailTextController = TextEditingController();

  bool pushN = false;
  bool pushP = false;
  bool pushM = false;
  bool pushPConf = false;
  var busList;

  String name = "";
  String email = "";
  String password = "";

  bool eEmail = true;
  bool ePasssame = true;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    final familyIdNotifier = ref.watch(familyProvider.notifier);
    final userIdNotifier = ref.watch(userProvider.notifier);

    return Scaffold(
        backgroundColor: kSubBackgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: deviceH * 0.1,
          centerTitle: false,

          leading: GestureDetector(
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/backmark.png')),

          title: const Text(
            "PiyoMiru",
            style: TextStyle(
              color: kTitleColor,
              fontSize: 36,
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                height: 3, //高さ
                color: kBackgroundColors[1], //色
              ),
              preferredSize: Size.fromHeight(5)), //高さ
          backgroundColor: kSubBackgroundColor,
          elevation: 0.0, //影消す
        ),
        body: Stack(
          children: [
            Container(
              height: deviceH,
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: deviceH * 1 / 16),
                  const Text(
                    '--基本情報入力--',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kFontColor,
                    ),
                  ),
                  SizedBox(height: deviceH * 0.037),
                  Stack(
                    //ユーザーネーム入力ボックス
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: deviceH * 0.09,
                        width: deviceW * 0.78,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: kInputColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1.5, color: kSubBackgroundColor),
                        ),
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
                      const Positioned(
                        top: 11,
                        left: 20,
                        child: Text(
                          "ユーザーネーム",
                          style: TextStyle(
                              fontSize: 12,
                              color: kFontColor,
                              fontFamily: 'KiwiMaru-L'),
                        ),
                      ),
                      Positioned(
                          top: -22,
                          right: 20,
                          child:
                              Image.asset('assets/images/hiyoko_pencil2.png')),
                    ],
                  ),
                  SizedBox(height: deviceH * 0.02),
                  Stack(
                    //メールアドレス入力ボックス
                    children: [
                      Column(
                        children: [
                          Container(
                            height: deviceH * 0.09,
                            width: deviceW * 0.78,
                            decoration: BoxDecoration(
                              color: kInputColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1.5,
                                  color: eEmail
                                      ? kSubBackgroundColor
                                      : Color(0xFFFF00000)),
                            ),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: TextField(
                                controller: _emailTextController,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: kFontColor,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: kFontColor,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 24),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      eEmail = EmailValidator.validate(value);
                                      pushM = true;
                                      email = value;
                                    });
                                  } else {
                                    setState(() {
                                      pushM = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          eEmail
                              ? Container()
                              : Row(
                                  children: [
                                    SizedBox(width: 40),
                                    Image.asset(
                                        'assets/images/batsu_input.png'),
                                    const Text(
                                      "メールアドレスのフォーマットで入力してください",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFFF0000),
                                          fontFamily: 'KiwiMaru-L'),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      Positioned(
                        top: 11,
                        left: 60,
                        child: Text(
                          "メールアドレス",
                          style: TextStyle(
                              fontSize: 12,
                              color: eEmail ? kFontColor : Color(0xFFFF0000),
                              fontFamily: 'KiwiMaru-L'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceH * 0.02),
                  Stack(
                    //パスワード入力ボックス
                    children: [
                      Container(
                        height: deviceH * 0.09,
                        width: deviceW * 0.78,
                        decoration: BoxDecoration(
                          color: kInputColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1.5,
                              color: ePasssame
                                  ? kSubBackgroundColor
                                  : Color(0xFFFF0000)),
                        ),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: TextField(
                            //controller: controllerN,
                            obscureText: true,
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
                                  pushP = true;
                                  password = value;
                                });
                              } else {
                                setState(() {
                                  pushP = false;
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
                          "パスワード",
                          style: TextStyle(
                              fontSize: 12,
                              color: ePasssame ? kFontColor : Color(0xFFFF0000),
                              fontFamily: 'KiwiMaru-L'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceH * 0.02),
                  Column(
                    children: [
                      Stack(
                        //パスワード確認入力ボックス
                        children: [
                          Container(
                            height: deviceH * 0.09,
                            width: deviceW * 0.78,
                            decoration: BoxDecoration(
                              color: kInputColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1.5,
                                  color: ePasssame
                                      ? kSubBackgroundColor
                                      : Color(0xFFFF0000)),
                            ),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: TextField(
                                //controller: controllerN,
                                obscureText: true,
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
                                    if (password == value) {
                                      setState(() {
                                        pushPConf = true;
                                      });
                                    } else {
                                      setState(() {
                                        ePasssame = false;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      pushPConf = false;
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
                              "パスワード確認",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ePasssame
                                      ? kFontColor
                                      : Color(0xFFFF0000),
                                  fontFamily: 'KiwiMaru-L'),
                            ),
                          ),
                        ],
                      ),
                      ePasssame
                          ? Container()
                          : Row(
                              children: [
                                SizedBox(width: 40),
                                Image.asset('assets/images/batsu_input.png'),
                                const Text(
                                  "再入力パスワードが違います。再度入力してください",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFFF0000),
                                      fontFamily: 'KiwiMaru-L'),
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
            pushN && pushP && pushM && pushPConf
                ? Positioned(
                    bottom: deviceH * 1 / 8,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                        onTap: () async {
                          print("こっち来て");
                          if (eEmail) {
                            print("こっち来ても歌");
                            Users()
                                .postUser(name, email, password, widget.driver,
                                    widget.groupId)
                                .then((value) => {
                                      setState(() {
                                        userIdNotifier.state = value;
                                      }),
                                      if (widget.driver)
                                        {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeDriverScreen()),
                                          )
                                        }
                                      else
                                        {
                                          Families()
                                              .postFamily(name)
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
                                    });
                          } else {
                            print(eEmail);
                            setState(() {
                              eEmail = false;
                            });
                            print("ここまできた");
                          }
                        },
                        child: NomalButton(
                          text: "新規登録",
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
                          text: "新規登録",
                          pushable: false,
                        )),
                  )
          ],
        ));
  }
}
