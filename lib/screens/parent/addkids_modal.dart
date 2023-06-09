import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/parent/nfc_scan_modal.dart';
import 'package:piyomiru_application/screens/parent/write_nfc_in_flutter.dart';

//////////package:piyomiru_application/screens/parent/family_lsit.dartから呼ばれています//////////

class AddkidsModal extends StatefulWidget {
  AddkidsModal({Key? key, required this.familyId}) : super(key: key);
  final int familyId;

  @override
  State<AddkidsModal> createState() => _AddkidsModalState();
}

class _AddkidsModalState extends State<AddkidsModal> {
  String name = '';
  List<RecordEditor> _records = [];
  bool _hasClosedWriteDialog = false;
  int userId = 0;

  final _audio = AudioCache();
  final TextEditingController mediaTypeController = TextEditingController();
  final TextEditingController payloadController = TextEditingController();

  void initState() {
    setState(() {
      _records.add(RecordEditor());
    });
    super.initState();
  }

  void _write(BuildContext context) async {
    print("書き込みメソッド呼び出されました");

    List<NdefRecord> records = _records.map((record) {
      print("受け取れたID:${userId}");
      return NdefRecord.createMime(payloadController.text, Uint8List.fromList(userId.toString().codeUnits));
    }).toList();

    // void _write(BuildContext context) async {
    //   print("書き込みメソッド呼び出されました");

    //   List<NDEFRecord> records = _records.map((record) {
    //     print("メディアの内容:${mediaTypeController.text}");
    //     print("受け取れたID:${userId}");
    //     return NDEFRecord.type(
    //       userId.toString(),
    //       payloadController.text,
    //     );
    //   }).toList();

    print("レコードの内容：$records");

    // NDEFMessage message = NDEFMessage.withRecords(records);

    // Show dialog on Android (iOS has it's own one)
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            NfcScanModal(kidName: name, success: false),
      );
    }

    // Write to the first tag scanned

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final ndef = Ndef.from(tag);
      if (ndef == null) {
        NfcManager.instance.stopSession();
      }
      try {
        final message = NdefMessage(records);
        await ndef?.write(message);
        NfcManager.instance.stopSession();
        if (!_hasClosedWriteDialog) {
          _audio.play('piyo.mov');
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                NfcScanModal(kidName: name, success: true),
          );
        }
      } catch (e) {
        NfcManager.instance.stopSession(errorMessage: "書き込みに失敗しました");
      }
    });
    // await NFC.writeNDEF(message).first;
    // if (!_hasClosedWriteDialog) {
    //   _audio.play('piyo.mov');
    //   showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) =>
    //         NfcScanModal(kidName: name, success: true),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    //final controller = TextEditingController();

    return SingleChildScrollView(
      child: Dialog(
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.only(
          bottom: 250,
          top: 250,
          left: 28,
          right: 28,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 260,
          width: 350,
          decoration: BoxDecoration(
            color: Color(0XFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: kSubBackgroundColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                textAlign: TextAlign.center,
                "お子様の名前を\n入力してください",
                style: TextStyle(
                    fontSize: 22, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: kInputColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListView(children: <Widget>[
                  for (var record in _records)
                    Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          //controller: record.mediaTypeController,
                          style: const TextStyle(
                            fontSize: 24,
                            color: kFontColor,
                          ),
                          cursorColor: kFontColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 24),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    )
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 64,
                          width: 120,
                          decoration: BoxDecoration(
                            color: kCanselColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Text(
                          "キャンセル",
                          style: TextStyle(
                              fontSize: 18,
                              color: kFontColor,
                              fontFamily: 'KiwiMaru-R'),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //追加処理
                      print("追加ボタンタップ");

                      if (name.isNotEmpty) {
                        Users()
                            .postkidsUser(name, widget.familyId)
                            .then((value) => {
                                  print("id: $value"),
                                  setState(() {
                                    userId = value;
                                    _write(context);
                                  }),
                                });

                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) {
                        //   return WriteExampleScreen();
                        // }));

                        // showDialog(
                        //     barrierDismissible: false,
                        //     context: context,
                        //     builder: (BuildContext context) => NfcScanModal());
                      } else {
                        Navigator.pop(context);
                        //print("false");
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 64,
                          width: 120,
                          decoration: BoxDecoration(
                            color: kStartColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Text(
                          "追加",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0XFFFFFFFF),
                              fontFamily: 'KiwiMaru-R'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
