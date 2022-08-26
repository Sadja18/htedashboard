import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<dynamic> readCoordinates() async {
  try {
    final String baseInfoString =
        await rootBundle.loadString('assets/base_info.json');

    final decodedData = jsonDecode(baseInfoString);

    final baseInfo = decodedData['data'];

    if (baseInfo != null && baseInfo.isNotEmpty) {
      if (kDebugMode) {
        print(baseInfo);
      }
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}
