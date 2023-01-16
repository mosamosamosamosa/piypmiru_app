import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piyomiru_application/api/buses.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/driver/home/home_driver_screen.dart';

class AddBusModal extends StatefulWidget {
  AddBusModal({Key? key}) : super(key: key);

  @override
  State<AddBusModal> createState() => _AddBusModalState();
}

class _AddBusModalState extends State<AddBusModal> {
  String name = '';
  var busList;
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    //final controller = TextEditingController();

    return SingleChildScrollView(
      child: Dialog(
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.only(
          bottom: 250,
          top: 250,
          left: 28,
          right: 28,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 260,
          width: 350,
          decoration: BoxDecoration(
            color: Color(0XFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: kSubBackgroundColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //SizedBox(height: 30),
              const Text(
                "バスの名前を入力してください",
                style: TextStyle(
                    fontSize: 22, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),

              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: kInputColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  //controller: controller,
                  style: const TextStyle(
                    fontSize: 24,
                    color: kFontColor,
                  ),
                  cursorColor: kFontColor,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 24),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
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
                          height: 64,
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
                      //追加処理
                      //name = controller.text;

                      setState(() {
                        if (name.isNotEmpty) {
                          Buses().postBuses(name);
                          var f = Buses().getAllBuses();

                          f.then((value) => {
                                busList = value,
                                print(busList),
                                Navigator.pop(context, busList),
                                Future.value(false),
                              });
                        } else {
                          Navigator.pop(context);
                          //print("false");
                        }
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 64,
                          width: 120,
                          decoration: BoxDecoration(
                            color: kStartColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Text(
                          "追加",
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
            ],
          ),
        ),
      ),
    );
  }
}
