import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/chose.dart';
import 'package:piyomiru_application/components/nomal_button.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/splash_screen.dart';

class ChoseScreen extends StatefulWidget {
  ChoseScreen({Key? key}) : super(key: key);

  @override
  _ChoseScreenState createState() => _ChoseScreenState();
}

class _ChoseScreenState extends State<ChoseScreen> {
  bool selected_parent = false;
  bool selected_driver = false;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kAppbarColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: deviceH * 1 / 6),
                child: const Text(
                  "PiyoMiru",
                  style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: kTitleColor,
                      fontFamily: 'KiwiMaru'),
                ),
              ),
              SizedBox(height: deviceH * 1 / 12),
              // Expanded(

              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: const [
              //       Chose(role: "保護者", roleimg: "parent.png"),
              //       SizedBox(width: 35),
              //       Chose(role: "運転手", roleimg: "driver.png"),
              //     ],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_parent = true;
                          selected_driver = false;
                        });
                      },
                      child: Chose(
                        role: "保護者",
                        roleimg: "parent.png",
                        selected: selected_parent,
                      )),
                  SizedBox(width: deviceW * 1 / 12),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_parent = false;
                          selected_driver = true;
                        });
                      },
                      child: Chose(
                        role: "運転手",
                        roleimg: "driver.png",
                        selected: selected_driver,
                      )),
                ],
              ),
            ],
          ),
          selected_parent || selected_driver
              ? Positioned(
                  bottom: deviceH * 1 / 8,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                      onTap: () {
                        print("Tap");
                      },
                      child: NomalButton(
                        text: "決定",
                        pushable: true,
                      )),
                )
              : Positioned(
                  bottom: deviceH * 1 / 8,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                      onTap: () {},
                      child: NomalButton(
                        text: "決定",
                        pushable: false,
                      )),
                )
        ],
      ),
    );
  }
}
