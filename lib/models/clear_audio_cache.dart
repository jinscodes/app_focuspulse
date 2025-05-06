import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<void> clearAudioCache() async {
  final cacheDir = await getTemporaryDirectory();
  final justAudioCacheDir = Directory('${cacheDir.path}/just_audio_cache');

  if (await justAudioCacheDir.exists()) {
    await justAudioCacheDir.delete(recursive: true);
    print('Cleared just_audio_cache');
  }
}
