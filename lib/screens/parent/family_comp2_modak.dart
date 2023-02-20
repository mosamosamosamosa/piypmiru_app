import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/api/users.dart';
import 'package:piyomiru_application/constants.dart';
import 'package:piyomiru_application/provider/provider.dart';
import 'package:piyomiru_application/screens/driver/register_kids/registeredkids_screen.dart';
import 'package:piyomiru_application/screens/driver/start_drive/driving_screen.dart';
import 'package:piyomiru_application/screens/parent/family_list.dart';

class FamilyComp2Modal extends ConsumerStatefulWidget {
  FamilyComp2Modal(
      {Key? key, required this.name, required this.image, required this.index})
      : super(key: key);

  final String name;

  final String image;
  final int index;
  // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _FamilyComp2ModalState createState() => _FamilyComp2ModalState();
}

class _FamilyComp2ModalState extends ConsumerState<FamilyComp2Modal> {
  @override
  Widget build(BuildContext context) {
    // 状態管理している値を操作できるようにする
    final bus1Notifier = ref.watch(bus1Provider.notifier);
    final bus2Notifier = ref.watch(bus2Provider.notifier);
    final bus3Notifier = ref.watch(bus3Provider.notifier);

    final pushNotifier = ref.watch(pushProvider.notifier);
    //表示
    final bus1State = ref.watch(bus1Provider);
    final bus2State = ref.watch(bus2Provider);
    final bus3State = ref.watch(bus3Provider);
    final familyState = ref.watch(familyProvider);

    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Dialog(
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.only(
          bottom: 250,
          top: 250,
          left: 28,
          right: 28,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 260,
          width: 350,
          decoration: BoxDecoration(
            color: Color(0XFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: kSubBackgroundColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                textAlign: TextAlign.center,
                "お迎えを完了しますか？",
                style: TextStyle(
                    fontSize: 22, color: kFontColor, fontFamily: 'KiwiMaru-R'),
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
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
                  SizedBox(width: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 195,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0XFFFFEAB8),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 24,
                            color: kFontColor,
                            fontFamily: 'KiwiMaru-L'),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                          "もどる",
                          style: TextStyle(
                              fontSize: 18,
                              color: kFontColor,
                              fontFamily: 'KiwiMaru-R'),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pushNotifier.state[widget.index]++;

                      // if (widget.busName == "1号車") {
                      //   bus1Notifier.state++;
                      //   print(bus1State);
                      // } else if (widget.busName == "2号車") {
                      //   bus2Notifier.state++;
                      //   print(bus1State);
                      // } else if (widget.busName == "3号車") {
                      //   bus3Notifier.state++;
                      //   print(bus1State);
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FamilyListScreen(familyId: familyState)),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xFFA4DEFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Text(
                          "完了",
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
        ),
      ),
    );
    ;
  }
}
