import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/operation.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/compbutton.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/driver/home/add_bus_modal.dart';
import 'package:piyomiru_application/screens/driver/home/delete_bus_modal.dart';

import 'package:piyomiru_application/screens/driver/operation/operation_screen.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/screens/setting_screen.dart';

class HomeDriverScreen extends ConsumerStatefulWidget {
  HomeDriverScreen({
    Key? key,
  }) : super(key: key);

  List<String> busList = [];
  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _HomeDriverScreenState createState() => _HomeDriverScreenState();
}

class _HomeDriverScreenState extends ConsumerState<HomeDriverScreen> {
  int? selectedId;
  bool del = false;
  var kidsList;
  int id = 0;
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

  @override
  Widget build(BuildContext context) {
    print(widget.busList);
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    final setoffState = ref.watch(setoffProvider);

    String group_name = groups_list[0].name;

    final opeState = ref.watch(opeProvider);

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
              //なぜかここだけimportしても使えない

              var f = Users().getkidsAllUsers();

              f.then((value) => {
                    kidsList = value,
                    print(kidsList),
                    //nameList[0] = Users().getUser(1),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterkidsScreen()),
                    ),
                  });
            },
            child: const ActionButton(
              text: "園児",
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
              text: "設定",
              img: "setting.png",
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
              const SizedBox(height: 18),
              del
                  ? GestureDetector(
                      onTap: () async {
                        setState(() {
                          del = false;
                        });
                      },
                      child: const Compbutton())
                  : Container(),
              del ? SizedBox(height: 18) : SizedBox(height: 48),
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
                    widget.busList.length + 1,
                    (index) => GestureDetector(
                      onLongPress: () {
                        setState(() {
                          del = true;
                        });
                      },
                      onTap: () {
                        if (!statusList[index]) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartDriveScreen(
                                      busName: widget.busList[index],
                                    )),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OperationScreen(
                                    busName: widget.busList[index],
                                    operationId: opeState,
                                    setoff: setoffState)),
                          );
                        }

                        // Buses()
                        //     .getIdBuses(widget.busList[index])
                        //     .then((value) => {
                        //           print(value),
                        //           Operation()
                        //               .getStatusOperation(value)
                        //               .then((value) => {
                        //                     setState(() {
                        //                       standardEasing = value;
                        //                       if (!value) {
                        //                         Navigator.push(
                        //                           context,
                        //                           MaterialPageRoute(
                        //                               builder: (context) =>
                        //                                   StartDriveScreen(
                        //                                     busName: widget
                        //                                         .busList[index],
                        //                                   )),
                        //                         );
                        //                       } else {
                        //                         Navigator.push(
                        //                           context,
                        //                           MaterialPageRoute(
                        //                               builder: (context) =>
                        //                                   OperationScreen(
                        //                                       busName: widget
                        //                                               .busList[
                        //                                           index])),
                        //                         );
                        //                       }
                        //    })
                        //       })
                        //  });
                      },
                      child: index == widget.busList.length
                          ? GestureDetector(
                              onTap: () async {
                                setState(() {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AddBusModal());
                                });
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
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
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
                                                  'assets/images/bus_drive.png'),
                                            ])
                                          : Container(
                                              alignment: Alignment.bottomCenter,
                                              child: Image.asset(
                                                  'assets/images/bus_stop.png'),
                                            ),
                                      Positioned(
                                        top: -14,
                                        right: -17,
                                        child: del
                                            ? GestureDetector(
                                                onTap: () async {
                                                  //バスのIDを名前から取得
                                                  setState(() {
                                                    var f = Buses().getIdBuses(
                                                        widget.busList[index]);

                                                    f.then((value) => {
                                                          id = value,
                                                          print(id),
                                                          //nameList[0] = Users().getUser(1),
                                                          showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  DeleteBusModal(
                                                                    name: widget
                                                                            .busList[
                                                                        index],
                                                                    id: id,
                                                                  ))
                                                        });
                                                  });
                                                },
                                                child: statusList[index]
                                                    ? Container()
                                                    : Image.asset(
                                                        'assets/images/batsu.png'),
                                              )
                                            : Container(),
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
