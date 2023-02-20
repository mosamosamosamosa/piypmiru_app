import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/operation.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/bus_iten_family.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/parent/family_comp_modal.dart';
import 'package:piyomiru_application/screens/parent/nfc_scan_modal.dart';
import 'package:piyomiru_application/screens/parent/write_nfc_in_flutter.dart';

class FamilyModal extends StatefulWidget {
  FamilyModal(
      {Key? key, required this.image, required this.name, required this.index})
      : super(key: key);

  final String image;
  final String name;
  final int index;

  @override
  State<FamilyModal> createState() => _FamilyModalState();
}

class _FamilyModalState extends State<FamilyModal> {
  List<bool> _selected = List.generate(3, (i) => false);
  String busName = '';
  bool select = false;
  String name = '';
  StreamSubscription<NDEFMessage>? _stream;
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
              const Text(
                textAlign: TextAlign.center,
                "バスを選択してください",
                style: TextStyle(
                    fontSize: 22, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              SizedBox(
                height: 100,
                width: 330,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: busList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selected = List.generate(3, (i) => false);
                              _selected[index] = true;
                              busName = busList[index];
                            });
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              _selected[index]
                                  ? Container(
                                      height: 76,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3, color: Color(0xFF90D7EC)),
                                        borderRadius: BorderRadius.circular(10),
                                        color: kBusItemColor,
                                      ),
                                      child: Text(
                                        busList[index],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kFontColor,
                                            fontFamily: 'KiwiMaru-R'),
                                      ),
                                    )
                                  : Container(
                                      height: 76,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kBusItemColor,
                                      ),
                                      child: Text(
                                        busList[index],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: kFontColor,
                                            fontFamily: 'KiwiMaru-R'),
                                      ),
                                    ),
                              Image.asset('assets/images/bus_sel.png'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
                          height: 50,
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
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => FamilyCompModal(
                                busName: busName,
                                image: widget.image,
                                name: widget.name,
                                index: widget.index,
                              ));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: kStartColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Text(
                          "決定",
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
