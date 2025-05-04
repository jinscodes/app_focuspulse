import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class StartButton extends ConsumerWidget {
  final String title;
  final VoidCallback onPressed;

  const StartButton(this.title, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.playerbrown,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 60.w,
          vertical: 10.h,
        ),
      ),
      child: Text(
        "START",
        style: TextStyle(
          fontFamily: 'howdy_duck',
          fontSize: 15.sp,
          color: AppColors.bgBeige,
        ),
      ),
    );
  }
}
