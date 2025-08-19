import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/load_sound_list.dart';
import 'package:focuspulse/models/play_audio.dart';
import 'package:just_audio/just_audio.dart';

class SoundDetails extends ConsumerStatefulWidget {
  final String soundKey;

  const SoundDetails(this.soundKey, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SoundDetailsState();
}

class _SoundDetailsState extends ConsumerState<SoundDetails> {
  late AudioPlayer _audioPlayer;
  late String _soundKey;

  @override
  void initState() {
    super.initState();
    _soundKey = widget.soundKey;
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void playNextSound(List<Map<String, dynamic>> soundList, bool isNext) async {
    final currentIndex =
        soundList.indexWhere((item) => item['key'] == _soundKey);
    int newIndex;
    if (isNext) {
      newIndex = (currentIndex + 1) % soundList.length;
    } else {
      newIndex = (currentIndex - 1 + soundList.length) % soundList.length;
    }
    final nextSoundKey = soundList[newIndex]['key'];
    setState(() {
      _soundKey = nextSoundKey;
    });
    await playAudio(ref, _audioPlayer, nextSoundKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Music Player',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'space_grotesk',
                  ),
                ),
                Text(
                  'Your personal music streaming experience',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'space_grotesk',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: FutureBuilder<List<Map<String, String>>>(
          future: loadSoundList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final soundList = snapshot.data!;
            final soundData = soundList.firstWhere(
              (item) => item['key'] == _soundKey,
              orElse: () => {'key': _soundKey, 'imgPath': 'music_note'},
            );

            final imagePath = soundData['imgPath'] == 'n/a'
                ? 'music_note'
                : soundData['imgPath'] ?? 'music_note';

            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderGray),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 242, 242, 255),
                          Color.fromARGB(255, 255, 255, 255),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 50.w,
                        height: 50.w,
                        child: Image.asset(
                          'assets/images/music_note.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/music_note.png',
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    _soundKey[0].toUpperCase() + _soundKey.substring(1),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'space_grotesk',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Relaxing Sounds - ${imagePath[0].toUpperCase()}${imagePath.substring(1)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'space_grotesk',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _audioPlayer.playing ? Colors.green : Colors.red,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _audioPlayer.playing ? 'Playing' : 'Paused',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'space_grotesk',
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
