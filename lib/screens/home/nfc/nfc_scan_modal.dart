import 'package:flutter/material.dart';
import 'package:piyomiru_application/constants.dart';

class NfcScanModal extends StatelessWidget {
  NfcScanModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Dialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.only(
        bottom: 280,
        top: 280,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "NFCカードを\nスキャンしてください",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: kFontColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  //キャンセル処理
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
                    const Text("キャンセル",
                        style: TextStyle(fontSize: 18, color: kFontColor)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
