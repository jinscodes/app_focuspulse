import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class TimerCard extends StatelessWidget {
  final bool isSelected;
  final String imagePath;
  final VoidCallback onTap;

  const TimerCard({
    super.key,
    required this.isSelected,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 1.sw,
        height: 100.h,
        child: Card(
          color: AppColors.bgBeige,
          margin: EdgeInsets.only(bottom: 20.h),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(
              color: isSelected ? AppColors.fontbrown : AppColors.borderbrown,
              width: 3,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Image.asset(
                  imagePath,
                  height: 50.h,
                ),
              ),
              Positioned(
                right: 16.w,
                child: Icon(
                  Icons.check_rounded,
                  size: 24.w,
                  color: isSelected
                      ? AppColors.checkedGreen
                      : AppColors.uncheckedGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
