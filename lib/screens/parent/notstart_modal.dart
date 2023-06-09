import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/operation.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/bus_iten_family.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/parent/family_comp_modal.dart';
import 'package:piyomiru_application/screens/parent/nfc_scan_modal.dart';
import 'package:piyomiru_application/screens/parent/write_nfc_in_flutter.dart';

class NostartModal extends StatefulWidget {
  NostartModal({Key? key, required this.busName}) : super(key: key);

  final String busName;

  @override
  State<NostartModal> createState() => _NostartModalState();
}

class _NostartModalState extends State<NostartModal> {
  List<bool> _selected = List.generate(3, (i) => false);
  String busName = '';
  bool select = false;
  String name = '';
  // StreamSubscription<NDEFMessage>? _stream;
  List<RecordEditor> _records = [];
  bool _hasClosedWriteDialog = false;
  int userId = 0;

  final _audio = AudioCache();
  final TextEditingController mediaTypeController = TextEditingController();
  final TextEditingController payloadController = TextEditingController();

  List<bool> statusList = [];
  List<String> busList = [];
  List<String> sbusList = [];

  void initState() {
    Buses().getAllBuses().then((value) => {
          print(value),
          //widget.busList = value.cast<String>(),
          value.cast<String>().forEach((element) {
            Buses().getIdBuses(element).then((value) => {
                  print("get id buses"),
                  Operation().getStatusOperation(value).then((value) => {
                        print("get operation"),
                        setState(() {
                          statusList.add(value);
                          busList.add(element);
                          // for (int i = 0; i < busList.length; i++) {
                          //   if (statusList[i] = true) {
                          //     sbusList[i] == busList[i];
                          //   }
                          // }
                        })
                      })
                });
          }),
        });
    super.initState();
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
              Text(
                textAlign: TextAlign.center,
                "${widget.busName}はまだ運行していません",
                style: TextStyle(
                    fontSize: 22, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              Image.asset('assets/images/hiyoko_batsu.png'),
              GestureDetector(
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
                    const Text(
                      "もどる",
                      style: TextStyle(
                          fontSize: 18,
                          color: kFontColor,
                          fontFamily: 'KiwiMaru-R'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
