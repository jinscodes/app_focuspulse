import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/repetition_timer/repetition_modal.dart';
import 'package:focuspulse/providers/time_provider.dart';

class RepetitionBox extends ConsumerWidget {
  const RepetitionBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repTime = ref.watch(repetitionProvider);

    return GestureDetector(
      onTap: () {
        repetitionModal(context, ref);
      },
      child: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.bgBeige,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.borderbrown,
            width: 3.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "REPETITION",
              style: TextStyle(
                fontFamily: "howdy_duck",
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.fontbrown,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '$repTime',
              style: TextStyle(
                fontFamily: 'howdy_duck',
                fontSize: 20.sp,
                color: AppColors.fontbrown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
