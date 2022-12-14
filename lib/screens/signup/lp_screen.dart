import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/components/nomal_button.dart';
import 'package:piyomiru_application/screens/signup/chose_screen.dart';

class LpScreen extends StatefulWidget {
  LpScreen({Key? key}) : super(key: key);

  @override
  _LpScreenState createState() => _LpScreenState();
}

class _LpScreenState extends State<LpScreen> {
  bool lpPage1Visible = true;
  bool lpPage2Visible = false;
  bool lpPage3Visible = false;
  bool StartButtonVisible = false;

  //int LpPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: kSubBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: deviceH * 0.2),
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                    ),
                    Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'PiyoMiru',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rajdhani-B',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = kFrameColor,
                          ),
                        ),
                        // Solid text as fill.
                        const Text(
                          'PiyoMiru',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: kTitleColor,
                            fontFamily: 'Rajdhani-B',
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '??????',
                      style: TextStyle(
                          fontSize: 20,
                          color: kFontColor,
                          fontFamily: 'KiwiMaru-M'),
                    )
                  ],
                ),
                Visibility(
                  /////////////lp?????????1//////////////////
                  visible: lpPage1Visible,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: const Alignment(0.0, 0.0),
                        child: Container(
                          height: deviceH * 0.5,
                          width: deviceW * 0.78,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: kInputColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 3, color: kSubBackgroundColor),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 66,
                          ),
                          Text(
                            "??????????????????\n???????????????????????????\n?????????????????????",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                color: kFontColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KiwiMaru-L'),
                          ),
                          SizedBox(
                            height: 56,
                          ),
                          Image.asset('assets/images/kids.png'),
                          SizedBox(
                            height: 52,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kSubBackgroundColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                          //Align???????????????????????????x????????????????????????????????????(???^???)
                          top: -35,
                          right: 55,
                          child:
                              Image.asset('assets/images/hiyoko_beginer.png')),
                      Positioned(
                        /////////////lp?????????1?????????????????????//////////////////
                        top: 175,
                        bottom: 175,
                        right: 25,
                        child: GestureDetector(
                            onTap: () {
                              //print("PageCount=$LpPageIndex");//LpPageIndex????????????
                              setState(() {
                                //LpPageIndex++;
                                lpPage1Visible = false;
                                lpPage2Visible = true;
                              });
                            },
                            child:
                                Image.asset('assets/images/button_right.png')),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  /////////////lp?????????2//////////////////
                  visible: lpPage2Visible,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: const Alignment(0.0, 0.0),
                        child: Container(
                          height: deviceH * 0.5,
                          width: deviceW * 0.78,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: kInputColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 3, color: kSubBackgroundColor),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 66,
                          ),
                          Text(
                            "???????????????",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                color: kFontColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KiwiMaru-L'),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          Image.asset('assets/images/handle.png'),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "NFC????????????\n???????????????????????????\n??????????????????\n??????????????????????????????",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                color: kFontColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KiwiMaru-L'),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kSubBackgroundColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                          //Align???????????????????????????x????????????????????????????????????(???^???)
                          top: -35,
                          right: 55,
                          child:
                              Image.asset('assets/images/hiyoko_beginer.png')),
                      Positioned(
                        /////////////lp?????????2?????????????????????//////////////////
                        top: 175,
                        bottom: 175,
                        left: 25,
                        child: GestureDetector(
                            onTap: () {
                              //print("PageCount=$LpPageIndex");//LpPageIndex????????????
                              setState(() {
                                //LpPageIndex--;
                                lpPage2Visible = false;
                                lpPage1Visible = true;
                              });
                            },
                            child:
                                Image.asset('assets/images/button_left.png')),
                      ),
                      Positioned(
                        /////////////lp?????????2?????????????????????//////////////////
                        top: 175,
                        bottom: 175,
                        right: 25,
                        child: GestureDetector(
                            onTap: () {
                              //print("PageCount=$LpPageIndex");//LpPageIndex????????????
                              setState(() {
                                //LpPageIndex++;
                                lpPage2Visible = false;
                                lpPage3Visible = true;
                                StartButtonVisible = true;
                              });
                            },
                            child:
                                Image.asset('assets/images/button_right.png')),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  /////////////lp?????????3//////////////////
                  visible: lpPage3Visible,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: const Alignment(0.0, 0.0),
                        child: Container(
                          height: deviceH * 0.5,
                          width: deviceW * 0.78,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: kInputColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 3, color: kSubBackgroundColor),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 66,
                          ),
                          Text(
                            "???????????????",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                color: kFontColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KiwiMaru-L'),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Image.asset('assets/images/heart.png'),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "????????????????????????\n?????????????????????\n??????????????????",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                color: kFontColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KiwiMaru-L'),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kSubBackgroundColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                          //Align???????????????????????????x????????????????????????????????????(???^???)
                          top: -35,
                          right: 55,
                          child:
                              Image.asset('assets/images/hiyoko_beginer.png')),
                      Positioned(
                        /////////////lp????????????3??????????????????//////////////////
                        top: 175,
                        bottom: 175,
                        left: 25,
                        child: GestureDetector(
                            onTap: () {
                              //print("PageCount=$LpPageIndex");//LpPageIndex????????????
                              setState(() {
                                //LpPageIndex--;
                                lpPage3Visible = false;
                                StartButtonVisible = false;
                                lpPage2Visible = true;
                              });
                            },
                            child:
                                Image.asset('assets/images/button_left.png')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              /////////////lp?????????3????????????????????????//////////////////
              visible: StartButtonVisible,
              child: Positioned(
                bottom: deviceH * 1 / 8,
                left: 0,
                right: 0,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ChoseScreen()),
                      );
                    },
                    child: NomalButton(
                      text: "????????????",
                      pushable: true,
                    )),
              ),
            )
          ],
        ));
  }
}
