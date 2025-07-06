import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, Map<String, dynamic>>>> retrieveResult() async {
  final prefs = await SharedPreferences.getInstance();
  final allKeys = prefs.getKeys().where((key) => key.startsWith('record-'));

  List<Map<String, Map<String, dynamic>>> results = [];

  for (String key in allKeys) {
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString);
      if (decoded is Map<String, dynamic>) {
        results.add({key: decoded});
      }
    }
  }

  return results;
}
