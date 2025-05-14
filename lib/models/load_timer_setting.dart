import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadTimerSetting() async {
  final String jsonString =
      await rootBundle.loadString('assets/json/timer_setting.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
}
