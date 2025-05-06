import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

Future<void> playAudio(
    WidgetRef ref, AudioPlayer audioPlayer, String noise) async {
  try {
    if (noise == 'na') {
      await audioPlayer.stop();
    }

    await audioPlayer.stop();
    await audioPlayer.setAsset('assets/sounds/$noise.mp3');
    await audioPlayer.play();
  } catch (e) {
    // ignore: avoid_print
    print("Error playing audio: $e");
  }
}
