import 'dart:convert';

import 'package:http/http.dart' as http;

mixin class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  postRequest(
    String url,
    Map data,
  ) async {
    Map<String, String> headers = {};
    // headers.addAll({'Content-Type': 'application/json'});

    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: headers);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }
}
