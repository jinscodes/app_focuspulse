import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/list_next_btn.dart';

class TimerStepDescription extends ConsumerWidget {
  final String step;
  final String description;
  final VoidCallback onNext;

  const TimerStepDescription(this.step, this.description, this.onNext,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.bgBeige,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 46.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Text(
                  step,
                  style: const TextStyle(
                    fontFamily: 'howdy_duck',
                    fontSize: 40,
                    color: AppColors.fontbrown,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'howdy_duck',
                    fontSize: 20,
                    color: AppColors.fontbrown,
                  ),
                ),
              ],
            ),
            ListNextBtn(onNext),
          ],
        ),
      ),
    );
  }
}
