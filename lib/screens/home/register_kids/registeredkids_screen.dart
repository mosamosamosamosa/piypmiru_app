import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/addlistitem.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:intl/intl.dart';
import 'package:piyomiru_application/screens/home/register_kids/addlist_modal.dart';

class RegisterkidsScreen extends StatefulWidget {
  const RegisterkidsScreen({
    Key? key,
  }) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _RegisterkidsScreenState createState() => _RegisterkidsScreenState();
}

class _RegisterkidsScreenState extends State<RegisterkidsScreen> {
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    DateFormat outputFormat = DateFormat('yyyy/MM/dd H:m');

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: kTitleColor),
          toolbarHeight: deviceH * 0.1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/backmark.png')),
          title: const Text(
            "園児一覧",
            style: TextStyle(
              color: kFontColor,
              fontSize: 26,
            ),
          ),
          backgroundColor: kSubBackgroundColor,
          //影消す
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterkidsScreen()),
                );
              },
              child: const ActionButton(
                text: "編集する",
                img: "hiyoko_pencil.png",
              ),
            ),
          ]),
      body: ListView.builder(
        padding: EdgeInsets.only(top: deviceH * 0.05),
        itemCount: passengers_list.length + 1,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          if (index == passengers_list.length) {
            return GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AddlistModal(),
                  );
                },
                child: const Addlistitem());
          }

          return Listitem(
              image: passengers_list[index].image,
              name: passengers_list[index].name,
              datetime: outputFormat.format(DateTime.now()));
        },
      ),
    );
  }
}
