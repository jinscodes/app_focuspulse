void prepareSteps(List<Map<String, dynamic>> steps,
    Map<String, dynamic> timerData, int remainingSeconds) {
  steps.clear();
  final List sessions = timerData['session'] ?? [];
  final List breaks = timerData['break'] ?? [];
  for (int i = 0; i < sessions.length; i++) {
    final session = sessions[i];
    final label = session.keys.first;
    final duration = session.values.first * 60;
    steps.add({'label': label, 'duration': duration});
    if (i < sessions.length - 1 && breaks.isNotEmpty) {
      steps.add({'label': 'Break', 'duration': breaks[0] * 60});
    }
  }
  if (steps.isNotEmpty) {
    remainingSeconds = steps[0]['duration'];
  }
}
