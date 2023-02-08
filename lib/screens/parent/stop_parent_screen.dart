import 'package:flutter/material.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/operation.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/app_sub_button.dart';
import 'package:piyomiru_application/components/passenger_button.dart';
import 'package:piyomiru_application/constants.dart';

import 'package:piyomiru_application/screens/driver/nfc/nfc_scan_modal.dart';
import 'package:piyomiru_application/screens/driver/nfc/nfc_success_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/passengers_list_screen.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_modal.dart';
import 'package:piyomiru_application/screens/parent/passengers_parent_screen.dart';
import 'package:piyomiru_application/screens/setting_screen.dart';

class StopParentScreen extends StatefulWidget {
  StopParentScreen({Key? key, required this.busName}) : super(key: key);

  final String busName;
  @override
  _StopParentScreenState createState() => _StopParentScreenState();
}

class _StopParentScreenState extends State<StopParentScreen> {
  var busId;
  var operationId;

  @override
  void initState() {
    // TODO: implement initState

    Buses().getIdBuses(widget.busName).then((value) => {
          setState(() {
            busId = value;
          }),
          Operation().getIdOperation(busId).then((value) => {
                setState(() {
                  operationId = value;
                }),
              })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: kStopBackgroundColors,
          stops: [
            0.0,
            0.8,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  MaterialPageRoute(builder: (context) => SettingScreen()),
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
                top: 120,
                right: 30,
                child: Image.asset('assets/images/star.png')),
            Positioned(
                top: 0,
                left: 100,
                child: Image.asset('assets/images/star.png')),
            Positioned(
                top: 40,
                right: 100,
                child: Image.asset('assets/images/star.png')),
            Positioned(
                top: 90,
                left: 120,
                child: Image.asset('assets/images/star.png')),
            Positioned(
                top: 120,
                left: 20,
                child: Image.asset('assets/images/star.png')),
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
                        "停止中. . .",
                        style: const TextStyle(
                          fontSize: 40,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'KiwiMaru-M', color: kFontColor,
                        ),
                      ),
                      SizedBox(height: deviceH * 0.04),
                      Image.asset('assets/images/bus_stop_home.png'),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              height: deviceH,
              width: deviceW,
              bottom: -deviceH * 0.3,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PassengerParentScreen(operationId: operationId)),
                    );
                  },
                  child: PassengerButton()),
            )
          ],
        ),
      ),
    );
  }
}
