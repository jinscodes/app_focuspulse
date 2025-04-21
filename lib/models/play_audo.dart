import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/providers/audio_provider.dart';
import 'package:just_audio/just_audio.dart';

Future<void> playAudio(WidgetRef ref, AudioPlayer audioPlayer) async {
  try {
    final noise = ref.watch(audioNameProvider);
    ref.read(audioProvider.notifier).state = true;
    await audioPlayer.setAsset('assets/sounds/$noise.mp3');
    await audioPlayer.play();
  } catch (e) {
    print("Error playing audio: $e");
  }
}
