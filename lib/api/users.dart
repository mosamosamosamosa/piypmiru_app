import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';

class Users {
  var headers = {'Content-Type': 'application/json'};

  //新規登録
  Future<void> postUser(
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
}
