import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/load_sound_list.dart';
import 'package:focuspulse/models/load_timer_setting.dart';
import 'package:focuspulse/widgets/timer.dart';

class TestDetailsScreen extends ConsumerStatefulWidget {
  final String testKey;

  const TestDetailsScreen(this.testKey, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestDetailsState();
}

class _TestDetailsState extends ConsumerState<TestDetailsScreen> {
  late String testKey;
  String? selectedSound;

  @override
  void initState() {
    super.initState();
    testKey = widget.testKey;
  }

  void navigateToTimer(String testKey, String? selectedSound) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TimerScreen(testKey: testKey, soundKey: selectedSound ?? 'rain'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_outlined, size: 24.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Test Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadTimerSetting(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final timerSettings = snapshot.data!;
          final timerData = timerSettings.firstWhere(
            (item) => item['key'] == testKey,
            orElse: () => {},
          );
          if (timerData.isEmpty) {
            return const Center(child: Text('No data found for this test.'));
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    timerData['key'].toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Sections",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: timerData['session']?.length ?? 0,
                    itemBuilder: (context, index) {
                      final session = timerData['session'][index];
                      final key = session.keys.first;
                      final value = session.values.first;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              key,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: "space_grotesk",
                              ),
                            ),
                            Text(
                              '${value.toString()} minutes',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "space_grotesk",
                                color: AppColors.fontGray,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Sound Settings",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "space_grotesk",
                    ),
                  ),
                  SizedBox(height: 12.h),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: loadSoundList(),
                    builder: (context, soundSnapshot) {
                      if (!soundSnapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      final soundList = soundSnapshot.data!;
                      if (soundList.isEmpty) {
                        return const Text("No sounds available.");
                      }
                      final soundNames =
                          soundList.map((e) => e['key'].toString()).toList();
                      return Container(
                        height: 56.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.borderGray,
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedSound ?? soundNames.first,
                            alignment: Alignment.center,
                            dropdownColor: AppColors.bgWhite,
                            borderRadius: BorderRadius.circular(12.r),
                            items: soundNames.map((sound) {
                              return DropdownMenuItem<String>(
                                value: sound,
                                child: Text(
                                  sound,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "space_grotesk",
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSound = value;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "You can turn on and off the sound by clikcing the note (♪) icon on the next screen to hear the sound.",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.fontGray,
                        fontFamily: "space_grotesk",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            onPressed: () => navigateToTimer(testKey, selectedSound),
            child: Text(
              'Start Test',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "space_grotesk",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
