import 'package:flutter/material.dart';
import 'package:piyomiru_application/api/passenger.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/passengers_list_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/driving_screen.dart';

class ProfileModal extends StatefulWidget {
  ProfileModal({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileModal> createState() => _ProfileModalState();
}

class _ProfileModalState extends State<ProfileModal> {
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Dialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.only(
        bottom: 150,
        top: 150,
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
              SizedBox(height: 10),
              Text(
                "プロフィール",
                style: const TextStyle(
                    fontSize: 26, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              //SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                            color: Color(0XFFD9D9D9),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Image.asset('assets/images/prof_icon.png'),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0XFFFFEAB8),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "〇〇 〇〇さん",
                            style: const TextStyle(
                                fontSize: 24,
                                color: kFontColor,
                                fontFamily: 'KiwiMaru-R'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  SizedBox(width: 24),
                  Text(
                    "ステータス",
                    style: const TextStyle(
                        fontSize: 22,
                        color: kFontColor,
                        fontFamily: 'KiwiMaru-R'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: kSubBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        "運転手または添乗員",
                        style: const TextStyle(
                            fontSize: 18,
                            color: kFontColor,
                            fontFamily: 'KiwiMaru-R'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Color(0XFFD9D9D9),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        "保護者",
                        style: const TextStyle(
                            fontSize: 18,
                            color: kFontColor,
                            fontFamily: 'KiwiMaru-R'),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 24),
                  Text(
                    "メールアドレス",
                    style: const TextStyle(
                        fontSize: 22,
                        color: kFontColor,
                        fontFamily: 'KiwiMaru-R'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: 300,
                        height: 42,
                        decoration: BoxDecoration(
                            color: Color(0XFFFFEAB8),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "test.gmail.com",
                            style: const TextStyle(
                                fontSize: 24,
                                color: kFontColor,
                                fontFamily: 'Rajdhani-M'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 24),
                  Text(
                    "所属",
                    style: const TextStyle(
                        fontSize: 22,
                        color: kFontColor,
                        fontFamily: 'KiwiMaru-R'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: 300,
                        height: 42,
                        decoration: BoxDecoration(
                            color: Color(0XFFFFEAB8),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "ぴよみる幼稚園",
                            style: const TextStyle(
                                fontSize: 24,
                                color: kFontColor,
                                fontFamily: 'Rajdhani-M'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
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
                    onTap: () async {},
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
