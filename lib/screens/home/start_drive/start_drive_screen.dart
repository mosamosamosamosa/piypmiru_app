import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/constants.dart';

import 'package:piyomiru_application/screens/home/logout_modal.dart';
import 'package:piyomiru_application/screens/home/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/home/start_drive/start_drive_modal.dart';

class StartDriveScreen extends StatelessWidget {
  StartDriveScreen({
    Key? key,
    //required this.name,
  }) : super(key: key);

  //final String name;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: deviceH * 0.1,
          centerTitle: false,

          leading: GestureDetector(
              onTap: () {
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
        body: SizedBox(
          height: deviceH,
          width: deviceW,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: deviceH * 0.18),
                  Text(
                    "停車中",
                    style: const TextStyle(
                        fontSize: 40,
                        //fontWeight: FontWeight.bold,
                        color: kFontColor,
                        fontFamily: 'KiwiMaru-M'),
                  ),
                  SizedBox(height: deviceH * 0.04),
                  Image.asset('assets/images/bus_stop_home.png'),
                ],
              ),
              Stack(
                children: [
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: deviceH * 0.12),
                      child: GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  StartDriveModal(),
                            );
                          },
                          child: const AppButton(
                            text: "運転開始",
                            start: true,
                            pushable: true,
                          ))),
                  Positioned(
                      bottom: deviceH * 0.2,
                      right: deviceW * 0.23,
                      child: Image.asset('assets/images/hiyoko_beginer.png'))
                ],
              ),
            ],
          ),
        ));
  }
}
