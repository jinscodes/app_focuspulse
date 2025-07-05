import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focuspulse/models/pause_audio.dart';
import 'package:focuspulse/models/play_audio.dart';
import 'package:just_audio/just_audio.dart';

class BlinkingIconButton extends ConsumerStatefulWidget {
  final Icon icon;
  final String soundKey;
  final WidgetRef? ref;
  final VoidCallback? onPressed;

  const BlinkingIconButton({
    super.key,
    required this.icon,
    required this.soundKey,
    this.ref,
    this.onPressed,
  });

  @override
  ConsumerState<BlinkingIconButton> createState() => _BlinkingIconButtonState();
}

class _BlinkingIconButtonState extends ConsumerState<BlinkingIconButton> {
  late String _soundKey;
  bool _visible = true;
  bool _blinking = true;
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _soundKey = widget.soundKey;
    _startBlinking();
  }

  void _startBlinking() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_blinking) {
        setState(() {
          _visible = !_visible;
        });
      }
    });
    playAudio(ref, _audioPlayer, _soundKey);
  }

  void _stopBlinking() {
    setState(() {
      _blinking = false;
      _visible = true;
    });
    _timer?.cancel();
    pauseAudio(ref, _audioPlayer);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.2,
      duration: const Duration(milliseconds: 250),
      child: IconButton(
        onPressed: () {
          if (_blinking) {
            _stopBlinking();
          } else {
            setState(() {
              _blinking = true;
            });
            _startBlinking();
          }
          widget.onPressed?.call();
        },
        icon: widget.icon,
      ),
    );
  }
}
