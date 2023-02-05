import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';

class DeleteBusModal extends StatefulWidget {
  DeleteBusModal({Key? key, required this.name, required this.id})
      : super(key: key);

  final String name;
  final int id;
  @override
  State<DeleteBusModal> createState() => _DeleteBusModalState();
}

class _DeleteBusModalState extends State<DeleteBusModal> {
  String name = '';
  var busList;
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    //final controller = TextEditingController();

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
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20),
              const Text(
                "バスの登録から削除しますか？",
                style: TextStyle(
                    fontSize: 23, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  const SizedBox(width: 26),
                  Image.asset('assets/images/delete_bus.png'),
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
                        widget.name,
                        style: const TextStyle(
                            fontSize: 24,
                            color: kFontColor,
                            fontFamily: 'KiwiMaru-L'),
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
                              fontFamily: 'KiwiMaru-R'),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Buses().deleteBuses(widget.id).then((value) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeDriverScreen()),
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
                            color: kStartColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Text(
                          "削除",
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
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
