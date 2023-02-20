import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';

class Buses {
  var headers = {'Content-Type': 'application/json'};

  getAllBuses() async {
    List<dynamic> busList = [];

    var request = http.Request('GET', Uri.parse('${Clients().url}/buses'));

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> buses =
          jsonDecode(response.body).cast<Map<String, dynamic>>();

      buses.forEach((element) {
        busList.add(element['name']);
      });
      return busList;
    } else {
      print(response.reasonPhrase);
    }
  }

  postBuses(String name) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${Clients().url}/buses'));
    request.body = json.encode({"name": name});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("成功");
    } else {
      print(response.reasonPhrase);
    }
  }

  //バスID取得
  getIdBuses(String name) async {
    int id = 0;
    var request = http.Request('GET', Uri.parse('${Clients().url}/buses'));

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> buses =
          jsonDecode(response.body).cast<Map<String, dynamic>>();

      buses.forEach((element) {
        if (element['name'] == name) {
          id = element['id'];
        }
      });
      return id;
      print(id);
    } else {
      print(response.reasonPhrase);
    }
  }

  //バス削除
  deleteBuses(int busId) async {
    var request =
        http.Request('DELETE', Uri.parse('${Clients().url}/buses/$busId'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print("成功");
    } else {
      print(response.reasonPhrase);
    }
  }
}
