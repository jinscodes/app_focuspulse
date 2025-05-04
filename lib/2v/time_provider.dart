import 'package:flutter_riverpod/flutter_riverpod.dart';

final repetitionProvider = StateProvider<double>((ref) {
  return 1.0;
});

final totalProvider = StateProvider<int>((ref) {
  return 1;
});

final sessionProvider = StateProvider<double>((ref) {
  return 1.0;
});

final shortbreakProvider = StateProvider<double>((ref) {
  return 1.0;
});

final longbreakProvider = StateProvider<double>((ref) {
  return 1.0;
});
