import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/list_next_btn.dart';
import 'package:focuspulse/components/list_title.dart';
import 'package:focuspulse/components/timer_card.dart';
import 'package:focuspulse/models/load_timer_list.dart';
import 'package:focuspulse/providers/process_provider.dart';
import 'package:focuspulse/widgets/noise_list.dart';

class TimerList extends ConsumerStatefulWidget {
  const TimerList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimerListState();
}

class _TimerListState extends ConsumerState<TimerList> {
  int? selectedIndex;
  List<Map<String, String>> timerList = [];

  @override
  void initState() {
    super.initState();
    loadTimerList().then((loadedTimerList) {
      setState(() {
        timerList = loadedTimerList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              const ListTitle('STEP 1', 'Choose test type'),
              SizedBox(height: 30.h),
              SizedBox(
                height: 480.h,
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
              SizedBox(height: 30.h),
              ListNextBtn(navigateToNextScreen),
            ],
          ),
        ),
      ),
    );
  }
}
