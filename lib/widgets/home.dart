import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/quick_access_sounds.dart';
import 'package:focuspulse/components/quick_access_timers.dart';
import 'package:focuspulse/components/title_appbar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      // appBar: AppBar(
      //   backgroundColor: AppColors.bgWhite,
      //   elevation: 0,
      //   title: Text(
      //     'FocusPulse',
      //     style: TextStyle(
      //       fontSize: 18.sp,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      appBar: titleAppbar(context, null, "FocusPulse"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome to Test Timer!",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'space_grotesk',
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Select your test and sound to start the timer.",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'space_grotesk',
                ),
              ),
              SizedBox(height: 32.h),
              const QuickAccessTimers(),
              SizedBox(height: 12.h),
              const QuickAccessSounds(),
            ],
          ),
        ),
      ),
    );
  }
}
