import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/widgets/timer_list.dart';
import 'package:focuspulse/widgets/timer_step_description.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void navigateToNextScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TimerList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimerStepDescription(
        'STEP1',
        'Choose your test type',
        navigateToNextScreen,
      ),
    );
  }
}
