import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:piyomiru_application/screens/home/add_bus_modal.dart';

import 'package:piyomiru_application/screens/home/logout_modal.dart';
import 'package:piyomiru_application/screens/home/operation/operation_screen.dart';
import 'package:piyomiru_application/screens/home/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/home/start_drive/driving_screen.dart';
import 'package:piyomiru_application/screens/home/start_drive/start_drive_screen.dart';
import 'package:dotted_border/dotted_border.dart';

class HomeDriverScreen extends StatefulWidget {
  const HomeDriverScreen({
    Key? key,
  }) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _HomeDriverScreenState createState() => _HomeDriverScreenState();
}

class _HomeDriverScreenState extends State<HomeDriverScreen> {
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    String group_name = groups_list[0].name;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: deviceH * 0.1,
        centerTitle: false,

        title: const Text(
          "PiyoMiru",
          style: TextStyle(
            color: kTitleColor,
            fontSize: 36,
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
              text: "園児",
              img: "bear.png",
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => LogoutModal(),
              );
            },
            child: const ActionButton(
              text: "ログアウト",
              img: "frog.png",
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/background.png')),
          Column(
            children: [
              SizedBox(height: deviceH * 1 / 16),
              Text(
                '--$group_name--',
                style: TextStyle(
                    fontSize: 31, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              Container(
                height: deviceH * 0.7,
                width: deviceW,
                child: GridView.count(
                  padding: const EdgeInsets.all(25),
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 28,
                  crossAxisSpacing: 28,
                  crossAxisCount: 2,
                  children: List.generate(
                    buses_list.length + 1,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (operations_list[index].start == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartDriveScreen()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OperationScreen()),
                            );
                          }
                        });
                      },
                      child: index == buses_list.length
                          ? GestureDetector(
                              onTap: () async {
                                String name = await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AddBusModal(),
                                );
                                //リストに追加
                                print(name);
                              },
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                color: kFontColor.withOpacity(0.8),
                                dashPattern: const [
                                  24, // 点線を引く長さ
                                  12 //点線の溝の長さ
                                ],
                                radius: const Radius.circular(20),
                                strokeWidth: 5,
                                child: Container(
                                    height: 140,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        //color: kBusItemColor.withOpacity(0.8),
                                        color: kBusItemColor),
                                    child: Image.asset(
                                        "assets/images/plus_bus.png")),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kBusItemColor,
                              ),
                              child: Stack(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          buses_list[index].name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'KiwiMaru-R',
                                              color: kFontColor),
                                        ),
                                      ),
                                      operations_list[index].start == 1
                                          ? Column(children: [
                                              SizedBox(height: 16),
                                              Container(
                                                alignment: Alignment.topRight,
                                                child: Image.asset(
                                                    'assets/images/drive_mark.png'),
                                              ),
                                              SizedBox(height: 20),
                                              Image.asset(
                                                  'assets/images/bus_drive.png')
                                            ])
                                          : Container(
                                              alignment: Alignment.bottomCenter,
                                              child: Image.asset(
                                                  'assets/images/bus_stop.png'),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
