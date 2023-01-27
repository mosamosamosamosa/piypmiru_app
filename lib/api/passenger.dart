import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';
import 'package:piyomiru_application/api/operation.dart';
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

  getAllPassenger(int operationId) async {
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
        if (element['operation']['id'] == operationId) {
          if (element['status']) {
            idList.add(element['user']);
            print(element['status']);
          }
        }
      });

      if (idList.isEmpty) {
        return 0;
      } else {
        return idList;
      }
    } else {
      debugPrint(response.reasonPhrase);

      return 0;
    }
  }

  //バス乗車
  //NFCでスキャンしたユーザIDを受け取ってpassengerに追加
  postPassenger(int userId, int operationId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${Clients().url}/passenger'));
    request.body = json.encode(
        {"status": true, "operation_id": operationId, "user_id": userId});
    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 201) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  //降車
  putPassenger(int passId, int userId, int operationId) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('PUT', Uri.parse('${Clients().url}/passenger/$passId'));
    request.body = json.encode(
        {"status": false, "operation_id": operationId, "user_id": userId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return ("降車成功");
    } else {
      print(response.reasonPhrase);
    }
  }

  //名前が同じ子のIDを返してくれる
  //名前からユーザIDを返してくれる
  getnamePassenger(String name) async {
    List<dynamic> nameList = [];
    var passId;

    var request_all_passenger =
        http.Request('GET', Uri.parse('${Clients().url}/passenger'));
    request_all_passenger.body = '''''';

    http.StreamedResponse stream_response = await request_all_passenger.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      passengerList = jsonDecode(response.body).cast<Map<String, dynamic>>();

      passengerList.forEach((element) {
        nameList.add(element['user']['name']);
      });

      for (int i = 0; i <= nameList.length; i++) {
        if (nameList[i] == name) {
          passId = passengerList[i]['id'];
          break;
        }
      }

      print(passId);

      return passId;
    } else {
      debugPrint(response.reasonPhrase);

      return "失敗";
    }
  }

  //userIdからPassengerId求める
  getpassIdPassenger(int userId) async {
    List<int> idList = [];
    var passId;
    var request_all_passenger =
        http.Request('GET', Uri.parse('${Clients().url}/passenger'));
    request_all_passenger.body = '''''';

    http.StreamedResponse stream_response = await request_all_passenger.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      passengerList = jsonDecode(response.body).cast<Map<String, dynamic>>();
      //idList = passengerList.map((e) => e['user_id']).toList();

      // //乗車中の園児のIDだけを取得
      // passengerList.forEach((element) {
      //   if (element['status']) {
      //     idList.add(element['user']['id']);
      //   }
      // });

      // for (int i = 0; i <= idList.length; i++) {
      //   if (idList[i] == userId) {
      //     passId = passengerList[i]['id'];
      //     break;
      //   }
      // }

      passengerList.forEach((element) {
        idList.add(element['user']['id']);
      });

      for (int i = 0; i <= idList.length; i++) {
        if (idList[i] == userId) {
          passId = passengerList[i]['id'];
          break;
        }
      }

      //mapのリスト
      return passId;
    } else {
      debugPrint(response.reasonPhrase);

      return 0;
    }
  }
}
