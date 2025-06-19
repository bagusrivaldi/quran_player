import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_player/models/surah_model.dart';
import 'package:quran_player/screen/player_screen.dart';

class AudioPlayerService {
  static AudioPlayer? _currentPlayer;

  /// Menyiapkan dan memainkan audio.
  static Future<AudioPlayer> prepareAndPlay(String url, AudioPlayer? previousPlayer) async {
    await _stopAndDispose(previousPlayer);
    await _stopAndDispose(_currentPlayer);

    final player = AudioPlayer();
    final duration = await player.setUrl(url);

    if (duration == null) {
      throw Exception('Audio tidak bisa diputar: $url');
    }

    _handleOnComplete(player);
    _currentPlayer = player;

    return player;
  }

  /// Saat audio selesai, seek ke awal dan pause.
  static void _handleOnComplete(AudioPlayer player) {
    player.processingStateStream.listen((state) async {
      if (state == ProcessingState.completed) {
        await player.seek(Duration.zero);
        await player.pause();
      }
    });
  }

  /// Format durasi jadi string MM:SS
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  /// Stop dan dispose audio player yang diberikan
  static Future<void> _stopAndDispose(AudioPlayer? player) async {
    try {
      await player?.stop();
      await player?.dispose();
    } catch (_) {
      // optional: log error
    }
  }

  /// Navigasi antar surah dengan transisi fade
  static void navigateToSurah({
    required BuildContext context,
    required List<Surah> allSurahs,
    required int newIndex,
    required AudioPlayer previousPlayer,
  }) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => PlayerScreen(
          allSurahs: allSurahs,
          currentIndex: newIndex,
          previousPlayer: previousPlayer,
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Color getRandomColor({int minBrightness = 50}) {
    final random = Random();

    // Fungsi untuk memastikan warna tidak terlalu gelap (misalnya tidak hitam)
    int generateChannel() => minBrightness + random.nextInt(256 - minBrightness);

    return Color.fromARGB(
      255, // Opacity 100%
      generateChannel(),
      generateChannel(),
      generateChannel(),
    );
  }
}
