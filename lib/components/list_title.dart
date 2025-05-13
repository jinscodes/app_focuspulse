import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class ListTitle extends ConsumerWidget {
  final String title;
  final String description;

  const ListTitle(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 40.sp,
            fontFamily: 'howdy_duck',
            color: AppColors.fontbrown,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'howdy_duck',
            color: AppColors.fontbrown,
          ),
        )
      ],
    );
  }
}
