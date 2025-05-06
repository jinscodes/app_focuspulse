import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/providers/process_provider.dart';

class NoiseList extends ConsumerStatefulWidget {
  const NoiseList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoiseListState();
}

class _NoiseListState extends ConsumerState<NoiseList> {
  int? selectedIndex;
  final List<Map<String, String>> soundList = [
    {"key": 'na', "name": "N/A"},
    {"key": 'dryer', "path": "dryer", "name": "Dryer"},
    {"key": 'dryer', "path": "dryer2", "name": "Dryer"},
    {"key": 'fan', "path": "fan", "name": "Fan"},
    {"key": 'fan', "path": "fan2", "name": "Fan"},
    {"key": 'whitenoise', "path": "whitenoise", "name": "WhiteNoise"},
    {"key": 'whitenoise', "path": "whitenoise2", "name": "WhiteNoise"},
    {"key": 'whitenoise', "path": "whitenoise3", "name": "WhiteNoise"},
    {"key": 'whitenoise', "path": "whitenoise4", "name": "WhiteNoise"},
    {"key": 'rain', "path": "rain", "name": "Rain"},
    {"key": 'rain', "path": "rain2", "name": "Rain"},
    {"key": 'rain', "path": "rain3", "name": "Rain"},
    {"key": 'train', "path": "train", "name": "Rain"},
  ];

  @override
  void initState() {
    super.initState();
    print(ref.read(timerProvider)['timer']);
  }

  @override
  Widget build(BuildContext context) {
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
                    'assets/images/piano.png',
                    height: 40.h,
                  ),
                  Text(
                    "Sound List",
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
                  itemCount: soundList.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        print("clicked");
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
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/${soundList[index]['key']!}.svg',
                                  height: 30.h,
                                ),
                                SizedBox(width: 16.w),
                                Text(
                                  soundList[index]['name']!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'howdy_duck',
                                    color: AppColors.soundBrown,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 60.h),
              ElevatedButton(
                onPressed: () => {},
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
