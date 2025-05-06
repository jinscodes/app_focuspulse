// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:focuspulse/2v/components/show_session_complete_dialog.dart';
// import 'package:focuspulse/2v/time_provider.dart';
// import 'package:focuspulse/colors.dart';
// import 'package:focuspulse/models/format_timer.dart';
// import 'package:focuspulse/models/pause_audio.dart';
// import 'package:focuspulse/models/play_audo.dart';
// import 'package:focuspulse/providers/audio_provider.dart';
// import 'package:just_audio/just_audio.dart';

// class TimerScreen extends ConsumerStatefulWidget {
//   const TimerScreen({super.key});

//   @override
//   ConsumerState<TimerScreen> createState() => _TimerScreenState();
// }

// class _TimerScreenState extends ConsumerState<TimerScreen> {
//   late AudioPlayer _audioPlayer;
//   late double sessionTime;
//   late int total;
//   bool isTimerPlaying = false;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     sessionTime = ref.read(sessionProvider) * 60;
//     total = ref.read(totalProvider);
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void playTimer() {
//     if (_timer != null) return;

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (sessionTime <= 0) {
//         _timer?.cancel();
//         _timer = null;
//         showSessionCompleteDialog(context);
//       }

//       setState(() {
//         sessionTime--;
//         isTimerPlaying = true;
//       });
//     });
//   }

//   void pauseTimer() {
//     setState(() {
//       isTimerPlaying = false;
//     });

//     _timer?.cancel();
//     _timer = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final noise = ref.watch(audioNameProvider);
//     final isAudioPlaying = ref.watch(audioProvider);
//     // final test = ref.watch(stepsProvider);

//     return Scaffold(
//       backgroundColor: AppColors.bgTimer,
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           isTimerPlaying
//               ? IconButton(
//                   onPressed: pauseTimer,
//                   icon: Icon(
//                     Icons.pause_circle,
//                     size: 100.w,
//                     color: AppColors.timerbrown,
//                   ),
//                 )
//               : IconButton(
//                   onPressed: playTimer,
//                   icon: Icon(
//                     Icons.play_circle,
//                     size: 100.w,
//                     color: AppColors.timerbrown,
//                   ),
//                 ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 80.h),
//                   child: Column(
//                     children: [
//                       Text(
//                         'STEP-Session1',
//                         style: TextStyle(
//                           fontFamily: 'howdy_duck',
//                           fontSize: 20.sp,
//                           color: AppColors.timerbrown,
//                         ),
//                       ),
//                       Text(
//                         formatTime(sessionTime),
//                         style: TextStyle(
//                           fontFamily: 'howdy_duck',
//                           fontSize: 64.sp,
//                           color: AppColors.timerbrown,
//                         ),
//                       ),
//                       isTimerPlaying
//                           ? Image.asset(
//                               'assets/gifs/heartrate.gif',
//                               width: 100.w,
//                             )
//                           : SvgPicture.asset(
//                               'assets/svg/heartbeat.svg',
//                               width: 100.w,
//                             ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 152.h,
//                   decoration: BoxDecoration(
//                     color: AppColors.timerbrown,
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 18.h),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 'assets/svg/music.svg',
//                                 width: 20.w,
//                                 height: 20.h,
//                               ),
//                               SizedBox(width: 10.w),
//                               TextButton(
//                                 onPressed: () {
//                                   isAudioPlaying
//                                       ? pauseAudio(ref, _audioPlayer)
//                                       : playAudio(ref, _audioPlayer);
//                                 },
//                                 style: TextButton.styleFrom(
//                                   padding: EdgeInsets.zero,
//                                   minimumSize: const Size(0, 0),
//                                   tapTargetSize:
//                                       MaterialTapTargetSize.shrinkWrap,
//                                 ),
//                                 child: Text(
//                                   noise,
//                                   style: TextStyle(
//                                     fontFamily: 'howdy_duck',
//                                     fontSize: 14.sp,
//                                     color: AppColors.bgTimer,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               isAudioPlaying
//                                   ? Image.asset(
//                                       'assets/gifs/playing.gif',
//                                       width: 20.w,
//                                       height: 20.h,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : SizedBox(width: 20.w, height: 20.h),
//                             ],
//                           ),
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(2),
//                             child: Container(
//                               width: ScreenUtil().screenWidth * 0.9,
//                               height: 2.w,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             "Next step",
//                             style: TextStyle(
//                               fontFamily: 'howdy_duck',
//                               fontSize: 14.sp,
//                               color: AppColors.bgTimer,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
