import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/addlistitem.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:intl/intl.dart';
import 'package:piyomiru_application/screens/home/passengers_kids/stop_drive_modal.dart';
import 'package:piyomiru_application/screens/home/register_kids/addlist_modal.dart';
import 'package:piyomiru_application/screens/home/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/home/start_drive/start_drive_screen.dart';

class PassengerListScreen extends StatefulWidget {
  const PassengerListScreen({
    Key? key,
  }) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _PassengerListScreenState createState() => _PassengerListScreenState();
}

class _PassengerListScreenState extends State<PassengerListScreen> {
  late bool pushable;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    DateFormat outputFormat = DateFormat('yyyy/MM/dd H:m');

    setState(() {
      if (passengers_list.isEmpty == false) {
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
              color: kFontColor,
              fontSize: 26,
            ),
          ),
          backgroundColor: kSubBackgroundColor,
          //影消す
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterkidsScreen()),
                );
              },
              child: const ActionButton(
                text: "編集する",
                img: "hiyoko_pencil.png",
              ),
            ),
          ]),
      body: Stack(
        children: [
          passengers_list.isEmpty == false
              ? SizedBox(
                  height: deviceH * 0.65,
                  width: deviceW,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: deviceH * 0.05),
                    itemCount: passengers_list.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      if (index == passengers_list.length) {
                        return GestureDetector(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    AddlistModal(),
                              );
                            },
                            child: const Addlistitem());
                      }

                      return Listitem(
                          image: passengers_list[index].image,
                          name: passengers_list[index].name,
                          datetime: outputFormat.format(DateTime.now()));
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
                        ),
                      ),
                      SizedBox(height: deviceH * 0.12),
                      Image.asset('assets/images/kids.png'),
                    ],
                  ),
                ),
          Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: deviceH * 0.1),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => StopDriveModal(),
                  );
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
