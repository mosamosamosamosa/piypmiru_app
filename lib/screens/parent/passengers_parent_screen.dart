import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/addlistitem.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:intl/intl.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/completion_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/stop_drive_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/addlist_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_screen.dart';

class PassengerParentScreen extends StatefulWidget {
  const PassengerParentScreen({Key? key, required this.operationId})
      : super(key: key);

  final int operationId;

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _PassengerParentScreenState createState() => _PassengerParentScreenState();
}

class _PassengerParentScreenState extends State<PassengerParentScreen> {
  var passengerList;

  @override
  void initState() {
    // TODO: implement initState
    Passenger().getAllPassenger(widget.operationId).then((value) => {
          setState(() {
            if (value == null) {
              print("nullです");
              passengerList = 0;
            } else {
              passengerList = value;
              print('乗客:$passengerList');
            }
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    DateFormat outputFormat = DateFormat('yyyy/MM/dd H:m');

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
      ),
      body: Stack(
        children: [
          passengerList == null || passengerList == 0
              ? SizedBox(
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
                )
              : SizedBox(
                  height: deviceH,
                  width: deviceW,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: deviceH * 0.05),
                    itemCount: passengerList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Listitem(
                          userId: 1, //仮
                          editable: false,
                          image: passengers_list[index].image,
                          name: passengerList[index]['name'],
                          ride: true,
                          datetime: outputFormat.format(DateTime.now()));
                    },
                  ),
                )
        ],
      ),
    );
  }
}
