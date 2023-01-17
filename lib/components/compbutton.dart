import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class Compbutton extends StatelessWidget {
  const Compbutton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 48,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Color(0XFFDCDCDC),
              ),
            ),
            const Text(
              '完了',
              style: TextStyle(
                  fontSize: 15, color: kFontColor, fontFamily: 'KiwiMaru-M'),
            ),
          ],
        ),
      ),
    );
  }
}
