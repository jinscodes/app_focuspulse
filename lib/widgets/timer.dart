// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              (item) => item['key'] == testKey,
              orElse: () => {},
            );

            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Center(
                child: Column(
                  children: [
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
                                    : timerData['key'] ?? '',
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
                        ),
                      ],
                    ),
                    timerData.isEmpty
                        ? Text(
                            timerData.toString(),
                          )
                        : const Text("data "),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
