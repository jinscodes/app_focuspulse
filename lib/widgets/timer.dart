import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focuspulse/colors.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.bgTimer,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.play_circle,
            size: 100.w,
            color: AppColors.timerbrown,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 80.h),
                  child: Column(
                    children: [
                      Text(
                        'STEP-Session1',
                        style: TextStyle(
                          fontFamily: 'howdy_duck',
                          fontSize: 20.sp,
                          color: AppColors.timerbrown,
                        ),
                      ),
                      Text(
                        '24:00',
                        style: TextStyle(
                          fontFamily: 'howdy_duck',
                          fontSize: 64.sp,
                          color: AppColors.timerbrown,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svg/heartbeat.svg',
                        width: 100.w,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 142.h,
                  decoration: BoxDecoration(
                    color: AppColors.timerbrown,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Noise',
                                style: TextStyle(
                                  fontFamily: 'howdy_duck',
                                  fontSize: 20.sp,
                                  color: AppColors.bgTimer,
                                ),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              width: 4.w,
                              // height: 110.h,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'Noise',
                                style: TextStyle(
                                  fontFamily: 'howdy_duck',
                                  fontSize: 20.sp,
                                  color: AppColors.bgTimer,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
