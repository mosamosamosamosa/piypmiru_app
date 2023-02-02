import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
//import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/nfc/nfc_scan.dart';
import 'package:piyomiru_application/screens/driver/nfc/nfc_success_modal.dart';

class NfcScanSampModal extends StatefulWidget {
  NfcScanSampModal(
      {Key? key,
      required this.passengers,
      required this.operationId,
      required this.success})
      : super(key: key);

  var passengers;
  int operationId;
  bool success;
  // createState()　で"State"（Stateを継承したクラス）を返す

  @override
  _NfcScanSampModalState createState() => _NfcScanSampModalState();
}

class _NfcScanSampModalState extends State<NfcScanSampModal> {
  StreamSubscription<NDEFMessage>? _stream;
  bool _supportsNFC = false;
  bool _reading = false;

  int passId = 0;

  String name = '';
  String pass = '乗車';
  int userId = 0;
  //var enId;

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
            print("id:${record.data}");
            userId = int.parse(record.data);
            Users().getUser(userId).then((value) => {
                  setState(() {
                    name = value;

                    widget.success = true;
                  })
                });
          });
          print(name);
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
          print("終了");
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

  @override
  void initState() {
    if (_stream == null) {
      _startScanning();
    } else {
      _stopScanning();
    }
    super.initState();
    // Check if the device supports NFC reading
  }

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
            top: 210,
            left: 35,
            child: Image.asset('assets/images/hiyoko_anzen.png')),
        Dialog(
          alignment: Alignment.center,
          insetPadding: const EdgeInsets.only(
            bottom: 280,
            top: 280,
            left: 24,
            right: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: deviceH,
                width: deviceW,
                decoration: BoxDecoration(
                  color: Color(0XFFFFFFFF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 3, color: kSubBackgroundColor),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.success
                      ? Text(
                          "$nameさん\n$pass完了！",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: kFontColor,
                          ),
                        )
                      : const Text(
                          "NFCカードを\nスキャンしてください",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              color: kFontColor,
                              fontFamily: 'KiwiMaru-R'),
                        ),
                  widget.success
                      ? GestureDetector(
                          onTap: () {
                            if ((widget.passengers) != 0 &&
                                widget.passengers != null) {
                              print(widget.passengers);
                              print("乗客リストいます");
                              print(userId);
                              Passenger()
                                  .getpassIdPassenger(
                                      userId, widget.operationId)
                                  .then((value) => {
                                        setState(() {
                                          passId = value;
                                        }),
                                        if (passId == 0)
                                          {
                                            print("乗車OK"),
                                            setState(() {
                                              pass = '乗車';
                                            }),
                                            print("new data"),
                                            Passenger()
                                                .postPassenger(
                                                    userId, widget.operationId)
                                                .then((value) =>
                                                    {Navigator.pop(context)})
                                          }
                                        else
                                          {
                                            print("降車OK"),
                                            setState(() {
                                              pass = '降車';
                                            }),
                                            print("update data"),
                                            Passenger()
                                                .putPassenger(passId, userId,
                                                    widget.operationId)
                                                .then((value) =>
                                                    {Navigator.pop(context)})
                                          }
                                      });
                            } else {
                              print("乗車２OK:${widget.operationId}");
                              setState(() {
                                pass = '乗車';
                              });
                              Passenger()
                                  .postPassenger(userId, widget.operationId)
                                  .then((value) => {Navigator.pop(context)});
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: kCanselColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const Text("閉じる",
                                  style: TextStyle(
                                      fontSize: 18, color: kFontColor)),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: kCanselColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const Text("キャンセル",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: kFontColor,
                                      fontFamily: 'KiwiMaru-R')),
                            ],
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
