import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/2v/time_provider.dart';
import 'package:focuspulse/providers/process_provider.dart';

void createStepList(WidgetRef ref) {
  final rep = ref.read(repetitionProvider);
  final total = ref.read(totalProvider);

  for (int r = 0; r < rep; r++) {
    for (int i = 0; i < total; i++) {
      ref.read(stepsProvider.notifier).state.add("session");
      bool isLastSession = (i == total - 1);
      bool isLastRepetition = (r == rep - 1);

      if (isLastSession && !isLastRepetition) {
        ref.read(stepsProvider.notifier).state.add("long_break");
      } else if (!isLastSession) {
        ref.read(stepsProvider.notifier).state.add("short_break");
      }
    }
  }
}

void removeStepFromList(WidgetRef ref) {
  final steps = ref.read(stepsProvider.notifier).state;

  if (steps.isNotEmpty) {
    ref.read(stepsProvider.notifier).state = [...steps]..removeAt(0);
  }
}
