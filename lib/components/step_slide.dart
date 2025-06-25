import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/components/next_button.dart';

class StepSlide extends StatelessWidget {
  final String description;
  final String imagePath;
  final VoidCallback onNext;

  const StepSlide({
    super.key,
    required this.description,
    required this.imagePath,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            imagePath,
            width: 330.w,
            height: 500.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'space_grotesk',
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
            ),
          ),
        ),
        SizedBox(height: 80.h),
        NextButton(onNext),
      ],
    );
  }
}
