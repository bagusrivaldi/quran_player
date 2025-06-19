import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_player/services/audio_service_player.dart';

class AudioProgressBar extends StatelessWidget {
  final AudioPlayer player;

  const AudioProgressBar({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        return StreamBuilder<Duration?>(
          stream: player.durationStream,
          builder: (context, snapshot) {
            final duration = snapshot.data ?? Duration.zero;
            return Column(
              children: [
                Slider(
                  activeColor: Colors.green[900],
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble().clamp(1, double.infinity),
                  onChanged: (v) => player.seek(Duration(seconds: v.toInt())),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AudioPlayerService.formatDuration(position)),
                    Text(AudioPlayerService.formatDuration(duration)),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
