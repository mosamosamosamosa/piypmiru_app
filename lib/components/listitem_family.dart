import 'package:flutter/material.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/completion_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/delete_modal.dart';
import 'package:piyomiru_application/screens/parent/family_modal.dart';

class ListitemFamily extends StatefulWidget {
  ListitemFamily(
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
  _ListitemFamilyState createState() => _ListitemFamilyState();
}

class _ListitemFamilyState extends State<ListitemFamily> {
  var ruserId;

  // @override
  // void initState() {
  //   Users().getnameAllUsers(widget.name).then((value) => {ruserId = value});
  //   super.initState();
  // }

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
                  widget.name,
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
        // Positioned(
        //   top: 30,
        //   right: 40,
        //   child: GestureDetector(
        //     onTap: () {
        //       print("名前ああああああああああああああああああああああああ：${widget.name}");
        //       showDialog(
        //         barrierDismissible: false,
        //         context: context,
        //         builder: (BuildContext context) =>
        //             FamilyModal(image: widget.image, name: widget.name),
        //       );
        //     },
        //     child: Stack(
        //       alignment: Alignment.center,
        //       children: [
        //         Container(
        //           width: 55,
        //           height: 55,
        //           decoration: const BoxDecoration(
        //             shape: BoxShape.circle,
        //             boxShadow: [
        //               // ボタン下
        //               BoxShadow(color: Color(0xFF72C37A), offset: Offset(0, 5)),

        //               // ボタン上
        //               BoxShadow(
        //                 color: Color(0xFFA9EFB0),
        //                 //blurRadius: 0,
        //                 offset: Offset(0, 0),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Image.asset('assets/images/bus_fami.png')
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
