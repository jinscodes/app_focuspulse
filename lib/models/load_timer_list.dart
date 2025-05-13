import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<Map<String, String>>> loadTimerList() async {
  final String jsonString =
      await rootBundle.loadString('assets/json/timer_list.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => Map<String, String>.from(item)).toList();
}
