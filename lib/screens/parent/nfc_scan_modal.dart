import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
//import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/nfc/nfc_scan.dart';
import 'package:piyomiru_application/screens/driver/nfc/nfc_success_modal.dart';

//////////package:piyomiru_application/screens/parent/addkids_modal.dartから呼ばれています！//////////

class NfcScanModal extends StatefulWidget {
  const NfcScanModal({
    Key? key,
  }) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _NfcScanModalState createState() => _NfcScanModalState();
}

class _NfcScanModalState extends State<NfcScanModal> {
  bool _supportsNFC = false;
  bool _reading = false;
  bool success = false;
  late StreamSubscription<NDEFMessage> _stream;
  String enId = '';
  //var enId;

  @override
  void initState() {
    super.initState();
    // Check if the device supports NFC reading
    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    // if (!_supportsNFC) {
    //   return Dialog(//////////<このデバイスはnfcに対応していません>のダイアログ//////////
    //     alignment: Alignment.center,
    //     insetPadding: const EdgeInsets.only(
    //       bottom: 240,
    //       top: 240,
    //       left: 24,
    //       right: 24,
    //     ),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Container(
    //           height: deviceH,
    //           width: deviceW,
    //           decoration: BoxDecoration(
    //             color: Color(0XFFFFFFFF),
    //             borderRadius: BorderRadius.circular(20),
    //             border: Border.all(width: 3, color: kSubBackgroundColor),
    //           ),
    //         ),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             //SizedBox(height: 0),
    //             const Text(
    //               "読み取りに失敗しました",
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                   fontSize: 24,
    //                   color: kFontColor,
    //                   fontFamily: 'KiwiMaru-R'),
    //             ),
    //             Image.asset('assets/images/hiyoko_batsu.png'),
    //             GestureDetector(
    //               onTap: () {
    //                 //キャンセル処理
    //                 Navigator.pop(context);
    //               },
    //               child: Stack(
    //                 alignment: Alignment.center,
    //                 children: [
    //                   Container(
    //                     height: 50,
    //                     width: 120,
    //                     decoration: BoxDecoration(
    //                       color: kCanselColor,
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                   ),
    //                   const Text("閉じる",
    //                       style: TextStyle(
    //                           fontSize: 18,
    //                           color: kFontColor,
    //                           fontFamily: 'KiwiMaru-R')),
    //                 ],
    //               ),
    //             )
    //           ],
    //         )
    //       ],
    //     ),
    //   );
    // }
    return Stack(
      children: [
        Positioned(
            top: 210,
            left: 35,
            child: Image.asset('assets/images/hiyoko_anzen.png')),
        Dialog(//////////<お子様の名前を入力してください>のダイアログ//////////
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
                  success//////////スキャン成功したら表示//////////
                      ? const Text(
                    "〇〇　〇〇さん\n登録完了！",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: kFontColor,
                    ),
                  )
                      : const Text(
                    "お子様のNFCカードを\nスキャンしてください",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: kFontColor,
                        fontFamily: 'KiwiMaru-R'),
                  ),
                  success//////////スキャン成功したら表示(閉じるボタン)//////////
                      ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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
                        const Text(
                            "閉じる",
                            style: TextStyle(
                                fontSize: 18, color: kFontColor)
                        ),
                      ],
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      //下動くけどなぜか値取ってこれない
                      //NfcScan().nfcRead();

                      // var f = NfcScan().nfcRead();

                      // f.then((value) => {
                      //       enId = value,
                      //       print(enId),
                      //     });
                      //NFCスキャン
                      if (_reading) {
                        _stream.cancel();

                        _reading = true;

                        showDialog<void>(//////////<読み取りに失敗しました>のダイアログ//////////
                            context: context,
                            builder: (_) {

                              return Dialog(
                                alignment: Alignment.center,
                                insetPadding: const EdgeInsets.only(
                                  bottom: 240,
                                  top: 240,
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
                                        //SizedBox(height: 0),
                                        const Text(
                                          "読み取りに失敗しました",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: kFontColor,
                                              fontFamily: 'KiwiMaru-R'),
                                        ),
                                        Image.asset('assets/images/hiyoko_batsu.png'),
                                        GestureDetector(
                                          onTap: () {
                                            //キャンセル処理(三回戻ってます。)
                                            Navigator.pop(context);
                                            Navigator.pop(context);
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
                                              const Text("閉じる",
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
                              );

                            });

                      } else {
                        _reading = true;
                        // Start reading using NFC.readNDEF()
                        _stream = NFC
                            .readNDEF(
                          once: true,
                          throwOnUserCancel: false,
                        )
                            .listen((NDEFMessage message) {
                          enId = message.payload;
                        }, onError: (e) {
                          // Check error handling guide below
                        });
                      }
                      if (enId.isNotEmpty) {
                        print("$enId：成功");
                        setState(() {
                          success = true;
                        });
                        // showDialog(
                        //   barrierDismissible: false,
                        //   context: context,
                        //   builder: (BuildContext context) =>
                        //       NfcSuccessModal(),
                        // );
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
                        const Text("スキャン",
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
