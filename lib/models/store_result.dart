import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeResult(String key, Map<String, dynamic> map) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(map);
  await prefs.setString(key, jsonString);
}
