// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerBox extends StatefulWidget {
  const AudioPlayerBox({super.key});

  @override
  State<AudioPlayerBox> createState() => _AudioPlayerBoxState();
}

class _AudioPlayerBoxState extends State<AudioPlayerBox> {
  int _audioIndex = 0;
  late AudioPlayer _audioPlayer;
  final List<String> _audioFiles = [
    'assets/sounds/Fan.mp3',
    'assets/sounds/Fan2.mp3',
    'assets/sounds/Pure Noise.mp3',
    'assets/sounds/Pure Noise2.mp3',
    'assets/sounds/Pure Noise3.mp3',
    'assets/sounds/Pure Noise4.mp3',
    'assets/sounds/Rain.mp3',
    'assets/sounds/Rain2.mp3',
    'assets/sounds/Rain3.mp3',
    'assets/sounds/Train.mp3',
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

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.setAsset(_audioFiles[_audioIndex]);
      await _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  void _nextAudioIndex(int index) {
    setState(() {
      if (_audioIndex < _audioFiles.length - 1) {
        _audioIndex++;
      } else {
        _audioIndex = 0;
      }
    });
    _pauseAudio();
  }

  void _prevAudioIndex(int index) {
    setState(() {
      if (_audioIndex > 0) {
        _audioIndex--;
      } else {
        _audioIndex = _audioFiles.length - 1;
      }
    });
    _pauseAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/player.png",
              width: 120.w,
              height: 120.h,
              opacity: const AlwaysStoppedAnimation(0.7),
            ),
            StreamBuilder(
              stream: _audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final isPlaying = playerState?.playing ?? false;
                return IconButton(
                  onPressed: isPlaying ? _pauseAudio : _playAudio,
                  icon: Icon(
                    size: 50.sp,
                    color: AppColors.playerbrown,
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _prevAudioIndex(_audioIndex),
              icon: Icon(
                Icons.skip_previous_rounded,
                size: 30.sp,
                color: AppColors.playerbrown,
              ),
            ),
            Text(
              _audioFiles[_audioIndex].split("/").last.split(".").first,
              style: TextStyle(
                fontFamily: 'howdy_duck',
                fontSize: 20.sp,
                color: AppColors.fontbrown,
              ),
            ),
            IconButton(
              onPressed: () => _nextAudioIndex(_audioIndex),
              icon: Icon(
                Icons.skip_next_rounded,
                size: 30.sp,
                color: AppColors.playerbrown,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
