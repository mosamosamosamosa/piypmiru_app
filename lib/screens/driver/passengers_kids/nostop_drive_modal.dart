import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_modal.dart';

class NostopDriveModal extends StatelessWidget {
  NostopDriveModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Dialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.only(
        bottom: 250,
        top: 250,
        left: 24,
        right: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: deviceH,
            width: deviceW,
            decoration: BoxDecoration(
              color: Color(0XFFFFFFFF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 3, color: kSubBackgroundColor),
            ),
          ),
          Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 38),
              const Text(
                "バスに園児が残っています",
                style: TextStyle(
                    fontSize: 24, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              SizedBox(height: 10),
              Image.asset('assets/images/hiyoko_batsu.png'),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: kCanselColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Text(
                      "閉じる",
                      style: TextStyle(
                          fontSize: 18,
                          color: kFontColor,
                          fontFamily: 'KiwiMaru-R'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
