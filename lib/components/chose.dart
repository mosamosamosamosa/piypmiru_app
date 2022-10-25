import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class Chose extends StatelessWidget {
  Chose({
    Key? key,
    required this.role,
    required this.roleimg,
    required this.selected,
  }) : super(key: key);

  final String role;
  final String roleimg;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        (selected)
            ? Container(
                height: 170,
                width: 140,
                decoration: BoxDecoration(
                    color: Color(0xFFFFEEC2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 5, color: Color(0xFF90D7EC))),
              )
            : Container(
                height: 170,
                width: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFFFEEC2),
                  borderRadius: BorderRadius.circular(20),
                )),
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              "$roleの方は\nこちら",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: kFontColor,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/images/$roleimg'),
          ],
        ),
      ],
    );
  }
}
