import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/providers/audio_provider.dart';
import 'package:just_audio/just_audio.dart';

Future<void> pauseAudio(WidgetRef ref, AudioPlayer audioPlayer) async {
  ref.read(audioProvider.notifier).state = false;
  await audioPlayer.pause();
}
