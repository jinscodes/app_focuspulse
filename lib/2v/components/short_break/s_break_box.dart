import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/2v/components/short_break/s_break_modal.dart';
import 'package:focuspulse/2v/time_provider.dart';
import 'package:focuspulse/colors.dart';

class SBreakBox extends ConsumerWidget {
  const SBreakBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortbreakTime = ref.watch(shortbreakProvider);

    return GestureDetector(
      onTap: () {
        sBreakModal(context, ref);
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
              "SHORT BREAK",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "howdy_duck",
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.fontbrown,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${shortbreakTime.toInt()}',
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
