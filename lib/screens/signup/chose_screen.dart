import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/components/chose.dart';
import 'package:piyomiru_application/components/nomal_button.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/login/login_screeen.dart';
import 'package:piyomiru_application/screens/signup/signup_screen.dart';
import 'package:piyomiru_application/screens/splash_screen.dart';

class ChoseScreen extends ConsumerStatefulWidget {
  ChoseScreen({Key? key}) : super(key: key);

  @override
  _ChoseScreenState createState() => _ChoseScreenState();
}

class _ChoseScreenState extends ConsumerState<ChoseScreen> {
  bool selected_parent = false;
  bool selected_driver = false;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    //運転手か、保護者か
    final roleNotifier = ref.watch(roleProvider.notifier);

    return Scaffold(
      backgroundColor: kSubBackgroundColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: deviceH * 1 / 6),
                child: const Text(
                  "PiyoMiru",
                  style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: kTitleColor,
                      fontFamily: 'Rajdhani-B'),
                ),
              ),
              SizedBox(height: deviceH * 1 / 12),
              // Expanded(

              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: const [
              //       Chose(role: "保護者", roleimg: "parent.png"),
              //       SizedBox(width: 35),
              //       Chose(role: "運転手", roleimg: "driver.png"),
              //     ],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_parent = true;
                          selected_driver = false;
                        });
                      },
                      child: Chose(
                        role: "保護者",
                        roleimg: "parent.png",
                        selected: selected_parent,
                      )),
                  SizedBox(width: deviceW * 1 / 12),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_parent = false;
                          selected_driver = true;
                        });
                      },
                      child: Chose(
                        role: "運転手",
                        roleimg: "driver.png",
                        selected: selected_driver,
                      )),
                ],
              ),
            ],
          ),
          selected_parent || selected_driver
              ? Positioned(
                  bottom: deviceH * 1 / 8,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          roleNotifier.state = selected_driver;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignupScreen(driver: selected_driver)),
                          );
                        });
                      },
                      child: NomalButton(
                        text: "決定",
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
                        text: "決定",
                        pushable: false,
                      )),
                ),
          Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: deviceH * 1 / 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("既にアカウントをお持ちの場合",
                      style: TextStyle(
                        color: kFontColor,
                        fontFamily: "KiwiMaru-L",
                        fontSize: 17,
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LoginScreen()),
                          (_) => false);
                    },
                    child: const Text("ログインはこちら",
                        style: TextStyle(
                            color: kFontColor,
                            fontFamily: "KiwiMaru-M",
                            fontSize: 17,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
