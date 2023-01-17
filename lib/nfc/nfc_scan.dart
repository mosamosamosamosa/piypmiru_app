// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:nfc_in_flutter/nfc_in_flutter.dart';

// class NfcScan {
//   bool _reading = false;
//   late StreamSubscription<NDEFMessage> _stream;
//   String enId = '';

//   nfcRead() {
//     if (_reading) {
//       _stream.cancel();

//       _reading = false;
//     } else {
//       _reading = true;
//       // Start reading using NFC.readNDEF()
//       _stream = NFC
//           .readNDEF(
//         once: true,
//         throwOnUserCancel: false,
//       )
//           .listen((NDEFMessage message) {
//         enId = message.payload;
//       }, onError: (e) {
//         // Check error handling guide below
//       });
//       //return enId;
//     }
//   }

//   nfcWrite() {}
// }
