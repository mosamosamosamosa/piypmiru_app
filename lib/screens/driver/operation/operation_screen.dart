import 'package:flutter/material.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/app_sub_button.dart';
import 'package:piyomiru_application/constants.dart';

import 'package:piyomiru_application/screens/driver/home/logout_modal.dart';
import 'package:piyomiru_application/screens/driver/nfc/nfc_scan_modal.dart';
import 'package:piyomiru_application/screens/driver/nfc/nfc_success_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/passengers_list_screen.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_modal.dart';

//バス運行中画面
class OperationScreen extends StatefulWidget {
  OperationScreen({Key? key}) : super(key: key);

  @override
  _OperationScreenState createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  var idList;
  var kidsList;
  var nameList;

  @override
  Widget build(BuildContext context) {
    //画面のサイズ取得
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
          //影消す
          elevation: 0.0,

          actions: [
            GestureDetector(
              onTap: () {
                var f = Users().getkidsAllUsers();

                f.then((value) => {
                      kidsList = value,
                      print(kidsList),
                      //nameList[0] = Users().getUser(1),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterkidsScreen(regiKids: kidsList)),
                      ),
                    });
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
                        "運行中. . .",
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
                      onTap: () {
                        setState(() {
                          var f = Passenger().getAllPassenger();

                          f.then((value) => {
                                idList = value,
                                print(idList),
                                //nameList[0] = Users().getUser(1),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PassengerListScreen(
                                          drive: true, passenger: idList)),
                                ),
                              });
                        });
                      },
                      child:
                          AppSubButton(text: "乗車中園児確認", image: "chulip.png")),
                  GestureDetector(
                      onTap: () {
                        //押した時の処理
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) =>
                              NfcScanModal(passengers: idList),
                        );
                      },
                      child:
                          AppSubButton(text: "NFCスキャナー", image: "hiyoko.png")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
