import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piyomiru_application/api/operation.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/addlistitem.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:intl/intl.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';
import 'package:piyomiru_application/screens/driver/operation/operation_screen.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/addpass_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/completion_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/nostop_drive_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/stop_drive_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/addlist_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_screen.dart';

class PassengerListScreen extends ConsumerStatefulWidget {
  PassengerListScreen(
      {Key? key,
      required this.busName,
      required this.drive,
      required this.busId,
      required this.operationId,
      required this.setoff})
      : super(key: key);

  final bool drive;
  final String busName;
  final int busId;
  final int operationId;
  final bool setoff;
  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _PassengerListScreenState createState() => _PassengerListScreenState();
}

class _PassengerListScreenState extends ConsumerState<PassengerListScreen> {
  late bool pushable;
  String text = '';

  bool editable = false;
  int edit_flag = 0;
  String action = "編集";
  var userId;

  int count = 0;
  var passengerList;

  @override
  void initState() {
    Passenger().getAllPassenger(widget.operationId).then((value) => {
          setState(() {
            if (value == null || value == 0) {
              print("nullです");
              passengerList = 0;
            } else {
              passengerList = value;
              print('乗客:$passengerList');
            }
          })
        });
    Operation().getCountOperation(widget.operationId).then((value) => {
          setState(() {
            print("取ってこれた値");
            print(widget.operationId);
            print(count);
            count = value;
          })
        });
    super.initState();
  }

  void _onReflesh() {
    Passenger().getAllPassenger(widget.operationId).then((value) => {
          setState(() {
            if (value == null || value == 0) {
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

//運転終了ボタン
  @override
  Widget build(BuildContext context) {
    final bus1State = ref.watch(bus1Provider);
    final bus2State = ref.watch(bus2Provider);
    final bus3State = ref.watch(bus3Provider);

    setState(() {
      if (passengerList == null || passengerList == 0) {
        pushable = true;
      } else {
        pushable = false;
      }
    });

    setState(() {
      if (widget.setoff == true) {
        // if (widget.busName == "1号車") {
        //   text = " / 出席園児：$bus1State人";
        // } else if (widget.busName == "2号車") {
        //   text = " / 出席園児：$bus2State人";
        // } else if (widget.busName == "3号車") {
        //   text = " / 出席園児：$bus3State人";
        // }
        print("この時点でのcount");
        print(count);
        text = " / 出席園児：$count人";
      } else {
        text = "";
      }
    });
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    final bus1Notifier = ref.watch(bus1Provider.notifier);
    final bus2Notifier = ref.watch(bus2Provider.notifier);
    final bus3Notifier = ref.watch(bus3Provider.notifier);

    //表示

    final familyState = ref.watch(familyProvider);

    final setoffState = ref.watch(setoffProvider);

    DateFormat outputFormat = DateFormat('yyyy/MM/dd H:m');

    final opeState = ref.watch(opeProvider);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTitleColor),
        toolbarHeight: deviceH * 0.1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OperationScreen(
                          busName: widget.busName,
                          operationId: opeState,
                          setoff: setoffState,
                        )),
              );
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
      body: CustomRefreshIndicator(
        onRefresh: () async {
          _onReflesh();
        },
        builder: MaterialIndicatorDelegate(
          builder: (context, controller) {
            return Image.asset('assets/images/hiyoko_anzen.png');
          },
        ),
        child: Stack(
          children: [
            passengerList == null || passengerList == 0
                ? SizedBox(
                    height: deviceH,
                    width: deviceW,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "乗車中園児：0人$text",
                          style: TextStyle(
                              color: kSubBackgroundColor,
                              fontSize: 18,
                              fontFamily: 'KiwiMaru-L'),
                        ),
                        SizedBox(height: deviceH * 0.11),
                        const Text(
                          "現在乗車中の園児はいません",
                          style: TextStyle(
                              color: kFontColor,
                              fontSize: 20,
                              fontFamily: 'KiwiMaru-L'),
                        ),
                        SizedBox(height: deviceH * 0.001),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => AddpassModal(
                                      operationId: widget.operationId,
                                      busId: widget.busId,
                                      busName: widget.busName,
                                    ));
                          },
                          child: const Text(
                            "+ 園児を追加する",
                            style: TextStyle(
                                color: kSubBackgroundColor,
                                fontSize: 18,
                                fontFamily: 'KiwiMaru-L'),
                          ),
                        ),
                        SizedBox(height: deviceH * 0.12),
                        Image.asset('assets/images/kids_trio.png'),
                      ],
                    ),
                  )
                : SizedBox(
                    height: deviceH * 0.67,
                    width: deviceW,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "乗車中園児：${passengerList.length}人$text",
                          style: TextStyle(
                              color: kSubBackgroundColor,
                              fontSize: 18,
                              fontFamily: 'KiwiMaru-L'),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              //padding: EdgeInsets.only(top: deviceH * 0.06),
                              itemCount: passengerList.length + 1,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                if (index == passengerList.length) {
                                  return GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AddpassModal(
                                                  operationId:
                                                      widget.operationId,
                                                  busId: widget.busId,
                                                  busName: widget.busName,
                                                ));
                                      },
                                      child: const Addlistitem());
                                }

                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Listitem(
                                        userId: passengerList[index]['id'],
                                        editable: editable,
                                        image: passengers_list[index].image,
                                        //passenger
                                        name: passengerList[index]['name'],
                                        ride: true,
                                        datetime: outputFormat.format(
                                            DateTime.parse(passengerList[index]
                                                ['created']))),
                                    editable
                                        ? Positioned(
                                            right: 8,
                                            top: -10,
                                            child: GestureDetector(
                                                onTap: () async {
                                                  var g = Passenger()
                                                      .getnamePassenger(
                                                          passengerList[index]
                                                              ['name'],
                                                          widget.operationId);
                                                  g.then((value) => {
                                                        userId = value,
                                                        print(userId),
                                                        showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              CompletionModal(
                                                            passId: userId,
                                                            userId:
                                                                passengerList[
                                                                        index]
                                                                    ['id'],
                                                            name: passengerList[
                                                                index]['name'],
                                                            image:
                                                                passengers_list[
                                                                        index]
                                                                    .image,
                                                            operationId: widget
                                                                .operationId,
                                                            busId: widget.busId,
                                                            busName:
                                                                widget.busName,
                                                          ),
                                                        )
                                                      });
                                                },
                                                child: Image.asset(
                                                    'assets/images/minus.png')))
                                        : Container()
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
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
      ),
    );
  }
}
