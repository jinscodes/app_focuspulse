import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/models/load_sound_list.dart';
import 'package:focuspulse/widgets/sound_list.dart';

class QuickAccessSounds extends ConsumerStatefulWidget {
  const QuickAccessSounds({super.key});

  @override
  ConsumerState<QuickAccessSounds> createState() => _QuickAccessSoundsState();
}

class _QuickAccessSoundsState extends ConsumerState<QuickAccessSounds> {
  void navigateToTimerList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SoundList(),
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
              "Sound List",
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
          future: loadSoundList(),
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
                      key!,
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
                    onTap: () {
                      print("Click on $key");
                    },
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
