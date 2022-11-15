import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/addlistitem.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:intl/intl.dart';
import 'package:piyomiru_application/screens/home/register_kids/addlist_modal.dart';
import 'package:piyomiru_application/screens/home/register_kids/registeredkids_screen.dart';

class EditlistScreen extends StatefulWidget {
  const EditlistScreen({
    Key? key,
  }) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _EditlistScreenState createState() => _EditlistScreenState();
}

class _EditlistScreenState extends State<EditlistScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    String text = "編集";
    bool editable = false;

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
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ActionButton(
                text: "完了",
                img: "hiyoko_pencil.png",
              ),
            ),
          ]),
      body: ListView.builder(
        padding: EdgeInsets.only(top: deviceH * 0.012),
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
                child: Container(
                    padding: EdgeInsets.only(top: deviceH * 0.012),
                    child: const Addlistitem()));
          }

          return Listitem(
              editable: true,
              image: passengers_list[index].image,
              name: passengers_list[index].name,
              datetime: outputFormat.format(DateTime.now()));
        },
      ),
    );
  }
}
