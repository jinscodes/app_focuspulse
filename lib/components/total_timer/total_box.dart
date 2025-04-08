import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/total_timer/total_modal.dart';
import 'package:focuspulse/providers/time_provider.dart';

class TotalBox extends ConsumerWidget {
  const TotalBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalTime = ref.watch(totalProvider);

    return GestureDetector(
      onTap: () {
        totalModal(context, ref);
      },
      child: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
              "TITLE",
              style: TextStyle(
                fontFamily: "sebino",
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.fontbrown,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '$totalTime',
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
