import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class BusItemFamily extends StatelessWidget {
  BusItemFamily({Key? key, required this.name, required this.select})
      : super(key: key);

  final String name;
  final bool select;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        select
            ? Container(
                height: 76,
                width: 95,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Color(0xFF90D7EC)),
                  borderRadius: BorderRadius.circular(10),
                  color: kBusItemColor,
                ),
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 15,
                      color: kFontColor,
                      fontFamily: 'KiwiMaru-R'),
                ),
              )
            : Container(
                height: 76,
                width: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kBusItemColor,
                ),
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 15,
                      color: kFontColor,
                      fontFamily: 'KiwiMaru-R'),
                ),
              ),
        Image.asset('assets/images/bus_sel.png'),
      ],
    );
  }
}
