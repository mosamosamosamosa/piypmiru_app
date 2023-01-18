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

  //園児の仮登録いるか？？？？
  propostUser(String name) async {
    var request_users =
        http.Request('POST', Uri.parse('${Clients().url}/users'));
    request_users.body = json.encode({
      "name": name,
      "email": "test7@gmail.com",
      "password": "12345678",
      "driver": false,
      "passengers": true,
      "serial_number": null,
      "group": 1,
      "family": 1
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

      return userName;
    } else {
      print(response.reasonPhrase);
      return "失敗";
    }
  }

  //名前からユーザIDを返してくれる
  getnameAllUsers(String name) async {
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

  getkidsAllUsers() async {
    late List<Map<String, dynamic>> tesuserList;
    late List<Map<String, dynamic>> userList;

    List<String> nameList = [];

    var headers = {'Content-Type': 'text/plain'};
    var request = http.Request('GET', Uri.parse('${Clients().url}/users'));
    request.body = r'<file contents here>';

    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      userList = jsonDecode(response.body).cast<Map<String, dynamic>>();
      tesuserList = [
        {
          "id": 1,
          "name": "jill",
          "email": "jill@gmail.com",
          "driver": true,
          "passenger": false,
          "created": "2022-12-01T14:23:31.818852+09:00",
          "group_id": 1,
          "family_id": 1
        },
        {
          "id": 2,
          "name": "test3",
          "email": "test3@gmail.com",
          "driver": false,
          "passenger": true,
          "created": "2022-12-08T13:44:14.328146+09:00",
          "group_id": null,
          "family_id": null
        },
        {
          "id": 3,
          "name": "test4",
          "email": "test4@gmail.com",
          "driver": false,
          "passenger": true,
          "created": "2022-12-08T13:44:14.328146+09:00",
          "group_id": null,
          "family_id": null
        }
      ];

      userList.forEach((element) {
        if (element['passengers']) {
          nameList.add(element['name']);
        }
      });

      print(userList);
      return nameList;
    } else {
      print(response.reasonPhrase);
    }
  }

  //登録園児削除
  deleteUser(int userId) async {
    var request =
        http.Request('DELETE', Uri.parse('${Clients().url}/users/$userId'));

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
