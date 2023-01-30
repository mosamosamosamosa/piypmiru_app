// import 'package:flutter/material.dart';
// import 'package:piyomiru_application/constants.dart';

// class NfcSuccessModal extends StatelessWidget {
//   NfcSuccessModal({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double deviceW = MediaQuery.of(context).size.width;
//     double deviceH = MediaQuery.of(context).size.height;

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
//                     "〇〇　〇〇さん\n乗車完了！",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 24,
//                       color: kFontColor,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       //キャンセル処理
//                       Navigator.pop(context);
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
//                         const Text("閉じる",
//                             style: TextStyle(fontSize: 18, color: kFontColor)),
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
