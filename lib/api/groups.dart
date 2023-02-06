import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';

class Groups {
  var headers = {'Content-Type': 'application/json'};
  int groupId = 0;

  postGroups(
    String groupName,
    String groupAdd,
  ) async {
    var request_groups =
        http.Request('POST', Uri.parse('${Clients().url}/groups'));
    request_groups.body = json.encode({"name": groupName, "address": groupAdd});
    //リクエストするときに使うヘッダーに上で定義したものを入れる
    //まとめて定義

    request_groups.headers.addAll(headers);
    http.StreamedResponse stream_response = await request_groups.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 201) {
      Map<String, dynamic> groups = jsonDecode(response.body);

      groupId = groups['id'];
      //debugPrint(groupId.toString());
      return groupId;
    } else {
      debugPrint(response.reasonPhrase);
      return 0;
      //debugPrint("失敗");
    }
  }

  getIdgroups(String name) async {
    late List<Map<String, dynamic>> groupList;

    var request = http.Request('GET', Uri.parse('${Clients().url}/groups'));

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      groupList = jsonDecode(response.body).cast<Map<String, dynamic>>();

      groupList.forEach((element) {
        if (element['name'] == name) {
          groupId = element['id'];
        }
      });

      return groupId;
    } else {
      print(response.reasonPhrase);
    }
  }
}
