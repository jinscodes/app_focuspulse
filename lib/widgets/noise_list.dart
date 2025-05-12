import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/list_next_btn.dart';
import 'package:focuspulse/components/list_title.dart';
import 'package:focuspulse/components/sound_card.dart';
import 'package:focuspulse/models/load_sound_list.dart';
import 'package:focuspulse/models/play_audio.dart';
import 'package:just_audio/just_audio.dart';

class NoiseList extends ConsumerStatefulWidget {
  const NoiseList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoiseListState();
}

class _NoiseListState extends ConsumerState<NoiseList>
    with WidgetsBindingObserver {
  int? selectedIndex;
  late AudioPlayer _audioPlayer;
  List<Map<String, String>> soundList = [];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    WidgetsBinding.instance.addObserver(this);
    loadSoundList().then((loadedSoundList) {
      setState(() {
        soundList = loadedSoundList;

        selectedIndex = soundList.indexWhere((sound) => sound['key'] == 'na');
        if (selectedIndex != -1) {
          final defaultNoise = soundList[selectedIndex!]['path']!;
          if (defaultNoise != "na") {
            playAudio(ref, _audioPlayer, defaultNoise);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _audioPlayer.stop();
    }
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
