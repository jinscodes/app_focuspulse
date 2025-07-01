// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/load_timer_setting.dart';

class TimerScreen extends ConsumerStatefulWidget {
  final String? testKey;

  const TimerScreen({this.testKey, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimerState();
}

class _TimerState extends ConsumerState<TimerScreen> {
  late String testKey;

  @override
  void initState() {
    super.initState();
    testKey = widget.testKey ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: FutureBuilder(
          future: loadTimerSetting(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final timerData = snapshot.data!.firstWhere(
              (item) => item['key'] == testKey,
              orElse: () => {},
            );

            if (timerData.isEmpty) {
              return const Center(child: Text('No data found for this test.'));
            }

            print(timerData);

            return Center(
              child: Text(
                timerData.toString(),
              ),
            );
          }),
    );
  }
}
