import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.text,
    required this.img,
  }) : super(key: key);

  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBackgroundColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$text',
                style: TextStyle(
                    fontSize: 10, color: kFontColor, fontFamily: 'Kiwi_Maru-L'),
              ),
              SizedBox(height: 3),
              Image.asset('assets/images/$img'),
            ],
          ),
        ],
      ),
    );
  }
}
