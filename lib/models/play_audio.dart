import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

Future<void> playAudio(
    WidgetRef ref, AudioPlayer audioPlayer, String noise) async {
  try {
    if (noise == 'na') {
      return await audioPlayer.stop();
    }

    final currentSource = audioPlayer.audioSource;

    if (currentSource == null) {
      await audioPlayer.stop();
      await audioPlayer.setAsset('assets/sounds/$noise.mp3');
      await audioPlayer.play();
    } else {
      await audioPlayer.play();
    }
  } catch (e) {
    print("Error playing audio: $e");
  }
}
