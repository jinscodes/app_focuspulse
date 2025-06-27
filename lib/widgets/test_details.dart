import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/load_timer_setting.dart';

class TestDetailsScreen extends ConsumerStatefulWidget {
  final String testKey;

  const TestDetailsScreen(this.testKey, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestDetailsState();
}

class _TestDetailsState extends ConsumerState<TestDetailsScreen> {
  late String testKey;

  @override
  void initState() {
    super.initState();
    testKey = widget.testKey;
  }

  @override
  Widget build(BuildContext context) {
    print(testKey);

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_outlined, size: 24.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Test Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadTimerSetting(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final timerSettings = snapshot.data!;
          final testData = timerSettings.firstWhere(
            (item) => item['key'] == testKey,
            orElse: () => {},
          );
          if (testData.isEmpty) {
            return const Center(child: Text('No data found for this test.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              testData.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
