import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/operation.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/actionbutton.dart';

import 'package:piyomiru_application/components/app_sub_button.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';

import 'package:piyomiru_application/screens/driver/nfc/nfc_scan_m.dart';

import 'package:piyomiru_application/screens/driver/passengers_kids/passengers_list_screen.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';

import 'package:piyomiru_application/screens/parent/nfc_scan_modal.dart';
import 'package:piyomiru_application/screens/setting_screen.dart';

//バス運行中画面
class OperationScreen extends ConsumerStatefulWidget {
  OperationScreen(
      {Key? key,
      required this.busName,
      required this.operationId,
      required this.setoff})
      : super(key: key);

  final String busName;
  final int operationId;
  final bool setoff;
  @override
  _OperationScreenState createState() => _OperationScreenState();
}

class _OperationScreenState extends ConsumerState<OperationScreen> {
  StreamSubscription<NDEFMessage>? _stream;

  var idList;
  var kidsList;
  var nameList;
  var busId;

  int userId = 0;

  void _startScanning() {
    setState(() {
      _stream = NFC
          .readNDEF(alertMessage: "Custom message with readNDEF#alertMessage")
          .listen((NDEFMessage message) {
        if (message.isEmpty) {
          print("Read empty NDEF message");
          return;
        }
        print("Read NDEF message with ${message.records.length} records");
        for (NDEFRecord record in message.records) {
          setState(() {
            userId = record.payload as int;
          });
          print(
              "Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type '${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");
        }
      }, onError: (error) {
        setState(() {
          _stream = null;
        });
        if (error is NFCUserCanceledSessionException) {
          print("user canceled");
        } else if (error is NFCSessionTimeoutException) {
          print("session timed out");
        } else {
          print("error: $error");
        }
      }, onDone: () {
        setState(() {
          _stream = null;
        });
      });
    });
  }

  void _stopScanning() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  void _toggleScan() {
    if (_stream == null) {
      _startScanning();
      Passenger().getAllPassenger(widget.operationId).then((passengerList) => {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => NfcScanSampModal(
                  passengers: passengerList,
                  operationId: widget.operationId,
                  success: false),
            )
          });
    } else {
      _stopScanning();
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    Buses().getIdBuses(widget.busName).then((value) => {
          setState(() {
            busId = value;
          }),
        });
    super.initState();
  }

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

          title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeDriverScreen()),
              );
            },
            child: const Text(
              "PiyoMiru",
              style: TextStyle(
                  color: kTitleColor, fontSize: 36, fontFamily: 'Rajdhani-B'),
            ),
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
                            builder: (context) => RegisterkidsScreen()),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.busName,
                            style: const TextStyle(
                              fontSize: 40,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'KiwiMaru-M', color: kFontColor,
                            ),
                          ),
                          Text(
                            "運行中. . .",
                            style: const TextStyle(
                              fontSize: 40,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'KiwiMaru-M', color: kFontColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: deviceH * 0.04),
                      Image.asset('assets/images/bus_start_home.png'),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              height: deviceH,
              width: deviceW,
              bottom: -deviceH * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        var f = Passenger().getAllPassenger(widget.operationId);

                        f.then((value) => {
                              idList = value,
                              print(idList),
                              //nameList[0] = Users().getUser(1),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PassengerListScreen(
                                          drive: true,
                                          busId: busId,
                                          operationId: widget.operationId,
                                          busName: widget.busName,
                                          setoff: widget.setoff,
                                        )),
                              ),
                            });
                      });
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              //alignment: Alignment.center,
                              width: 145,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: kSubBackgroundColor,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            Text(
                              "乗車中園児確認",
                              style: const TextStyle(
                                fontSize: 18,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'KiwiMaru-M', color: kFontColor,
                              ),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/tulip_red.png'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //押した時の処理

                      Passenger()
                          .getAllPassenger(widget.operationId)
                          .then((passengerList) => {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      NfcScanSampModal(
                                          passengers: passengerList,
                                          operationId: widget.operationId,
                                          success: false),
                                )
                              });

                      // showDialog(
                      //   barrierDismissible: true,
                      //   context: context,
                      //   builder: (BuildContext context) => NfcScanModal(
                      //     passengers: idList,
                      //     operationId: operationId,
                      //   ),
                      // );
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              //alignment: Alignment.center,
                              width: 145,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: kSubBackgroundColor,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            Text(
                              "NFCスキャナー",
                              style: const TextStyle(
                                fontSize: 18,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'KiwiMaru-M', color: kFontColor,
                              ),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/tulip_yellow.png'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
