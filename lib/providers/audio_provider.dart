import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioProvider = StateProvider<bool>((ref) {
  return false;
});

final audioNameProvider = StateProvider<String>((ref) {
  return 'Fan';
});
