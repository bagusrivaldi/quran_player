import 'package:flutter/material.dart';
import 'package:quran_player/models/surah_model.dart';
import 'package:quran_player/services/audio_service_player.dart';

class SurahInfoCard extends StatelessWidget {
  final Surah surah;

  const SurahInfoCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(color: AudioPlayerService().getRandomColor()),
          child: Center(
            child: Text(
              surah.nama ?? "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          surah.namaLatin ?? "",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          surah.tempatTurun ?? "",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      //   Html(
      //     data: surah.deskripsi,
      //      style: {
      //   'body': Style(
      //     fontSize: FontSize(16),
      //     textAlign: TextAlign.justify,
      //   ),
      // },
      //   ),
      ],
    );
  }
}
