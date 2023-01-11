// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:nfc_in_flutter/nfc_in_flutter.dart';
// //import 'package:nfc_in_flutter/nfc_in_flutter.dart';
// import 'package:piyomiru_application/constants.dart';

// class NfcScanModal extends StatefulWidget {
//   const NfcScanModal({
//     Key? key,
//   }) : super(key: key);

//   // createState()　で"State"（Stateを継承したクラス）を返す
//   @override
//   _NfcScanModalState createState() => _NfcScanModalState();
// }

// class _NfcScanModalState extends State<NfcScanModal> {
//   bool _supportsNFC = false;
//   bool _reading = false;
//   late StreamSubscription<NDEFMessage> _stream;

//   @override
//   void initState() {
//     super.initState();
//     // Check if the device supports NFC reading
//     NFC.isNDEFSupported.then((bool isSupported) {
//       setState(() {
//         _supportsNFC = isSupported;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double deviceW = MediaQuery.of(context).size.width;
//     double deviceH = MediaQuery.of(context).size.height;

//     if (!_supportsNFC) {
//       return Dialog(
//         alignment: Alignment.center,
//         insetPadding: const EdgeInsets.only(
//           bottom: 240,
//           top: 240,
//           left: 24,
//           right: 24,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               height: deviceH,
//               width: deviceW,
//               decoration: BoxDecoration(
//                 color: Color(0XFFFFFFFF),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(width: 3, color: kSubBackgroundColor),
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 //SizedBox(height: 0),
//                 const Text(
//                   "このデバイスは\nNFCに対応していません",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontSize: 24,
//                       color: kFontColor,
//                       fontFamily: 'KiwiMaru-R'),
//                 ),
//                 Image.asset('assets/images/hiyoko_batsu.png'),
//                 GestureDetector(
//                   onTap: () {
//                     //キャンセル処理
//                     Navigator.pop(context);
//                   },
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         height: 50,
//                         width: 120,
//                         decoration: BoxDecoration(
//                           color: kCanselColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       const Text("閉じる",
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: kFontColor,
//                               fontFamily: 'KiwiMaru-R')),
//                     ],
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       );
//     }
//     return Stack(
//       children: [
//         Positioned(
//             top: 210,
//             left: 35,
//             child: Image.asset('assets/images/hiyoko_anzen.png')),
//         Dialog(
//           alignment: Alignment.center,
//           insetPadding: const EdgeInsets.only(
//             bottom: 280,
//             top: 280,
//             left: 24,
//             right: 24,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 height: deviceH,
//                 width: deviceW,
//                 decoration: BoxDecoration(
//                   color: Color(0XFFFFFFFF),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(width: 3, color: kSubBackgroundColor),
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const Text(
//                     "NFCカードを\nスキャンしてください",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 24,
//                         color: kFontColor,
//                         fontFamily: 'KiwiMaru-R'),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       //キャンセル処理
//                       //Navigator.pop(context);
//                       if (_reading) {
//                         _stream.cancel();
//                         setState(() {
//                           _reading = false;
//                         });
//                       } else {
//                         setState(() {
//                           _reading = true;
//                           // Start reading using NFC.readNDEF()
//                           _stream = NFC
//                               .readNDEF(
//                             once: true,
//                             throwOnUserCancel: false,
//                           )
//                               .listen((NDEFMessage message) {
//                             print(message.payload);
//                           }, onError: (e) {
//                             // Check error handling guide below
//                           });
//                         });
//                       }
//                     },
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Container(
//                           height: 50,
//                           width: 120,
//                           decoration: BoxDecoration(
//                             color: kCanselColor,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         const Text("スキャン",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: kFontColor,
//                                 fontFamily: 'KiwiMaru-R')),
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
