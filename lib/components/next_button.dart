import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class NextButton extends ConsumerWidget {
  final VoidCallback onNext;

  const NextButton(this.onNext, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
          child: Text(
            "Got it",
            style: TextStyle(
              fontFamily: 'spaceGrotesk',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.bgWhite,
            ),
          ),
        ),
      ),
    );
  }
}
