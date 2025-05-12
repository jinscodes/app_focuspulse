import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/list_next_btn.dart';
import 'package:focuspulse/components/list_title.dart';
import 'package:focuspulse/components/timer_card.dart';
import 'package:focuspulse/providers/process_provider.dart';
import 'package:focuspulse/widgets/noise_list.dart';

class TimerList extends ConsumerStatefulWidget {
  const TimerList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimerListState();
}

class _TimerListState extends ConsumerState<TimerList> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> timerList = [
      {"path": 'assets/images/toeic.png', "key": 'toeic'},
      {"path": 'assets/images/toefl.png', "key": 'toefl'},
      {"path": 'assets/images/opic.png', "key": 'opic'},
      {"path": 'assets/images/ielts.png', "key": 'ielts'},
      {"path": 'assets/images/teps.png', "key": 'teps'},
      {"path": 'assets/images/det.png', "key": 'det'},
    ];

    void navigateToNextScreen() {
      ref.read(timerProvider.notifier).update((state) {
        return {
          ...state,
          'timer': timerList[selectedIndex!]['key']!,
        };
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NoiseList(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgBeige,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              const ListTitle('Timer List', 'assets/images/timer.png'),
              SizedBox(height: 30.h),
              SizedBox(
                height: 500.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: timerList.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;

                    return TimerCard(
                      isSelected: isSelected,
                      imagePath: timerList[index]['path']!,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 60.h),
              ListNextBtn(navigateToNextScreen),
            ],
          ),
        ),
      ),
    );
  }
}
