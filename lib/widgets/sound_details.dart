import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/load_sound_list.dart';
import 'package:focuspulse/models/pause_audio.dart';
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
          'Sound Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: FutureBuilder(
          future: loadSoundList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            final soundList = snapshot.data!;
            final soundData = soundList.firstWhere(
              (item) => item['key'] == _soundKey,
              orElse: () => {},
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(
                      'assets/images/${soundData['imgPath']}.png',
                      width: 300.w,
                      height: 300.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    soundData['key']![0].toUpperCase() +
                        soundData['key']!.substring(1),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "space_grotesk",
                    ),
                  ),
                  StreamBuilder<Duration>(
                    stream: _audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      final position = snapshot.data ?? Duration.zero;
                      final duration =
                          _audioPlayer.duration ?? const Duration(seconds: 1);
                      return Column(
                        children: [
                          Slider(
                            value: position.inMilliseconds
                                .toDouble()
                                .clamp(0, duration.inMilliseconds.toDouble()),
                            min: 0,
                            max: duration.inMilliseconds.toDouble(),
                            onChanged: (value) async {
                              await _audioPlayer
                                  .seek(Duration(milliseconds: value.toInt()));
                            },
                            activeColor: Colors.black,
                            inactiveColor: AppColors.bgGray,
                            thumbColor: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "space_grotesk",
                                  ),
                                ),
                                Text(
                                  "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "space_grotesk",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    playNextSound(soundList, false),
                                icon: Icon(
                                  Icons.skip_previous_rounded,
                                  color: Colors.black,
                                  size: 60.w,
                                ),
                              ),
                              SizedBox(width: 20.w),
                              IconButton(
                                icon: Icon(
                                  _audioPlayer.playing
                                      ? Icons.pause_circle_filled_outlined
                                      : Icons.play_circle_fill_outlined,
                                  color: Colors.black,
                                  size: 80.w,
                                ),
                                onPressed: () {
                                  if (_audioPlayer.playing) {
                                    pauseAudio(ref, _audioPlayer);
                                  } else {
                                    playAudio(
                                      ref,
                                      _audioPlayer,
                                      soundData['key']!,
                                    );
                                  }
                                },
                              ),
                              SizedBox(width: 20.w),
                              IconButton(
                                onPressed: () => playNextSound(soundList, true),
                                icon: Icon(
                                  Icons.skip_next_rounded,
                                  color: Colors.black,
                                  size: 60.w,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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
