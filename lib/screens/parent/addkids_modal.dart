import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/parent/nfc_scan_modal.dart';
import 'package:piyomiru_application/screens/parent/write_nfc_in_flutter.dart';

//////////package:piyomiru_application/screens/parent/family_lsit.dartから呼ばれています//////////

class RecordEditor {
  final TextEditingController mediaTypeController = TextEditingController();
  final TextEditingController payloadController = TextEditingController();
}

class AddkidsModal extends StatefulWidget {
  AddkidsModal({Key? key}) : super(key: key);

  @override
  State<AddkidsModal> createState() => _AddkidsModalState();
}

class _AddkidsModalState extends State<AddkidsModal> {
  String name = '';
  int userId = 0;
  StreamSubscription<NDEFMessage>? _stream;
  List<RecordEditor> _records = [];
  bool _hasClosedWriteDialog = false;

  void initState() {
    setState(() {
      _records.add(RecordEditor());
    });
    super.initState();
  }

  void _write(BuildContext context) async {
    List<NDEFRecord> records = _records.map((record) {
      print("メディアの内容:${record.mediaTypeController.text}");
      return NDEFRecord.type(
        record.mediaTypeController.text,
        record.payloadController.text,
      );
    }).toList();

    print("レコードの内容：$records");
    NDEFMessage message = NDEFMessage.withRecords(records);

    // Show dialog on Android (iOS has it's own one)
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Scan the tag you want to write to"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                _hasClosedWriteDialog = true;
                _stream?.cancel();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    // Write to the first tag scanned
    await NFC.writeNDEF(message).first;
    if (!_hasClosedWriteDialog) {
      Navigator.pop(context);
    }
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
                          controller: record.mediaTypeController,
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

                      if (name.isNotEmpty) {
                        _write(context);

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
