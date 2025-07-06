import 'package:shared_preferences/shared_preferences.dart';

Future<void> removeData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
