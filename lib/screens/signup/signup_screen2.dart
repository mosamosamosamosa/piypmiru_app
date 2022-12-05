import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/components/nomal_button.dart';

class SignupScreen2 extends StatefulWidget {
  SignupScreen2({Key? key}) : super(key: key);

  @override
  _SignupScreen2 createState() => _SignupScreen2();
}

class _SignupScreen2 extends State<SignupScreen2> {

  bool pushAf = false;
  bool pushAd = false;

  @override
  Widget build(BuildContext context) {

    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

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
              preferredSize: Size.fromHeight(5)
          ),//高さ
          backgroundColor: kSubBackgroundColor,
          elevation: 0.0,//影消す
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
                    '--所属情報登録--',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kFontColor,
                    ),
                  ),
                  SizedBox(height: deviceH * 0.037),
                  Stack(//所属入力ボックス
                    clipBehavior: Clip.none, children: [
                    Container(
                      height: deviceH * 0.1,
                      width: deviceW * 0.78,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: kInputColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3, color: kSubBackgroundColor),
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
                              pushAf = true;
                            });
                          } else {
                            setState(() {
                              pushAf = false;
                            });
                          }
                        },
                      ),
                    ),

                    const Positioned(
                      top: 11,
                      left: 20,
                      child: Text(
                        "所属",
                        style: TextStyle(
                            fontSize: 12,
                            color: kFontColor,
                            fontFamily: 'KiwiMaru-L'),
                      ),
                    ),
                    Positioned(
                        top: -22,
                        right: 20,
                        child: Image.asset('assets/images/hiyoko_pencil2.png')),

                  ],
                  ),
                  SizedBox(height: deviceH * 0.02),
                  Stack(             //所属住所入力ボックス
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
                                  pushAd = true;
                                });
                              } else {
                                setState(() {
                                  pushAd = false;
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
                          "所属住所",
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
            ),
            pushAf && pushAd
                ? Positioned(
              bottom: deviceH * 1 / 8,
              left: 0,
              right: 0,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/home");
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
                  onTap: () {
                    print("Af=$pushAf");
                    print("Ad=$pushAd");
                  },
                  child: NomalButton(
                    text: "新規登録",
                    pushable: false,
                  )),
            )
          ],
        )
    );
  }
}