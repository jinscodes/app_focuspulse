import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/pause_audio.dart';
import 'package:focuspulse/models/play_audo.dart';
import 'package:focuspulse/providers/audio_provider.dart';
import 'package:focuspulse/providers/time_provider.dart';
import 'package:just_audio/just_audio.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  late AudioPlayer _audioPlayer;
  bool isTimerPlaying = true;
  Timer? _timer;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentSession = ref.read(sessionProvider);
      if (currentSession > 0) {
        ref.read(sessionProvider.notifier).state--;
      } else {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  String formatTime(int minutes) {
    Duration duration = Duration(seconds: minutes * 60);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    final noise = ref.watch(audioNameProvider);
    final session = ref.watch(sessionProvider) * 60;
    final isMusicPlaying = ref.watch(audioProvider);

    void playTimer() {
      setState(() {
        isTimerPlaying = false;
      });
      startTimer();
    }

    void pauseTimer() {
      setState(() {
        isTimerPlaying = true;
      });
      stopTimer();
    }

    return Scaffold(
      backgroundColor: AppColors.bgTimer,
      body: Stack(
        alignment: Alignment.center,
        children: [
          isTimerPlaying
              ? IconButton(
                  onPressed: playTimer,
                  icon: Icon(
                    Icons.pause_circle,
                    size: 100.w,
                    color: AppColors.timerbrown,
                  ),
                )
              : IconButton(
                  onPressed: pauseTimer,
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
                        // formatTime(session),
                        '$session',
                        style: TextStyle(
                          fontFamily: 'howdy_duck',
                          fontSize: 64.sp,
                          color: AppColors.timerbrown,
                        ),
                      ),
                      isTimerPlaying
                          ? Image.asset(
                              'assets/gifs/heartrate.gif',
                              width: 100.w,
                            )
                          : SvgPicture.asset(
                              'assets/svg/heartbeat.svg',
                              width: 100.w,
                            ),
                    ],
                  ),
                ),
                Container(
                  height: 152.h,
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
                              TextButton(
                                onPressed: () {
                                  isMusicPlaying
                                      ? pauseAudio(ref, _audioPlayer)
                                      : playAudio(ref, _audioPlayer);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  noise,
                                  style: TextStyle(
                                    fontFamily: 'howdy_duck',
                                    fontSize: 14.sp,
                                    color: AppColors.bgTimer,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              isMusicPlaying
                                  ? Image.asset(
                                      'assets/gifs/playing.gif',
                                      width: 20.w,
                                      height: 20.h,
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox(width: 20.w, height: 20.h),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              width: ScreenUtil().screenWidth * 0.9,
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
