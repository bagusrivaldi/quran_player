import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_player/screen/audio_progress_bar.dart';
import 'package:quran_player/screen/player_control.dart';
import 'package:quran_player/screen/surah_info_card.dart';
import 'package:quran_player/services/audio_service_player.dart';
import '../models/surah_model.dart';

class PlayerScreen extends StatelessWidget {
  final List<Surah> allSurahs;
  final int currentIndex;
  final AudioPlayer? previousPlayer;

  const PlayerScreen({
    super.key,
    required this.allSurahs,
    required this.currentIndex,
    this.previousPlayer,
  });

  Surah get surah => allSurahs[currentIndex];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AudioPlayer>(
      future: AudioPlayerService.prepareAndPlay(surah.audio ?? "", previousPlayer),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        }

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: SpinKitWaveSpinner(
                color: Colors.green,
                size: 50.0,
              ),
            ),
          );
        }

        final player = snapshot.data!;

        // Pastikan audio langsung dimainkan setelah frame siap
        WidgetsBinding.instance.addPostFrameCallback((_) {
          player.play();
        });

        return Scaffold(
          appBar: AppBar(title: Text(surah.namaLatin ?? "")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SurahInfoCard(surah: surah),
                const SizedBox(height: 32),
                AudioProgressBar(player: player),
                const SizedBox(height: 16),
                PlayerControls(
                  allSurahs: allSurahs,
                  currentIndex: currentIndex,
                  player: player,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
