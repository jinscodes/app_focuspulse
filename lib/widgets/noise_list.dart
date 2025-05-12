import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/list_next_btn.dart';
import 'package:focuspulse/components/list_title.dart';
import 'package:focuspulse/components/sound_card.dart';
import 'package:focuspulse/models/play_audio.dart';
import 'package:just_audio/just_audio.dart';

class NoiseList extends ConsumerStatefulWidget {
  const NoiseList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoiseListState();
}

class _NoiseListState extends ConsumerState<NoiseList> {
  int? selectedIndex;
  late AudioPlayer _audioPlayer;
  final List<Map<String, String>> soundList = [
    {"key": 'na', "path": "na", "name": "N/A"},
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
    {"key": 'train', "path": "train", "name": "Train"},
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
              const ListTitle('Sound List', 'assets/images/piano.png'),
              SizedBox(height: 30.h),
              SizedBox(
                height: 500.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: soundList.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;

                    return SoundCard(
                      isSelected: isSelected,
                      imagePath: soundList[index]['key']!,
                      name: soundList[index]['name']!,
                      onTap: () async {
                        setState(() {
                          selectedIndex = index;
                        });
                        final noise = soundList[index]['path']!;
                        await playAudio(ref, _audioPlayer, noise);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 60.h),
              ListNextBtn(() => print("Next button pressed")),
            ],
          ),
        ),
      ),
    );
  }
}
