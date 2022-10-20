import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piyomiru_application/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppbarColor,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 140),
            alignment: Alignment.center,
            child: const Text(
              "Loading...",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: kTitleColor,
              ),
            ),
          ),
          const SizedBox(height: 150),
          Image.asset('assets/images/hiyoko_flag.png'),
        ],
      ),
    );
  }
}
