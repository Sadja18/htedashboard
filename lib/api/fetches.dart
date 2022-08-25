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
      log(response.body);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        log('here 2');
      }
      var body = jsonDecode(response.body);
      if (kDebugMode) {
        log('here3');
      }
      if (body['message'] != null &&
          body['message'].toString().toLowerCase() == 'success') {
        var data = body['data'];
        if (kDebugMode) {
          log("message");
          log(data.toString());
        }

        Map<String, List<Map<int, String>>> records = {
          "colleges": [],
          "blocks": [],
          "clusters": [],
          "cities": [],
        };
        for (var entry in data) {
          Map<int, String> collegeTmp = {};
          Map<int, String> blockTmp = {};
          Map<int, String> clusterTmp = {};
          Map<int, String> cityTmp = {};

          collegeTmp[entry['id']] = entry['name'];

          records['colleges']?.add(collegeTmp);

          if (entry['block'] != false && entry['block'].isNotEmpty) {
            blockTmp[entry['block'][0]] = entry['block'][1];

            records['blocks']?.add(blockTmp);
          }
          if (entry['cluster'] != false && entry['cluster'].isNotEmpty) {
            clusterTmp[entry['cluster'][0]] = entry['cluster'][1];
            records['clusters']?.add(clusterTmp);
          }
          if (entry['city'] != false && entry['city'].isNotEmpty) {
            cityTmp[entry['city'][0]] = entry['city'][1];
            records['cities']?.add(cityTmp);
          }
        }

        if (kDebugMode) {
          print(records['cities']?[0].values.toString());
        }

        return records;
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
