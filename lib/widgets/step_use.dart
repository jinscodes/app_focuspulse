import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class StepUse extends StatelessWidget {
  const StepUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBeige,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "USE ",
              style: TextStyle(
                fontFamily: 'howdy_duck',
                fontSize: 40.sp,
                color: AppColors.fontbrown,
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: const Text(
                "Choose a task that you need to complete",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'howdy_duck',
                  fontSize: 20,
                  color: AppColors.fontbrown,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Image.asset(
              "assets/images/step1.png",
              width: 300.w,
              height: 300.h,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StepUse(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.fontbrown,
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
            )
          ],
        ),
      ),
    );
  }
}
