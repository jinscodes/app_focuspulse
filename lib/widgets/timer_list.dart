import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/timer.png',
                    height: 40.h,
                  ),
                  Text(
                    "Timer List",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: 'howdy_duck',
                      color: AppColors.fontbrown,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              SizedBox(
                height: 500.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: timerList.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: SizedBox(
                        width: 1.sw,
                        height: 110.h,
                        child: Card(
                          color: AppColors.bgBeige,
                          margin: EdgeInsets.only(bottom: 20.h),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.fontbrown
                                  : AppColors.borderbrown,
                              width: 3,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Image.asset(
                                  timerList[index]['path']!,
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
                  },
                ),
              ),
              SizedBox(height: 60.h),
              ElevatedButton(
                onPressed: () => navigateToNextScreen(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.fontbrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  minimumSize: Size(1.sw, 55.h),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'howdy_duck',
                    color: AppColors.bgBeige,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
