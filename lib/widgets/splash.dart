import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/widgets/steps.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Steps(),
        ),
      );
    });

    return Scaffold(
      backgroundColor: AppColors.bgBeige,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 150.w,
              height: 120.h,
            )
          ],
        ),
      ),
    );
  }
}
