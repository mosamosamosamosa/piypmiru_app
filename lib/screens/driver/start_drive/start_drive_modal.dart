import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/api/operation.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/driver/operation/operation_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/driving_screen.dart';

class StartDriveModal extends ConsumerStatefulWidget {
  StartDriveModal({Key? key, required this.busName}) : super(key: key);

  final String busName;
  @override
  _StartDriveModalState createState() => _StartDriveModalState();
}

class _StartDriveModalState extends ConsumerState<StartDriveModal> {
  bool selectA = false;
  bool selectB = false;
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    final opeNotifier = ref.watch(opeProvider.notifier);
    final setoffNotifier = ref.watch(setoffProvider.notifier);

    return Dialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.only(
        bottom: 320,
        top: 280,
        left: 24,
        right: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: deviceH,
            width: deviceW,
            decoration: BoxDecoration(
              color: Color(0XFFFFFFFF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 3, color: kSubBackgroundColor),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(height: 30),
              const Text(
                "用途を選択してください",
                style: TextStyle(
                    fontSize: 22, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              //SizedBox(height: 42),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setoffNotifier.state = true;
                      setState(() {
                        selectA = true;
                        selectB = false;
                      });
                    },
                    child: Row(
                      children: [
                        selectA
                            ? Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: kSubBackgroundColor,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(0XFFD9D9D9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                        SizedBox(width: 5),
                        Text(
                          "お迎え",
                          style: const TextStyle(
                              fontSize: 22,
                              color: kFontColor,
                              fontFamily: 'KiwiMaru-R'),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setoffNotifier.state = false;
                      setState(() {
                        selectA = false;
                        selectB = true;
                      });
                    },
                    child: Row(
                      children: [
                        !selectB
                            ? Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(0XFFD9D9D9),
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: kSubBackgroundColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                        SizedBox(width: 5),
                        Text(
                          "お見送り",
                          style: const TextStyle(
                              fontSize: 22,
                              color: kFontColor,
                              fontFamily: 'KiwiMaru-R'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      if (selectA || selectB) {
                        Buses().getIdBuses(widget.busName).then((value) => {
                              Operation()
                                  .postOperation(true, false, value)
                                  .then((value) => {
                                        print("opeId:$value"),
                                        setState(() {
                                          opeNotifier.state = value;
                                        }),
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OperationScreen(
                                                    busName: widget.busName,
                                                    operationId: value,
                                                    setoff: selectA,
                                                  )),
                                        )
                                      })
                            });
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                color: kStartColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            selectA || selectB
                                ? Container()
                                : Container(
                                    height: 50,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color(0xF403F4C).withOpacity(0.4)),
                                  )
                          ],
                        ),
                        const Text(
                          "開始",
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
              //SizedBox(height: 20)
            ],
          ),
        ],
      ),
    );
  }
}
