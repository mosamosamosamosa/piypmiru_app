import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';

class Passenger {
  var headers = {'Content-Type': 'application/json'};
  int passengerUser = 0;
  //late Map<String, dynamic> passenger;
  late List<Map<String, dynamic>> passengerList;

  Future<String> getAllPassenger() async {
    var request_all_passenger =
        http.Request('GET', Uri.parse('${Clients().url}/passenger'));
    request_all_passenger.body = '''''';

    http.StreamedResponse stream_response = await request_all_passenger.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      passengerList = jsonDecode(response.body).cast<Map<String, dynamic>>();
      for (var passengerMap in passengerList) {
        print(passengerMap['id']);
      }
      // for (var i = 0; i <= passenger['id'].length; i++) {
      //   passengerList = passenger[]
      // }
      //passengerList = jsonDecode(response.body).cast<Map<String, dynamic>>();
      //debugPrint(response.body);

      return "成功";
    } else {
      debugPrint(response.reasonPhrase);

      return "失敗";
    }
  }
}
