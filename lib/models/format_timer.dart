String formatTime(double time) {
  Duration duration = Duration(seconds: time.toInt());
  return duration.toString().split('.').first.substring(2, 7);
}
