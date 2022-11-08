import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class AppSubButton extends StatelessWidget {
  const AppSubButton({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    // 文字列とボタンデザインをStackする
    return Stack(
      alignment: Alignment.center,
      children: [
        // ボタンデザインContainer
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            boxShadow: const [
              // ボタン下
              BoxShadow(
                color: Color(0xFFDAB357),
                offset: Offset(0, 13),
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
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: kFontColor,
            ),
          ),
          SizedBox(height: 5),
          Image.asset('assets/images/$image'),
        ]),
      ],
    );
  }
}
