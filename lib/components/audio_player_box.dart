import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerBox extends StatefulWidget {
  const AudioPlayerBox({super.key});

  @override
  State<AudioPlayerBox> createState() => _AudioPlayerBoxState();
}

class _AudioPlayerBoxState extends State<AudioPlayerBox> {
  late AudioPlayer _audioPlayer;

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
      await _audioPlayer.setAsset('assets/sounds/wind.mp3');
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _playAudio,
          child: const Text("Play"),
        ),
        ElevatedButton(
          onPressed: _pauseAudio,
          child: const Text("Pause"),
        ),
        ElevatedButton(
          onPressed: _stopAudio,
          child: const Text("Stop"),
        ),
      ],
    );
  }
}
