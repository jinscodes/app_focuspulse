import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/models/load_timer_setting.dart';
import 'package:focuspulse/widgets/test_details.dart';
import 'package:focuspulse/widgets/timer_list.dart';

class QuickAccessTimers extends ConsumerStatefulWidget {
  const QuickAccessTimers({super.key});

  @override
  ConsumerState<QuickAccessTimers> createState() => _QuickAccessTimersState();
}

class _QuickAccessTimersState extends ConsumerState<QuickAccessTimers> {
  void onClickItem(String testKey) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestDetailsScreen(testKey),
      ),
    );
  }

  void navigateToTimerList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TimerList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Test List",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () => navigateToTimerList(),
              icon: Icon(
                Icons.more_horiz,
                size: 24.w,
              ),
            ),
          ],
        ),
        FutureBuilder(
          future: loadTimerSetting(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final timerSettings = snapshot.data!;
            return Column(
              children: List.generate(3, (index) {
                final key = timerSettings[index]['key'];
                return Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minTileHeight: 56.h,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    title: Text(
                      key,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: 24.w,
                      color: Colors.grey,
                    ),
                    onTap: () => onClickItem(key),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
