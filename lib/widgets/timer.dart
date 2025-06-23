// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/show_temporary_dialog.dart';
import 'package:focuspulse/models/getMatchingTimerSetting.dart';
import 'package:focuspulse/providers/process_provider.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimerState();
}

class _TimerState extends ConsumerState<TimerScreen> {
  List<Map<String, dynamic>> steps = [];
  int remainingSeconds = 0;
  Timer? _timer;
  int currentIndex = 0;
  String currentLabel = "";
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
        prepareSteps();
      });
    }
  }

  void prepareSteps() {
    final session = matchedData?['session'] ?? [];
    final breakTime = matchedData?['break'] ?? [];

    steps = [];
    for (int i = 0; i < session.length; i++) {
      final item = session[i] as Map;
      item.forEach((label, minutes) {
        steps.add({
          'label': label,
          'duration': minutes * 60,
        });
      });

      if (i < session.length - 1 && breakTime.isNotEmpty) {
        steps.add({
          'label': 'Break',
          'duration': breakTime[0] * 60,
        });
      }
    }

    if (steps.isNotEmpty) {
      currentLabel = steps[0]['label'];
      remainingSeconds = steps[0]['duration'];
    }
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        moveToNextStep();
      }
    });
  }

  void moveToNextStep() async {
    if (currentIndex + 1 < steps.length) {
      final next = steps[currentIndex + 1];
      await showTemporaryDialog(context, "${next['label']} is starting soon!",
          durationSeconds: 4);
      setState(() {
        currentIndex++;
        currentLabel = steps[currentIndex]['label'];
        remainingSeconds = steps[currentIndex]['duration'];
      });
      startTimer();
    } else {
      setState(() {
        currentLabel = "Done!";
        remainingSeconds = 0;
      });
    }
  }

  String formatMMSS(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  String formatCountdown(int seconds) {
    final duration = Duration(seconds: seconds);
    return formatMMSS(duration);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentLabel,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Text(
              formatCountdown(remainingSeconds),
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: const Text('Start Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
