import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class NomalButton extends StatelessWidget {
  NomalButton({
    Key? key,
    required this.text,
    required this.pushable,
  }) : super(key: key);

  final String text;
  final bool pushable;

  @override
  Widget build(BuildContext context) {
    // 文字列とボタンデザインをStackする
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            height: 66,
            width: 286,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey, //色
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: kTitleColor,
            ),
          ),
          pushable
              ? Container()
              : Container(
                  height: 66,
                  width: 286,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xF403F4C).withOpacity(0.4)),
                )
        ]),
        Text(
          "$text",
          style: TextStyle(
              fontSize: 30, color: kFontColor, fontFamily: 'KiwiMaru-R'),
        ),
      ],
    );
  }
}
