import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';

class Families {
  var headers = {'Content-Type': 'application/json'};
  int groupId = 0;

  postFamily(String name) async {
    var familyId;
    var request_family =
        http.Request('POST', Uri.parse('${Clients().url}/family'));
    request_family.body = json.encode({"name": name});

    request_family.headers.addAll(headers);
    //リクエストするときに使うヘッダーに上で定義したものを入れる
    //まとめて定義

    http.StreamedResponse stream_response = await request_family.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> family = jsonDecode(response.body);

      familyId = family['id'];
      //debugPrint(groupId.toString());
      return familyId;
    } else {
      debugPrint(response.reasonPhrase);
      return 0;
      //debugPrint("失敗");
    }
  }
}
