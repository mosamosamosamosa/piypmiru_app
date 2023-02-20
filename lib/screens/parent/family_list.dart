import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/components/actionbutton.dart';
import 'package:piyomiru_application/components/addlistitem.dart';
import 'package:piyomiru_application/components/app_button.dart';
import 'package:piyomiru_application/components/listitem.dart';
import 'package:piyomiru_application/components/listitem_family.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/data/database.dart';
import 'package:intl/intl.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/parent/addkids_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/completion_modal.dart';
import 'package:piyomiru_application/screens/driver/passengers_kids/stop_drive_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/addlist_modal.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/start_drive_screen.dart';
import 'package:piyomiru_application/screens/parent/family_comp2_modak.dart';
import 'package:piyomiru_application/screens/parent/family_modal.dart';
import 'package:piyomiru_application/screens/parent/home_parent_screen.dart';

//////////package:piyomiru_application/screens/parent/home_parent_screen.dartから呼ばれています！//////////

class FamilyListScreen extends ConsumerStatefulWidget {
  FamilyListScreen({Key? key, required this.familyId}) : super(key: key);

  final int familyId;
  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _FamilyListScreenState createState() => _FamilyListScreenState();
}

class _FamilyListScreenState extends ConsumerState<FamilyListScreen> {
  var familyList;

  @override
  void initState() {
    // TODO: implement initState
    Users().getkidsUsers(widget.familyId).then((value) => {
          setState(() {
            familyList = value;
          }),
        });

    super.initState();
  }

  void _onReflesh() {
    Users().getkidsUsers(widget.familyId).then((value) => {
          setState(() {
            familyList = value;
            print('家族：$familyList');
          }),
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    DateFormat outputFormat = DateFormat('yyyy/MM/dd H:m');

    final familyIdState = ref.watch(familyProvider);
    final pushState = ref.watch(pushProvider);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTitleColor),
        toolbarHeight: deviceH * 0.1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeParentScreen(familyId: familyIdState)),
              );
            },
            child: Image.asset('assets/images/backmark.png')),
        title: const Text(
          "家族一覧",
          style: TextStyle(
              color: kFontColor, fontSize: 26, fontFamily: 'KiwiMaru-R'),
        ),
        backgroundColor: kSubBackgroundColor,
        //影消す
        elevation: 0.0,
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          _onReflesh();
        },
        builder: MaterialIndicatorDelegate(
          builder: (context, controller) {
            return Image.asset('assets/images/hiyoko_anzen.png');
          },
        ),
        child: Stack(
          children: [
            familyList == null || familyList.isEmpty
                ? SizedBox(
                    height: deviceH,
                    width: deviceW,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: deviceH * 0.12),
                        const Text(
                          "お子様を登録してください",
                          style: TextStyle(
                              color: kFontColor,
                              fontSize: 20,
                              fontFamily: 'KiwiMaru-L'),
                        ),
                        SizedBox(height: deviceH * 0.001),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    AddkidsModal(familyId: widget.familyId));
                          },
                          child: const Text(
                            "+ お子様を登録する",
                            style: TextStyle(
                                color: kSubBackgroundColor,
                                fontSize: 18,
                                fontFamily: 'KiwiMaru-L'),
                          ),
                        ),
                        SizedBox(height: deviceH * 0.12),
                        Image.asset('assets/images/kids_trio.png'),
                      ],
                    ),
                  )
                : SizedBox(
                    height: deviceH,
                    width: deviceW,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: deviceH * 0.05),
                      itemCount: familyList.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        if (index == familyList.length) {
                          return GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AddkidsModal(familyId: widget.familyId),
                                );
                              },
                              child: const Addlistitem());
                        }

                        return Stack(
                          children: [
                            ListitemFamily(
                                userId: 1, //仮
                                editable: false,
                                image: passengers_list[index].image,
                                name: familyList[index],
                                ride: true,
                                datetime: outputFormat.format(DateTime.now())),
                            Positioned(
                              top: 30,
                              right: 40,
                              child: GestureDetector(
                                onTap: () {
                                  if (pushState[index] % 2 == 0) {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          FamilyModal(
                                        image: passengers_list[index].image,
                                        name: familyList[index],
                                        index: index,
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          FamilyComp2Modal(
                                        image: passengers_list[index].image,
                                        name: familyList[index],
                                        index: index,
                                      ),
                                    );
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          // ボタン下
                                          BoxShadow(
                                              color: pushState[index] % 2 == 1
                                                  ? const Color(0xFF80BADB)
                                                  : const Color(0xFF72C37A),
                                              offset: const Offset(0, 5)),

                                          // ボタン上
                                          BoxShadow(
                                            color: pushState[index] % 2 == 1
                                                ? const Color(0xFFA4DEFF)
                                                : const Color(0xFFA9EFB0),
                                            //blurRadius: 0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    pushState[index] % 2 == 1
                                        ? Image.asset('assets/images/home.png')
                                        : Image.asset(
                                            'assets/images/bus_fami.png')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
