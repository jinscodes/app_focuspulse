import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class ListTitle extends ConsumerWidget {
  final String title;
  final String imgPath;

  const ListTitle(this.title, this.imgPath, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          height: 40.h,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontFamily: 'howdy_duck',
            color: AppColors.fontbrown,
          ),
        ),
      ],
    );
  }
}
