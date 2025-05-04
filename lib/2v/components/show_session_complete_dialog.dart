// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

Future<void> showSessionCompleteDialog(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 1));

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: AppColors.bgTimer,
      content: SizedBox(
        width: 300.w,
        height: 320.h,
        child: Column(
          children: [
            SizedBox(height: 22.h),
            Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.dialogBrown,
              size: 60.w,
            ),
            SizedBox(height: 22.h),
            Text(
              "SESSION COMPLETE",
              style: TextStyle(
                fontFamily: 'howdy_duck',
                fontSize: 22.sp,
                color: AppColors.dialogBrown,
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              "You finished STEP Session 1",
              style: TextStyle(
                fontFamily: 'howdy_duck',
                fontSize: 12.sp,
                color: AppColors.dialogBrown,
              ),
            ),
            SizedBox(height: 25.h),
            SizedBox(
              width: 250.w,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.dialogBtnBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Short Break',
                  style: TextStyle(
                    fontFamily: 'howdy_duck',
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 250.w,
              height: 50.h,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontFamily: 'howdy_duck',
                    fontSize: 14.sp,
                    color: AppColors.dialogBrown,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
