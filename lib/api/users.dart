import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';

class Users {
  var headers = {'Content-Type': 'application/json'};

  //新規登録
  postUser(
    String name,
    String email,
    String password,
    bool driver,
    int groupId,
  ) async {
    var request_users =
        http.Request('POST', Uri.parse('${Clients().url}/users'));
    request_users.body = json.encode({
      "name": name,
      "email": email,
      "password": password,
      "driver": driver,
      "serial_number": null,
      "group_id": groupId,
      "family_id": null
    });
    //リクエストするときに使うヘッダーに上で定義したものを入れる
    //まとめて定義

    request_users.headers.addAll(headers);
    http.StreamedResponse response = await request_users.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
    } else {
      debugPrint(response.reasonPhrase);
      //debugPrint("失敗");
    }
  }

  getUser(int userId) async {
    var request =
        http.Request('GET', Uri.parse('${Clients().url}/users/$userId'));

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 201) {
      Map<String, dynamic> uname = jsonDecode(response.body);
      String userName = uname['name'];
      print("失敗");
      return userName;
    } else {
      print(response.reasonPhrase);
      return "失敗";
    }
  }

  //名前からユーザIDを返してくれる
  getAllUsers(String name) async {
    int userId = 0;
    late List<Map<String, dynamic>> userList;
    List<dynamic> nameList = [];

    var headers = {'Content-Type': 'text/plain'};
    var request = http.Request('GET', Uri.parse('${Clients().url}/users'));
    request.body = r'<file contents here>';

    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      userList = jsonDecode(response.body).cast<Map<String, dynamic>>();

      nameList = userList.map((e) => e['name']).toList();

      for (int i = 0; i <= nameList.length; i++) {
        if (nameList[i] == name) {
          userId = userList[i]['id'];
          break;
        }
      }
      return userId;
    } else {
      print(response.reasonPhrase);
    }
  }
}
