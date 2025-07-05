// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/blink_btn.dart';
import 'package:focuspulse/models/load_timer_setting.dart';

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

  @override
  void initState() {
    super.initState();
    _testKey = widget.testKey ?? '';
    _soundKey = widget.soundKey ?? '';
  }

  void prepareSteps(Map<String, dynamic> timerData) {
    steps.clear();
    final List sessions = timerData['session'] ?? [];
    final List breaks = timerData['break'] ?? [];
    for (int i = 0; i < sessions.length; i++) {
      final session = sessions[i];
      final label = session.keys.first;
      final duration = session.values.first * 60;
      steps.add({'label': label, 'duration': duration});
      if (i < sessions.length - 1 && breaks.isNotEmpty) {
        steps.add({'label': 'Break', 'duration': breaks[0] * 60});
      }
    }
    if (steps.isNotEmpty) {
      remainingSeconds = steps[0]['duration'];
    }
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('All sessions complete!')),
            );
          }
        }
      });
    });
  }

  void skipToNextStep() async {
    if (currentStep < steps.length - 1) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              'Skip Step',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "space_grotesk",
              ),
            ),
          ),
          content: Text(
            'Are you sure you want to skip to the next step?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              fontFamily: "space_grotesk",
            ),
          ),
          actions: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(0.32.sw, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(0.32.sw, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      if (confirm == true) {
        setState(() {
          currentStep++;
          remainingSeconds = steps[currentStep]['duration'];
        });
        timer?.cancel();
        startTimer();
      }
    } else {
      remainingSeconds = 0;
      timer?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All sessions complete!')),
      );
    }
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Timer',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
            prepareSteps(timerData);
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
                        onPressed: () => skipToNextStep(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bgGray,
                          minimumSize: Size(84.w, 40.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Text(
                          'Done',
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
