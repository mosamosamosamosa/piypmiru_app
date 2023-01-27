import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/addlistitem.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:intl/intl.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/addpass_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/completion_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/nostop_drive_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/stop_drive_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/addlist_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_screen.dart';

class PassengerListScreen extends StatefulWidget {
  PassengerListScreen(
      {Key? key,
      required this.drive,
      required this.passenger,
      required this.busId,
      required this.operationId})
      : super(key: key);

  final bool drive;
  var passenger;
  final int busId;
  final int operationId;
  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _PassengerListScreenState createState() => _PassengerListScreenState();
}

class _PassengerListScreenState extends State<PassengerListScreen> {
  late bool pushable;

  bool editable = false;
  int edit_flag = 0;
  String action = "編集";
  var userId;
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    DateFormat outputFormat = DateFormat('yyyy/MM/dd H:m');

    setState(() {
      if (widget.passenger.isEmpty == false) {
        pushable = false;
      } else {
        pushable = true;
      }
    });

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTitleColor),
        toolbarHeight: deviceH * 0.1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/images/backmark.png')),
        title: const Text(
          "乗車中園児一覧",
          style: TextStyle(
              color: kFontColor, fontSize: 26, fontFamily: 'KiwiMaru-R'),
        ),
        backgroundColor: kSubBackgroundColor,
        //影消す
        elevation: 0.0,
        actions: [
          GestureDetector(
              onTap: () {
                if (edit_flag % 2 == 0) {
                  setState(() {
                    editable = true;
                    action = "完了";
                    edit_flag++;
                  });
                } else {
                  setState(() {
                    editable = false;
                    action = "編集";
                    edit_flag++;
                  });
                }
              },
              child: ActionButton(text: action, img: 'hiyoko_pencil.png')),
        ],
      ),
      body: Stack(
        children: [
          widget.passenger.isEmpty == false
              ? SizedBox(
                  height: deviceH * 0.67,
                  width: deviceW,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: deviceH * 0.06),
                    itemCount: (widget.passenger).length + 1,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      if (index == (widget.passenger).length) {
                        return GestureDetector(
                            onTap: () async {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AddpassModal(
                                        operationId: widget.operationId,
                                      )).then((value) => {
                                    Passenger()
                                        .getAllPassenger(widget.operationId)
                                        .then((value) => {
                                              setState(() {
                                                widget.passenger = value;
                                                print(widget.passenger);
                                              }),
                                            }),
                                  });
                            },
                            child: const Addlistitem());
                      }

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Listitem(
                              userId: widget.passenger[index]['id'],
                              editable: editable,
                              image: passengers_list[index].image,
                              //passenger
                              name: widget.passenger[index]['name'],
                              ride: true,
                              datetime: outputFormat.format(DateTime.parse(
                                  widget.passenger[index]['created']))),
                          editable
                              ? Positioned(
                                  right: 8,
                                  top: -10,
                                  child: GestureDetector(
                                      onTap: () async {
                                        var g = Passenger().getnamePassenger(
                                            widget.passenger[index]['name']);
                                        g.then((value) => {
                                              userId = value,
                                              print(userId),
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        CompletionModal(
                                                  passId: userId,
                                                  userId: widget
                                                      .passenger[index]['id'],
                                                  name: widget.passenger[index]
                                                      ['name'],
                                                  image: passengers_list[index]
                                                      .image,
                                                  operationId:
                                                      widget.operationId,
                                                ),
                                              ).then((value) => {
                                                    Passenger()
                                                        .getAllPassenger(
                                                            widget.operationId)
                                                        .then((value) => {
                                                              setState(() {
                                                                widget.passenger =
                                                                    value;
                                                              }),
                                                            })
                                                  })
                                            });
                                      },
                                      child: Image.asset(
                                          'assets/images/minus.png')))
                              : Container()
                        ],
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: deviceH,
                  width: deviceW,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: deviceH * 0.12),
                      const Text(
                        "現在乗車中の園児はいません",
                        style: TextStyle(
                            color: kFontColor,
                            fontSize: 20,
                            fontFamily: 'KiwiMaru-L'),
                      ),
                      SizedBox(height: deviceH * 0.12),
                      Image.asset('assets/images/kids.png'),
                    ],
                  ),
                ),
          Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: deviceH * 0.08),
              child: GestureDetector(
                onTap: () {
                  if (pushable) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) =>
                          StopDriveModal(busId: widget.busId),
                    );
                  } else {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => NostopDriveModal(),
                    );
                  }
                },
                child: AppButton(
                  text: "運転終了",
                  start: false,
                  pushable: pushable,
                ),
              )),
        ],
      ),
    );
  }
}
