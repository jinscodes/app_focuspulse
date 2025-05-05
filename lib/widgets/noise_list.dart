import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/providers/process_provider.dart';

class NoiseList extends ConsumerStatefulWidget {
  const NoiseList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoiseListState();
}

class _NoiseListState extends ConsumerState<NoiseList> {
  @override
  void initState() {
    super.initState();
    print(ref.read(timerProvider)['timer']);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bgBeige,
    );
  }
}
