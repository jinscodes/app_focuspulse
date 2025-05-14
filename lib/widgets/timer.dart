// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/models/getMatchingTimerSetting.dart';
import 'package:focuspulse/providers/process_provider.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimerState();
}

class _TimerState extends ConsumerState<TimerScreen> {
  Map<String, dynamic>? matchedData;
  String? timerKey;

  @override
  void initState() {
    super.initState();
    fetchMatchingTimerSetting();
    timerKey = ref.read(timerProvider.notifier).state['timerKey'];
  }

  Future<void> fetchMatchingTimerSetting() async {
    var timerKey = ref.read(timerProvider.notifier).state['timerKey'];
    if (timerKey != null) {
      final result = await getMatchingTimerSetting(timerKey);
      setState(() {
        matchedData = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('--------------------');
    print(timerKey);
    print(matchedData);
    print('--------------------');

    return const Scaffold();
  }
}
