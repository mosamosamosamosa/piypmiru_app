// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:nfc_in_flutter/nfc_in_flutter.dart';
// //import 'package:nfc_in_flutter/nfc_in_flutter.dart';
// import 'package:piyomiru_application/constants.dart';
// import 'package:piyomiru_application/nfc/nfc_scan.dart';
// import 'package:piyomiru_application/screens/driver/nfc/nfc_success_modal.dart';
// import 'package:piyomiru_application/screens/parent/write_nfc_in_flutter.dart';

// //////////package:piyomiru_application/screens/parent/addkids_modal.dartから呼ばれています！//////////

// class NfcScanModal extends StatefulWidget {
//   const NfcScanModal({Key? key, required this.kidName}) : super(key: key);

//   // createState()　で"State"（Stateを継承したクラス）を返す
//   final String kidName;
//   @override
//   _NfcScanModalState createState() => _NfcScanModalState();
// }

// class _NfcScanModalState extends State<NfcScanModal> {
//   bool _supportsNFC = false;

//   bool success = false;
//   bool failed = false;
//   String enId = '';
//   //var enId;

//   StreamSubscription<NDEFMessage>? _stream;
//   bool _hasClosedWriteDialog = false;

//   @override
//   Widget build(BuildContext context) {
//     double deviceW = MediaQuery.of(context).size.width;
//     double deviceH = MediaQuery.of(context).size.height;

//     return SingleChildScrollView(
//       child: Stack(
//         children: [
//           // Positioned(
//           //     top: 210,
//           //     left: 35,
//           //     child: Image.asset('assets/images/hiyoko_anzen.png')),
//           Dialog(
//             //////////<お子様の名前を入力してください>のダイアログ//////////
//             alignment: Alignment.center,
//             insetPadding: const EdgeInsets.only(
//               bottom: 250,
//               top: 250,
//               left: 28,
//               right: 28,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   height: 260,
//                   width: 350,
//                   decoration: BoxDecoration(
//                     color: Color(0XFFFFFFFF),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(width: 3, color: kSubBackgroundColor),
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     success //////////スキャン成功したら表示//////////
//                         ? const Text(
//                             "さん登録完了！",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: kFontColor,
//                             ),
//                           )
//                         : failed //////////スキャン失敗したら表示//////////
//                             ? const Text(
//                                 "読み取り失敗しました",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   color: kFontColor,
//                                 ),
//                               )
//                             : Text(
//                                 //////////!success&&!failedなら表示//////////
//                                 "お子様のNFCカードを\nスキャンしてください",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: 24,
//                                     color: kFontColor,
//                                     fontFamily: 'KiwiMaru-R'),
//                               ),
//                     success //////////スキャン成功したら表示//////////
//                         ? Image.asset('assets/images/hiyoko_success.png')
//                         : failed //////////スキャン失敗したら表示//////////
//                             ? Image.asset('assets/images/hiyoko_batsu.png')

//                             //////////!success&&!failedなら表示//////////
//                             : Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Stack(
//                                     alignment: AlignmentDirectional.center,
//                                     children: [
//                                       Container(
//                                         height: 86,
//                                         width: 86,
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: kInputColor,
//                                           //color: kSubBackgroundColor,
//                                         ),
//                                       ),
//                                       Image.asset(
//                                           'assets/images/hiyoko_nfc_left.png')
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     width: 15,
//                                   ),
//                                   Image.asset('assets/images/nfc_sannkaku.png'),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Image.asset('assets/images/nfc_sannkaku.png'),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Image.asset('assets/images/nfc_sannkaku.png'),
//                                   SizedBox(
//                                     width: 15,
//                                   ),
//                                   Stack(
//                                     alignment: AlignmentDirectional.center,
//                                     children: [
//                                       Container(
//                                         height: 86,
//                                         width: 86,
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: kInputColor,
//                                           //color: kSubBackgroundColor,
//                                         ),
//                                       ),
//                                       Image.asset(
//                                           'assets/images/hiyoko_nfc_right.png')
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                     success || failed //////////閉じるボタン//////////
//                         ? GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                               Navigator.of(context).pop();
//                             },
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   width: 120,
//                                   decoration: BoxDecoration(
//                                     color: kCanselColor,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 const Text("閉じる",
//                                     style: TextStyle(
//                                         fontSize: 18, color: kFontColor)),
//                               ],
//                             ),
//                           )
//                         : GestureDetector(
//                             //////////!success&&!failedならスキャンボタン表示//////////
//                             onTap: () {
//                               _hasClosedWriteDialog = true;
//                               _stream?.cancel();
//                               Navigator.pop(context);
//                             },
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   width: 120,
//                                   decoration: BoxDecoration(
//                                     color: kCanselColor,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 const Text("キャンセル",
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         color: kFontColor,
//                                         fontFamily: 'KiwiMaru-R')),
//                               ],
//                             ),
//                           )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
