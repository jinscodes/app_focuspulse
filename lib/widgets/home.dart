import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/2v/components/menu_drawer.dart';
import 'package:focuspulse/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final List<String> timerList = [
      'assets/images/toeic.png',
      'assets/images/toefl.png',
      'assets/images/opic.png',
      'assets/images/korea_sat.png'
    ];

    return Scaffold(
      backgroundColor: AppColors.bgBeige,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgBeige,
        foregroundColor: AppColors.fontbrown,
        centerTitle: true,
      ),
      drawer: const MenuDrawer(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/timer.png',
                    height: 50.h,
                  ),
                  Text(
                    "Timer List",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontFamily: 'howdy_duck',
                      color: AppColors.fontbrown,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.fontbrown
                                  : AppColors.borderbrown,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Image.asset(
                                  timerList[index],
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
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () {
                  print("Clicked");
                },
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
