import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class NormalTimer extends ConsumerStatefulWidget {
  const NormalTimer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NormalTimerState();
}

class _NormalTimerState extends ConsumerState<NormalTimer> {
  int remainingSeconds = 0;
  Timer? timer;

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          t.cancel();
        }
      });
    });
  }

  Future<void> _showDurationPicker(BuildContext context) async {
    Duration tempDuration = Duration(seconds: remainingSeconds);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              'Set Timer',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "space_grotesk",
              ),
            ),
          ),
          content: SizedBox(
            height: 180.h,
            width: 0.9.sw,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hms,
              initialTimerDuration: tempDuration,
              onTimerDurationChanged: (Duration newDuration) {
                tempDuration = newDuration;
              },
            ),
          ),
          actions: [
            SizedBox(height: 10.h),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "space_grotesk",
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (tempDuration.inSeconds > 0) {
                  setState(() {
                    remainingSeconds = tempDuration.inSeconds;
                  });
                }
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "space_grotesk",
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      remainingSeconds = 0;
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
        title: Text(
          'Timer',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Timer",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "space_grotesk",
                    ),
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
                          "No Session",
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
                          "No Duration",
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
              GestureDetector(
                onTap: () => _showDurationPicker(context),
                child: Row(
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
              ),
              SizedBox(height: 36.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(84.w, 40.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "space_grotesk",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgGray,
                      minimumSize: Size(84.w, 40.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      'Reset',
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
      ),
    );
  }
}
