import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum IconType { arrow, close }

AppBar titleAppbar(BuildContext context, IconType icon, String title) {
  return AppBar(
    forceMaterialTransparency: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: icon == IconType.arrow
          ? Icon(Icons.arrow_back, size: 24.w)
          : Icon(Icons.close_outlined, size: 24.w),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
