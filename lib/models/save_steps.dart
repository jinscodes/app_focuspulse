import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/providers/time_provider.dart';

List<String> createStepList(WidgetRef ref) {
  List<String> sequence = [];
  final rep = ref.read(repetitionProvider);
  final total = ref.read(totalProvider);

  for (int r = 0; r < rep; r++) {
    for (int i = 0; i < total; i++) {
      sequence.add("session");
      bool isLastSession = (i == total - 1);
      bool isLastRepetition = (r == rep - 1);

      if (isLastSession && !isLastRepetition) {
        sequence.add("long_break");
      } else if (!isLastSession) {
        sequence.add("short_break");
      }
    }
  }

  return sequence;
}

void removeStepFromList() {}
