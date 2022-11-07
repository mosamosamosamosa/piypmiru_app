import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.start,
  }) : super(key: key);

  final String text;
  final bool start;
  @override
  Widget build(BuildContext context) {
    // 文字列とボタンデザインをStackする
    return Stack(
      alignment: Alignment.center,
      children: [
        // ボタンデザインContainer
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
                offset: const Offset(0, 15),
              ),

              // ボタン上
              BoxShadow(
                color: start == true ? kStartColor : const Color(0xFF94EDFF),
                //blurRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 26,
              color: start == true ? const Color(0XFFFFFFFF) : kFontColor,
            ),
          ),
        ),
        //Image.asset('assets/images/hiyoko_beginer.png')
      ],
    );
  }
}
