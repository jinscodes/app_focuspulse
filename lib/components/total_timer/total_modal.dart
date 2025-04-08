import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/providers/time_provider.dart';

void totalModal(BuildContext context, WidgetRef ref) {
  int selectedTime = 1;

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
                  "$selectedTime minutes",
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
                  max: 60,
                  divisions: 59,
                  label: "$selectedTime",
                  activeColor: AppColors.fontbrown,
                  inactiveColor: Colors.grey,
                  onChanged: (double value) {
                    setState(() {
                      selectedTime = value.toInt();
                    });
                  },
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    ref.read(totalProvider.notifier).state = selectedTime;
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
