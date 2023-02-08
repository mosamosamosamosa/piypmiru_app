import 'package:flutter/material.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/operation.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/driver/home/add_bus_modal.dart';

import 'package:piyomiru_application/screens/driver/operation/operation_screen.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/driving_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:piyomiru_application/screens/parent/family_list.dart';
import 'package:piyomiru_application/screens/parent/operation_parent_screen.dart';
import 'package:piyomiru_application/screens/parent/passengers_parent_screen.dart';
import 'package:piyomiru_application/screens/parent/stop_parent_screen.dart';
import 'package:piyomiru_application/screens/setting_screen.dart';

class HomeParentScreen extends StatefulWidget {
  HomeParentScreen({Key? key, required this.familyId}) : super(key: key);

  List<String> busList = [];
  final int familyId;

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _HomeParentScreenState createState() => _HomeParentScreenState();
}

class _HomeParentScreenState extends State<HomeParentScreen> {
  List<bool> statusList = [];

  @override
  void initState() {
    // TODO: implement initState

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
                          widget.busList.add(element);
                        })
                      })
                });
          }),
        });
    super.initState();
  }

  int? selectedId;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

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
              color: kTitleColor, fontSize: 36, fontFamily: 'Rajdhani-B'),
        ),
        backgroundColor: kSubBackgroundColor,
        //影消す
        elevation: 0.0,

        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FamilyListScreen(familyId: widget.familyId)),
              );
            },
            child: const ActionButton(
              text: "家族",
              img: "bear.png",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
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
                '--ぴよみる幼稚園--',
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
                    widget.busList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (statusList[index]) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OperationParentScreen(
                                        busName: widget.busList[index],
                                      )),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StopParentScreen(
                                        busName: widget.busList[index],
                                      )),
                            );
                          }
                        });
                      },
                      child: Container(
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
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    widget.busList[index],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'KiwiMaru-R',
                                        color: kFontColor),
                                  ),
                                ),
                                statusList[index]
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
