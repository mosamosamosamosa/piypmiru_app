import 'package:flutter/material.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/completion_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/delete_modal.dart';

class Listitem extends StatefulWidget {
  Listitem(
      {Key? key,
      required this.userId,
      required this.image,
      required this.name,
      required this.datetime,
      required this.editable,
      required this.ride})
      : super(key: key);

  final int userId;
  final String image;
  final String name;
  final String datetime;
  final bool editable;
  final bool ride;

  @override
  _ListitemState createState() => _ListitemState();
}

class _ListitemState extends State<Listitem> {
  var ruserId;

  @override
  void initState() {
    Users().getnameAllUsers(widget.name).then((value) => {ruserId = value});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: deviceH * 0.12 + 15,
          width: deviceW * 0.87,
        ),
        Container(
          height: deviceH * 0.12,
          width: deviceW * 0.87,
          decoration: BoxDecoration(
              color: Color(0XFFFFFFFF),
              border: Border.all(
                width: 1.5,
                color: kSubBackgroundColor,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
        Row(
          children: [
            const SizedBox(width: 36),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Color(0XFFD9D9D9),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Image.asset('assets/images/${widget.image}'),
              ],
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.name} さん",
                  style: const TextStyle(
                      fontSize: 24,
                      color: kFontColor,
                      fontFamily: 'KiwiMaru-L'),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "${widget.datetime}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: kFontColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        widget.editable
            ? Positioned(
                top: -8,
                right: 0,
                child: GestureDetector(
                    onTap: () async {
                      if (widget.ride) {
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => DeleteModal(
                              name: widget.name,
                              image: widget.image,
                              userId: ruserId),
                        );
                      }
                    },
                    child: widget.ride
                        ? Container()
                        : Image.asset('assets/images/batsu.png')))
            : Container(),
      ],
    );
  }
}
