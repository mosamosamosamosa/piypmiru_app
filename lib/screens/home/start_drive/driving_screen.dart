import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/app_sub_button.dart';
import 'package:piyomiru_application/constants.dart';

import 'package:piyomiru_application/screens/home/logout_modal.dart';
import 'package:piyomiru_application/screens/home/passengers_kids/passengers_list_screen.dart';
import 'package:piyomiru_application/screens/home/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/home/start_drive/start_drive_modal.dart';

class DrivingScreen extends StatelessWidget {
  DrivingScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: kBackgroundColors,
          stops: [
            0.3,
            0.6,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: deviceH * 0.1,
          centerTitle: false,

          leading: GestureDetector(
              onTap: () {
                int count = 0;
                Navigator.popUntil(context, (_) => count++ >= 2);
              },
              child: Image.asset('assets/images/backmark.png')),

          title: const Text(
            "PiyoMiru",
            style: TextStyle(
              color: kTitleColor,
              fontSize: 36,
            ),
          ),
          backgroundColor: kSubBackgroundColor,
          //影消す
          elevation: 0.0,

          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterkidsScreen()),
                );
              },
              child: const ActionButton(
                text: "園児",
                img: "bear.png",
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => LogoutModal(),
                );
              },
              child: const ActionButton(
                text: "ログアウト",
                img: "frog.png",
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
                top: -60,
                right: 0,
                child: Image.asset('assets/images/cloud.png')),
            Positioned(
                top: 0,
                left: -20,
                child: Image.asset('assets/images/cloud.png')),
            Positioned(
                top: 100,
                right: -30,
                child: Image.asset('assets/images/cloud.png')),
            SizedBox(
              height: deviceH,
              width: deviceW,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: deviceH * 0.18),
                      Text(
                        "$name運転中. . .",
                        style: const TextStyle(
                          fontSize: 40,
                          //fontWeight: FontWeight.bold,
                          color: kFontColor,
                        ),
                      ),
                      SizedBox(height: deviceH * 0.04),
                      Image.asset('assets/images/bus_drive_home.png'),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              height: deviceH,
              width: deviceW,
              bottom: -deviceH * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PassengerListScreen()),
                        );
                      },
                      child:
                          AppSubButton(text: "乗車中園児確認", image: "chulip.png")),
                  AppSubButton(text: "NFCスキャナー", image: "hiyoko.png"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}