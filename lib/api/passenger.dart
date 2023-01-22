import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';
import 'package:piyomiru_application/api/users.dart';

class Passenger {
  var headers = {'Content-Type': 'application/json'};
  int passengerUser = 0;
  int index = 0;
  //late Map<String, dynamic> passenger;
  late List<Map<String, dynamic>> passengerList;
  var passengerMap;
  List<Map<String, dynamic>> idList = [];
  //List<dynamic> nameList = [];

  getAllPassenger() async {
    var request_all_passenger =
        http.Request('GET', Uri.parse('${Clients().url}/passenger'));
    request_all_passenger.body = '''''';

    http.StreamedResponse stream_response = await request_all_passenger.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      passengerList = jsonDecode(response.body).cast<Map<String, dynamic>>();
      //idList = passengerList.map((e) => e['user_id']).toList();

      //乗車中の園児のIDだけを取得
      passengerList.forEach((element) {
        if (element['status']) {
          idList.add(element['user']);
        }
      });
      //print(passengerList[0]['status']);

      //return passengerList;
      //mapのリスト
      return idList;
    } else {
      debugPrint(response.reasonPhrase);

      return "失敗";
    }
  }

  //バス乗車
  //NFCでスキャンしたユーザIDを受け取ってpassengerに追加
  postPassenger(int userId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${Clients().url}/passenger'));
    request.body =
        json.encode({"status": true, "operation_id": 4, "user_id": userId});
    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 201) {
      print("成功");
      return "成功";
    } else {
      print(response.reasonPhrase);
    }
  }

  //降車
  putPassenger(int userId) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('PUT', Uri.parse('${Clients().url}/passenger/useId'));
    request.body =
        json.encode({"status": false, "operation_id": 3, "user_id": userId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
