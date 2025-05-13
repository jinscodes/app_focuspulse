import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focuspulse/colors.dart';

class SoundCard extends StatelessWidget {
  final bool isSelected;
  final String imagePath;
  final String name;
  final VoidCallback onTap;

  const SoundCard({
    super.key,
    required this.isSelected,
    required this.imagePath,
    required this.name,
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
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/$imagePath.svg',
                  height: 30.h,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.fontbrown : AppColors.soundBrown,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'howdy_duck',
                    color:
                        isSelected ? AppColors.fontbrown : AppColors.soundBrown,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
