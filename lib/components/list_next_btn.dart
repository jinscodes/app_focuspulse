import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class ListNextBtn extends ConsumerWidget {
  final VoidCallback navigateToNextScreen;

  const ListNextBtn(this.navigateToNextScreen, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => navigateToNextScreen(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.fontbrown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        minimumSize: Size(1.sw, 55.h),
      ),
      child: const Text(
        "Next",
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'howdy_duck',
          color: AppColors.bgBeige,
        ),
      ),
    );
  }
}
