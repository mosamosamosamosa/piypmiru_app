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

  //ログイン処理
  // loginUser(int userId,String password) async {
  //   var request =
  //       http.Request('GET', Uri.parse('${Clients().url}/users/$userId'));

  //   http.StreamedResponse stream_response = await request.send();
  //   var response = await http.Response.fromStream(stream_response);

  //   if (response.statusCode == 201) {
  //     Map<String, dynamic> login = jsonDecode(response.body);
  //     String password = login['pass'];

  //     return userName;
  //   } else {
  //     print(response.reasonPhrase);
  //     return "失敗";
  //   }
  // }

  //運転手か、親か？
  getroleUser(int userId) async {
    bool driver;
    var request =
        http.Request('GET', Uri.parse('${Clients().url}/users/$userId'));

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      Map<String, dynamic> role = jsonDecode(response.body);
      print("役割：$role");
      if (role['driver']) {
        driver = true;
      } else {
        driver = false;
      }

      print(driver);
      return driver;
    } else {
      print("失敗");
      return true;
    }
  }

  //自分の子ども取得
  getkidsUsers(int familyId) async {
    late List<Map<String, dynamic>> tesuserList;
    late List<Map<String, dynamic>> userList;

    List<String> nameList = [];

    var headers = {'Content-Type': 'text/plain'};
    var request = http.Request('GET', Uri.parse('${Clients().url}/users'));
    request.body = r'<file contents here>';

    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("色々成功だあああ");
      userList = jsonDecode(response.body).cast<Map<String, dynamic>>();

      userList.forEach((element) {
        if (element['passengers'] && element['family']['id'] == familyId) {
          nameList.add(element['name']);
        }
      });

      if (nameList.isEmpty) {
        return 0;
      } else {
        return nameList;
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  //名前からfamilyIdを返してくれる
  getFamilyUsers(String name) async {
    int familyId = 0;
    late List<Map<String, dynamic>> userList;
    List<dynamic> nameList = [];

    var headers = {'Content-Type': 'text/plain'};
    var request = http.Request('GET', Uri.parse('${Clients().url}/users'));
    request.body = r'<file contents here>';

    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      userList = jsonDecode(response.body).cast<Map<String, dynamic>>();

      nameList = userList.map((e) => e['name']).toList();

      for (int i = 0; i <= nameList.length; i++) {
        if (nameList[i] == name) {
          familyId = userList[i]['family']['id'];
          break;
        }
      }
      return familyId;
    } else {
      print(response.reasonPhrase);
    }
  }
}
