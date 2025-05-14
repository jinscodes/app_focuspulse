import 'package:focuspulse/models/load_timer_setting.dart';

dynamic getMatchingTimerSetting(String timerKey) async {
  final List timerSettings = await loadTimerSetting();

  for (var key in timerSettings) {
    if (key['key'] == timerKey) {
      return key;
    }
  }
}
