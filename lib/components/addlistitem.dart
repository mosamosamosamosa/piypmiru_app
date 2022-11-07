import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class Addlistitem extends StatelessWidget {
  const Addlistitem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: deviceH * 0.12,
          width: deviceW * 0.87,
          decoration: BoxDecoration(
              //color: Color(0XFFFFFFFF),
              border: Border.all(
                width: 1.5,
                color: kSubBackgroundColor,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
        Image.asset('assets/images/plus.png'),
      ],
    );
  }
}
