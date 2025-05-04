import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/2v/time_provider.dart';
import 'package:focuspulse/colors.dart';

void sBreakModal(BuildContext context, WidgetRef ref) {
  double selectedTime = 1.0;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(20.w),
            width: double.infinity,
            height: 300.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Timer Settings",
                  style: TextStyle(
                    fontFamily: 'howdy_duck',
                    fontSize: 18.sp,
                    color: AppColors.fontbrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "${selectedTime.toInt()} minutes",
                  style: TextStyle(
                    fontFamily: 'howdy_duck',
                    fontSize: 24.sp,
                    color: AppColors.fontbrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Slider(
                  value: selectedTime.toDouble(),
                  min: 1,
                  max: 30,
                  divisions: 6,
                  label: "${selectedTime.toInt()}",
                  activeColor: AppColors.fontbrown,
                  inactiveColor: Colors.grey,
                  onChanged: (double value) {
                    setState(() {
                      selectedTime = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    ref.read(shortbreakProvider.notifier).state = selectedTime;
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.fontbrown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Set Timer",
                    style: TextStyle(
                      fontFamily: 'howdy_duck',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
