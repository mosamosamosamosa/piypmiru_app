import 'package:flutter/material.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/app_sub_button.dart';
import 'package:piyomiru_application/constants.dart';

import 'package:piyomiru_application/screens/driver/logout_modal.dart';
import 'package:piyomiru_application/screens/driver/nfc/nfc_scan_modal.dart';
import 'package:piyomiru_application/screens/driver/nfc/nfc_success_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/passengers_list_screen.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_modal.dart';

class OperationScreen extends StatelessWidget {
  OperationScreen({
    Key? key,
  }) : super(key: key);

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
          //?????????
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
                text: "??????",
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
                text: "???????????????",
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
                        "?????????. . .",
                        style: const TextStyle(
                          fontSize: 40,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'KiwiMaru-M', color: kFontColor,
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
                      onTap: () async {
                        var f = Passenger().getAllPassenger();
                        f.then((value) => {
                              debugPrint(value.toString()),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PassengerListScreen(drive: true)),
                              ),
                            });
                      },
                      child:
                          AppSubButton(text: "?????????????????????", image: "chulip.png")),
                  GestureDetector(
                      onTap: () {
                        //?????????????????????
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => NfcSuccessModal(),
                        );
                      },
                      child:
                          AppSubButton(text: "NFC???????????????", image: "hiyoko.png")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
