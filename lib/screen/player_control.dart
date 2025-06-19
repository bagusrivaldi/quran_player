import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_player/models/surah_model.dart';
import 'package:quran_player/services/audio_service_player.dart';

class PlayerControls extends StatelessWidget {
  final List<Surah> allSurahs;
  final int currentIndex;
  final AudioPlayer player;

  const PlayerControls({
    super.key,
    required this.allSurahs,
    required this.currentIndex,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final isFirst = currentIndex == 0;
    final isLast = currentIndex == allSurahs.length - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.skip_previous,
            color: isFirst ? Colors.grey : null,
          ),
          iconSize: 48,
          onPressed: isFirst
              ? null
              : () {
                  AudioPlayerService.navigateToSurah(
                    context: context,
                    allSurahs: allSurahs,
                    newIndex: currentIndex - 1,
                    previousPlayer: player,
                  );
                },
        ),
        StreamBuilder<bool>(
          stream: player.playingStream,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data ?? false;
            return IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 64,
              onPressed: () => isPlaying ? player.pause() : player.play(),
            );
          },
        ),
        IconButton(
          icon: Icon(
            Icons.skip_next,
            color: isLast ? Colors.grey : null,
          ),
          iconSize: 48,
          onPressed: isLast
              ? null
              : () {
                  AudioPlayerService.navigateToSurah(
                    context: context,
                    allSurahs: allSurahs,
                    newIndex: currentIndex + 1,
                    previousPlayer: player,
                  );
                },
        ),
      ],
    );
  }
}
