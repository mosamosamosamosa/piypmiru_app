import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:piyomiru_application/api/clients.dart';

class Operation {
  var headers = {'Content-Type': 'application/json'};
  late List<Map<String, dynamic>> businfoList = [];
  //バスが運行しているか否か
  getStatusOperation(int busId) async {
    late List<Map<String, dynamic>> operationList;
    bool start;

    var request = http.Request('GET', Uri.parse('${Clients().url}/operation'));

    request.body = '''''';

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      operationList = jsonDecode(response.body).cast<Map<String, dynamic>>();

      //バスのIDが一致しているものを全部取り出す
      operationList.forEach((element) {
        if (element['bus']['id'] == busId) {
          businfoList.add(element);
          print(businfoList);
        }
      });

      if (businfoList.isEmpty) {
        start = false;
      } else {
        if (businfoList[businfoList.length - 1]['start'] == true) {
          start = true;
        } else {
          {
            start = false;
          }
        }
      }

      print("成功");
      return start;
    } else {
      print("失敗");
      return false;
    }
  }

  postOperation(bool start, bool end, int busId) async {
    late Map<String, dynamic> operationList;

    var request = http.Request('POST', Uri.parse('${Clients().url}/operation'));
    request.body = json.encode({"start": start, "end": end, "bus_id": busId});
    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      operationList = jsonDecode(response.body);
      print(operationList['id']);
      return operationList['id'];
    } else {
      print(response.reasonPhrase);
    }
  }

  getIdOperation(int busId) async {
    late List<Map<String, dynamic>> operationList;
    bool start;
    int operationId = 0;

    var request = http.Request('GET', Uri.parse('${Clients().url}/operation'));

    request.body = '''''';

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      operationList = jsonDecode(response.body).cast<Map<String, dynamic>>();

      //バスのIDが一致しているものを全部取り出す
      operationList.forEach((element) {
        if (element['bus']['id'] == busId) {
          businfoList.add(element);
          print(businfoList);
        }
      });

      operationId = businfoList[businfoList.length - 1]['id'];

      print("成功");
      return operationId;
    } else {
      print("失敗");
      return operationId;
    }
  }

  putOperation(int operationId, int busId, int count) async {
    var headers_ = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT', Uri.parse('${Clients().url}/operation/$operationId'));
    request.body = json.encode(
        {"start": true, "end": false, "bus_id": busId, "attendance": count});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  getCountOperation(int operationId) async {
    print("カウント取りに来ました");
    late Map<String, dynamic> operationMap;

    var request = http.Request(
        'GET', Uri.parse('${Clients().url}/operation/$operationId'));

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      operationMap = jsonDecode(response.body);
      print(jsonDecode(response.body));

      if (operationMap['attendance'] == null) {
        print("nullの時");
        return 0;
      }
      print(operationMap['attendance']);
      return operationMap['attendance'];
    } else {
      print(response.reasonPhrase);
    }
  }
}
