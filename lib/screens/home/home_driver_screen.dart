import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:piyomiru_application/screens/home/logout_modal.dart';

class HomeDriverScreen extends StatefulWidget {
  const HomeDriverScreen({
    Key? key,
  }) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _HomeDriverScreenState createState() => _HomeDriverScreenState();
}

class _HomeDriverScreenState extends State<HomeDriverScreen> {
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    String group_name = groups_list[0].name;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: deviceH * 0.1,
        centerTitle: false,
        title: const Text(
          "PiyoMiru",
          style: TextStyle(
            color: kTitleColor,
            fontSize: 36,
          ),
        ),
        backgroundColor: kSubBackgroundColor,
        //影消す
        elevation: 0.0,

        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                // Dialogの周囲の黒い部分をタップしても閉じないようにする
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => LogoutModal(),
              );
            },
            child: const ActionButton(
              text: "園児",
              img: "bear.png",
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                // Dialogの周囲の黒い部分をタップしても閉じないようにする

                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => LogoutModal(),
              );
              print("Tap");
            },
            child: const ActionButton(
              text: "ログアウト",
              img: "frog.png",
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/background.png')),
          Column(
            children: [
              SizedBox(height: deviceH * 1 / 16),
              Text(
                '--$group_name--',
                style: TextStyle(
                    fontSize: 31, color: kFontColor, fontFamily: 'Kiwi_Maru'),
              ),
              Container(
                height: deviceH * 0.6,
                width: deviceW,
                child: GridView.count(
                  padding: const EdgeInsets.all(25),
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 28,
                  crossAxisSpacing: 28,
                  crossAxisCount: 2,
                  children: List.generate(
                    buses_list.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          //selectedCosId = buses_list[index].id;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kBusItemColor,
                        ),
                        child: Stack(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    buses_list[index].name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                operations_list[index].start == 1
                                    ? Column(children: [
                                        SizedBox(height: 16),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Image.asset(
                                              'assets/images/drive_mark.png'),
                                        ),
                                        SizedBox(height: 20),
                                        Image.asset(
                                            'assets/images/bus_drive.png')
                                      ])
                                    : Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Image.asset(
                                            'assets/images/bus_stop.png'),
                                      )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
