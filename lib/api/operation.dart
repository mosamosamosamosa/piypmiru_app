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

      if (businfoList[businfoList.length - 1]['start'] == true) {
        start = true;
      } else {
        {
          start = false;
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
    var request = http.Request('POST', Uri.parse('${Clients().url}/operation'));
    request.body = json.encode({"start": start, "end": end, "bus_id": busId});
    request.headers.addAll(headers);

    http.StreamedResponse stream_response = await request.send();
    var response = await http.Response.fromStream(stream_response);

    if (response.statusCode == 200) {
      print("成功");
    } else {
      print(response.reasonPhrase);
    }
  }
}
