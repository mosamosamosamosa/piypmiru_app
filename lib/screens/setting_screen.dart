import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/nomal_button.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/provider/provider.dart';

import 'package:piyomiru_application/screens/driver/home/logout_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_modal.dart';
import 'package:piyomiru_application/screens/profile_modal.dart';

class SettingScreen extends ConsumerStatefulWidget {
  SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    //取得
    final userIdState = ref.watch(userProvider);
    //更新
    final nameNotifier = ref.watch(nameProvider.notifier);
    final mailNotifier = ref.watch(mailProvider.notifier);
    final groupNotifier = ref.watch(groupProvider.notifier);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: deviceH * 0.1,
        centerTitle: false,

        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/images/backmark.png')),

        title: const Text(
          "PiyoMiru",
          style: TextStyle(
              color: kTitleColor, fontSize: 36, fontFamily: 'Rajdhani-B'),
        ),
        backgroundColor: kSubBackgroundColor,
        //影消す
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/background.png')),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: deviceH * 1 / 14),
                const Text(
                  '-- 設定 --',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'KiwiMaru-R',
                    color: kFontColor,
                  ),
                ),
                SizedBox(height: deviceH * 1 / 18),
                GestureDetector(
                  onTap: () {
                    print(userIdState);
                    Users().getInfoUser(userIdState).then((value) => {
                          if (value != null)
                            {
                              nameNotifier.state = value['name'],
                              mailNotifier.state = value['email'],
                              groupNotifier.state = value['group']['name'],
                            },
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => ProfileModal())
                        });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: deviceH * 0.08,
                        width: deviceW * 0.74,
                        decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                            border: Border.all(
                              width: 1.5,
                              color: kSubBackgroundColor,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const Text(
                        'プロフィール変更',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'KiwiMaru-L',
                          color: kFontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: deviceH * 1 / 18),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: deviceH * 0.08,
                      width: deviceW * 0.74,
                      decoration: BoxDecoration(
                          color: Color(0XFFFFFFFF),
                          border: Border.all(
                            width: 1.5,
                            color: kSubBackgroundColor,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const Text(
                      '通知設定',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KiwiMaru-L',
                        color: kFontColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: deviceH * 1 / 18),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: deviceH * 0.08,
                      width: deviceW * 0.74,
                      decoration: BoxDecoration(
                          color: Color(0XFFFFFFFF),
                          border: Border.all(
                            width: 1.5,
                            color: kSubBackgroundColor,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const Text(
                      'お問合せ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KiwiMaru-L',
                        color: kFontColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: deviceH * 1 / 8,
            left: 0,
            right: 0,
            child: GestureDetector(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => LogoutModal());
                },
                child: NomalButton(text: "ログアウト", pushable: true)),
          )
        ],
      ),
    );
  }
}
