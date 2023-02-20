import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/passengers_list_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/driving_screen.dart';

class CompletionModal extends ConsumerStatefulWidget {
  CompletionModal(
      {Key? key,
      required this.name,
      required this.busName,
      required this.image,
      required this.passId,
      required this.userId,
      required this.operationId,
      required this.busId})
      : super(key: key);

  final String image;
  final String name;
  final int passId;
  final int userId;
  final int operationId;
  final int busId;
  final String busName;

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _CompletionModalState createState() => _CompletionModalState();
}

class _CompletionModalState extends ConsumerState<CompletionModal> {
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    final setoffState = ref.watch(setoffProvider);

    return Dialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.only(
        bottom: 250,
        top: 250,
        left: 18,
        right: 18,
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
            children: [
              SizedBox(height: 20),
              Text(
                "降車を完了しますか？",
                style: const TextStyle(
                  fontSize: 23,
                  color: kFontColor,
                ),
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  const SizedBox(width: 36),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Color(0XFFD9D9D9),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Image.asset('assets/images/${widget.image}'),
                    ],
                  ),
                  SizedBox(width: 12),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 195,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0XFFFFEAB8),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Text(
                        "${widget.name}",
                        style: const TextStyle(
                          fontSize: 24,
                          color: kFontColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                          height: 60,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      //降車処理

                      var f = Passenger().putPassenger(
                          widget.passId, widget.userId, widget.operationId);

                      f.then((value) => {
                            // print("passId:$passId"),
                            // print("userId:$userId"),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PassengerListScreen(
                                      busId: widget.busId,
                                      drive: true,
                                      operationId: widget.operationId,
                                      busName: widget.busName,
                                      setoff: setoffState)),
                            )
                          });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0XFF61CD7F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Text(
                          "完了",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0XFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
