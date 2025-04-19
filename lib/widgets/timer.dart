import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/providers/audio_provider.dart';
import 'package:focuspulse/providers/time_provider.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    final noise = ref.watch(audioNameProvider);
    final session = ref.watch(sessionProvider);

    String formatTime(int minutes) {
      final int seconds = minutes * 60;
      final int displayMinutes = seconds ~/ 60;
      final int displaySeconds = seconds % 60;
      return '${displayMinutes.toString().padLeft(2, '0')}:${displaySeconds.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      backgroundColor: AppColors.bgTimer,
      body: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: () => {print("you pressed the button")},
            icon: Icon(
              Icons.play_circle,
              size: 100.w,
              color: AppColors.timerbrown,
            ),
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
                        formatTime(session),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/music.svg',
                                width: 20.w,
                                height: 20.h,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                noise,
                                style: TextStyle(
                                  fontFamily: 'howdy_duck',
                                  fontSize: 14.sp,
                                  color: AppColors.bgTimer,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: 10.w),
                              Image.asset(
                                'assets/gifs/playing.gif',
                                width: 20.w,
                                height: 20.h,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              height: 2.w,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Next step",
                            style: TextStyle(
                              fontFamily: 'howdy_duck',
                              fontSize: 14.sp,
                              color: AppColors.bgTimer,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
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
