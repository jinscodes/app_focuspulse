// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/blink_btn.dart';
import 'package:focuspulse/components/timer_skip_dialog.dart';
import 'package:focuspulse/components/title_appbar.dart';
import 'package:focuspulse/models/load_timer_setting.dart';
import 'package:focuspulse/models/prepare_steps.dart';
import 'package:focuspulse/widgets/record.dart';

class TimerScreen extends ConsumerStatefulWidget {
  final String? testKey;
  final String? soundKey;

  const TimerScreen({this.testKey, this.soundKey, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimerState();
}

class _TimerState extends ConsumerState<TimerScreen> {
  late String _testKey;
  late String _soundKey;
  int currentStep = 0;
  List<Map<String, dynamic>> steps = [];
  int remainingSeconds = 0;
  Timer? timer;
  bool isRunning = false;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    _testKey = widget.testKey ?? '';
    _soundKey = widget.soundKey ?? '';
  }

  void startTimer() {
    timer?.cancel();
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          t.cancel();
          isRunning = false;
          if (currentStep < steps.length - 1) {
            showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 12.h),
                      Text(
                        'Session ended',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "space_grotesk",
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        'Your session has ended. Would you like to continue?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "space_grotesk",
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bgGray,
                              minimumSize: Size(0.4.sw, 40.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: Text(
                              'Stop',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "space_grotesk",
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                currentStep++;
                                remainingSeconds =
                                    steps[currentStep]['duration'];
                              });
                              startTimer();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: Size(0.4.sw, 40.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "space_grotesk",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            isFinished = true;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('All sessions complete!')),
            );
          }
        }
      });
    });
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void skipToNextStep() async {
    if (currentStep < steps.length - 1) {
      final confirm = await timerSkipDialog(context);
      if (confirm == true) {
        if (currentStep == steps.length - 1) {
          setState(() {
            remainingSeconds = 0;
            isFinished = true;
          });
          timer?.cancel();
        } else {
          setState(() {
            currentStep++;
            remainingSeconds = steps[currentStep]['duration'];
          });
          timer?.cancel();
          startTimer();
        }
      }
    } else {
      setState(() {
        remainingSeconds = 0;
        isFinished = true;
      });
      timer?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All sessions complete!')),
      );
    }
  }

  void goToRecordScreen(BuildContext context) async {
    final sessionList = steps.where((e) => e['label'] != 'Break').toList();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecordScreen(
          sessions: sessionList,
          testKey: _testKey,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: titleAppbar(context, Icon(Icons.arrow_back, size: 24.w), "title"),
      body: FutureBuilder(
        future: loadTimerSetting(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final timerData = snapshot.data!.firstWhere(
            (item) => item['key'] == _testKey,
            orElse: () => {},
          );
          final String timerKey = timerData['key'] ?? '';

          if (steps.isEmpty && timerData.isNotEmpty) {
            prepareSteps(steps, timerData, remainingSeconds);
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        timerKey.isEmpty ? 'Timer' : timerKey.toUpperCase(),
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "space_grotesk",
                        ),
                      ),
                      BlinkingIconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.music_note,
                          size: 24.w,
                        ),
                        soundKey: _soundKey,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Session & Duration",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "space_grotesk",
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 0.45.sw,
                        height: 56.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.borderGray,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Text(
                              timerData.isEmpty
                                  ? "No Session"
                                  : steps[currentStep]['label'],
                              style: TextStyle(
                                color: AppColors.fontGray,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "space_grotesk",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 0.45.sw,
                        height: 56.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.borderGray,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Text(
                              timerData.isEmpty
                                  ? "No Duration"
                                  : "${(steps[currentStep]['duration'] / 60).toInt()}",
                              style: TextStyle(
                                color: AppColors.fontGray,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "space_grotesk",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36.h),
                  timerData.isEmpty
                      ? Text(
                          timerData.toString(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 0.29.sw,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.bgGray,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (remainingSeconds ~/ 3600)
                                          .toString()
                                          .padLeft(2, '0'),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "space_grotesk",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "Hours",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "space_grotesk",
                                    color: AppColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 0.29.sw,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.bgGray,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ((remainingSeconds % 3600) ~/ 60)
                                          .toString()
                                          .padLeft(2, '0'),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "space_grotesk",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "Minutes",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "space_grotesk",
                                    color: AppColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 0.29.sw,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.bgGray,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (remainingSeconds % 60)
                                          .toString()
                                          .padLeft(2, '0'),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "space_grotesk",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "Seconds",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "space_grotesk",
                                    color: AppColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  SizedBox(height: 36.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: isRunning ? pauseTimer : startTimer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: Size(84.w, 40.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Text(
                          isRunning ? 'Pause' : 'Start',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "space_grotesk",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: isFinished
                            ? () => goToRecordScreen(context)
                            : () => skipToNextStep(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFinished
                              ? Colors.greenAccent
                              : AppColors.bgGray,
                          minimumSize: Size(84.w, 40.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Text(
                          isFinished ? "Save" : 'Skip',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "space_grotesk",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
