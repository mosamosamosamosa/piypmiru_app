import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class PassengerButton extends StatelessWidget {
  const PassengerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 文字列とボタンデザインをStackする
    return Stack(
      alignment: Alignment.center,
      children: [
        // ボタンデザインContainer
        Container(
          width: 300,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            boxShadow: const [
              // ボタン下
              BoxShadow(
                color: Color(0xFFDAB357),
                offset: Offset(0, 12),
              ),

              // ボタン上
              BoxShadow(
                color: Color(0xFFFBD579),
                //blurRadius: 0,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "乗車中園児確認",
                style: TextStyle(
                    fontSize: 30, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              SizedBox(width: 6),
              Image.asset('assets/images/tulip_red_small.png'),
            ]),
      ],
    );
  }
}
