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
      //passengerList = jsonDecode(response.body).cast<Map<String, dynamic>>();
      //idList = passengerList.map((e) => e['user_id']).toList();

      passengerList = [
        {
          "id": 7,
          "status": true,
          "created": "2023-01-12T15:20:05.377910+09:00",
          "operation_id": null,
          "user_id": {
            "id": 1,
            "name": "test",
            "email": "test@gmail.com",
            "driver": false,
            "created": "2022-12-01T14:23:31.818852+09:00",
            "group_id": 1,
            "family_id": 1
          }
        },
        {
          "id": 8,
          "status": true,
          "created": "2023-01-12T15:20:11.333192+09:00",
          "operation_id": null,
          "user_id": {
            "id": 2,
            "name": "test3",
            "email": "test3@gmail.com",
            "driver": false,
            "created": "2022-12-08T13:44:14.328146+09:00",
            "group_id": null,
            "family_id": null
          }
        },
        {
          "id": 9,
          "status": false,
          "created": "2023-01-12T15:20:05.377910+09:00",
          "operation_id": null,
          "user_id": {
            "id": 3,
            "name": "test",
            "email": "test@gmail.com",
            "driver": false,
            "created": "2022-12-01T14:23:31.818852+09:00",
            "group_id": 1,
            "family_id": 1
          }
        },
      ];

      //乗車中の園児のIDだけを取得
      passengerList.forEach((element) {
        if (element['status']) {
          idList.add(element['user_id']);
        }
      });
      print(passengerList[0]['status']);

      //mapのリスト
      return idList;
    } else {
      debugPrint(response.reasonPhrase);

      return "失敗";
    }
  }

  //バス乗車
  //NFCでスキャンしたユーザIDを受け取ってpassengerに追加
  postPassenger(int userId, bool status) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${Clients().url}/passenger'));
    request.body = json
        .encode({"status": status, "operation_id": null, "user_id": userId});
    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      print(response.body);
      print("成功");
    } else {
      print(response.reasonPhrase);
    }
  }

  //降車
  compPassenger(int userId, bool status) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${Clients().url}/passenger'));
    request.body = json
        .encode({"status": status, "operation_id": null, "user_id": userId});
    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
