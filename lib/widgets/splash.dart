import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/clear_audio_cache.dart';
import 'package:focuspulse/widgets/intro.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Future<void> clearAllData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  // }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Intro(),
        ),
      );
    });

    clearAudioCache();
    // clearAllData();

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_splashscreen.png",
              width: 200.w,
              height: 200.h,
            )
          ],
        ),
      ),
    );
  }
}
