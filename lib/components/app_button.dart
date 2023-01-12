import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.start,
    required this.pushable,
  }) : super(key: key);

  final String text;
  final bool start;
  final bool pushable;
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    // 文字列とボタンデザインをStackする
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // ボタンデザインContainer
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 240,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  // ボタン下
                  BoxShadow(
                      color: start == true
                          ? const Color(0xFFDC3C14)
                          : const Color(0xFF76C8D9),
                      offset: start == true
                          ? const Offset(0, 13)
                          : const Offset(0, 0)),

                  // ボタン上
                  BoxShadow(
                    color:
                        start == true ? kStartColor : const Color(0xFF94EDFF),
                    //blurRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
            pushable
                ? Container()
                : Container(
                    alignment: Alignment.bottomCenter,
                    width: 240,
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: Color(0xF403F4C).withOpacity(0.4)),
                  ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: deviceH * 0.025),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 26,
              fontFamily: 'KiwiMaru-R',
              color: start == true ? const Color(0XFFFFFFFF) : kFontColor,
            ),
          ),
        ),
      ],
    );
  }
}
