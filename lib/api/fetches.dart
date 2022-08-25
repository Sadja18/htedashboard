import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchSelectorBaseRecords() async {
  if (kDebugMode) {
    log('seletiob ');
  }
  try {
    if (kDebugMode) {
      log('sending');
    }
    Map<String, String> queryParams = {"permit": "sadjaBase"};
    var response = await http.get(
      Uri(
          scheme: 'http',
          host: "localhost",
          path: "/api/fetchdcvc.php",
          queryParameters: queryParams),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );

    if (kDebugMode) {
      log('receiving');
      log(response.statusCode.toString());
      // log(response.body);
    }
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body['message'] != null &&
          body['message'].toString().toLowerCase() == 'success') {
        var data = body['re'];
        if (kDebugMode) {
          log("message");
          log(data.toString());
        }

        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
      log("${e is SocketException}");
      log("message");
    }
    return null;
  }
}
