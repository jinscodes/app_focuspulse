import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class StepSlide extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onNext;

  const StepSlide({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontFamily: 'howdy_duck',
            fontSize: 40.sp,
            color: AppColors.fontbrown,
          ),
        ),
        SizedBox(height: 15.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'howdy_duck',
              fontSize: 20,
              color: AppColors.fontbrown,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Image.asset(
          imagePath,
          width: 300.w,
          height: 300.h,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.fontbrown,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 20,
            ),
          ),
          child: const Text(
            "NEXT",
            style: TextStyle(
              fontFamily: 'howdy_duck',
              fontSize: 20,
              color: AppColors.bgBeige,
            ),
          ),
        ),
      ],
    );
  }
}
