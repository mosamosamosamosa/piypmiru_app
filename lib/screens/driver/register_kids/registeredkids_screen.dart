import 'package:flutter/material.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/addlistitem.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:intl/intl.dart';
import 'package:piyomiru_application/screens/driver/register_kids/addlist_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/delete_modal.dart';

class RegisterkidsScreen extends StatefulWidget {
  const RegisterkidsScreen({
    Key? key,
  }) : super(key: key);

  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _RegisterkidsScreenState createState() => _RegisterkidsScreenState();
}

class _RegisterkidsScreenState extends State<RegisterkidsScreen> {
  bool editable = false;
  int edit_flag = 0;
  String action = "編集";

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
              color: kFontColor, fontSize: 26, fontFamily: 'KiwiMaru-R'),
        ),
        backgroundColor: kSubBackgroundColor,
        elevation: 0.0,
        actions: [
          GestureDetector(
              onTap: () {
                if (edit_flag % 2 == 0) {
                  setState(() {
                    editable = true;
                    action = "完了";
                    edit_flag++;
                  });
                } else {
                  setState(() {
                    editable = false;
                    action = "編集";
                    edit_flag++;
                  });
                }
              },
              child: ActionButton(text: action, img: 'hiyoko_pencil.png')),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: deviceH * 0.012),
        itemCount: users_list.length + 1,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          if (index == users_list.length) {
            return GestureDetector(
                onTap: () async {
                  String name = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AddlistModal(),
                  );
                  //リストに追加
                  print(name);
                },
                child: Container(
                    padding: EdgeInsets.only(top: deviceH * 0.012),
                    child: const Addlistitem()));
          }

          return Listitem(
              userId: 1, //仮
              editable: editable,
              image: users_list[index].image,
              name: users_list[index].name,
              ride: false,
              datetime: outputFormat.format(DateTime.now()));
        },
      ),
    );
  }
}
