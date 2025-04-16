import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class NextButton extends ConsumerWidget {
  final VoidCallback onNext;

  const NextButton(this.onNext, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onNext,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.fontbrown,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 60.w,
          vertical: 15.h,
        ),
      ),
      child: Text(
        "NEXT",
        style: TextStyle(
          fontFamily: 'howdy_duck',
          fontSize: 20.sp,
          color: AppColors.bgBeige,
        ),
      ),
    );
  }
}
