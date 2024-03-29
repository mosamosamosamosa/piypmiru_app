import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/constants.dart';

import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_modal.dart';
import 'package:piyomiru_application/screens/setting_screen.dart';

class StartDriveScreen extends ConsumerStatefulWidget {
  StartDriveScreen({Key? key, required this.busName}) : super(key: key);

  final String busName;
  @override
  _StartDriveScreenState createState() => _StartDriveScreenState();
}

class _StartDriveScreenState extends ConsumerState<StartDriveScreen> {
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
                color: kTitleColor, fontSize: 36, fontFamily: 'Rajdhani-B'),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
              child: const ActionButton(
                text: "設定",
                img: "setting.png",
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
                    "${widget.busName}停車中",
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
                                  StartDriveModal(busName: widget.busName),
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
