import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piyomiru_application/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kAppbarColor,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: deviceH * 1 / 6),
            alignment: Alignment.center,
            child: const Text(
              "Loading...",
              style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: kTitleColor,
                  fontFamily: 'Kiwi_Maru'),
            ),
          ),
          SizedBox(height: deviceH * 1 / 6),
          Image.asset('assets/images/hiyoko_flag.png'),
        ],
      ),
    );
  }
}
