import 'package:flutter_riverpod/flutter_riverpod.dart';

final stepsProvider = StateProvider<List<String>>((ref) {
  return [];
});

final currentStepProvider = StateProvider<String>((ref) {
  return '';
});
