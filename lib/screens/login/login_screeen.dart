import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piyomiru_application/components/nomal_button.dart';
import 'package:piyomiru_application/constants.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool pushN = false;
  bool pushP = false;
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    final controllerN = TextEditingController();
    final controllerP = TextEditingController();

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
                      fontFamily: 'Kiwi_Maru'),
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
                      border: Border.all(width: 3, color: kSubBackgroundColor),
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
                      "ユーザーネーム",
                      style: TextStyle(fontSize: 12, color: kFontColor),
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
                      border: Border.all(width: 3, color: kSubBackgroundColor),
                    ),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: TextField(
                        //controller: controllerP,
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
                      style: TextStyle(fontSize: 12, color: kFontColor),
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
                        Navigator.of(context).pushReplacementNamed("/home");
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
                      onTap: () {
                        print("P=$pushP");
                        print("N=$pushN");
                      },
                      child: NomalButton(
                        text: "ログイン",
                        pushable: false,
                      )),
                )
        ],
      ),
    );
  }
}
