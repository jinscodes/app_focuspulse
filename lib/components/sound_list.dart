import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/models/load_sound_list.dart';

class SoundList extends ConsumerWidget {
  const SoundList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onPressed: () {
                print("Click icon more");
              },
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
