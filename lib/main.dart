// === main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_player/bloc/surah_bloc.dart';
import 'package:quran_player/bloc/surah_event.dart';
import 'package:quran_player/screen/home_screen.dart';
import 'package:quran_player/services/quran_api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Player',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
        create: (context) => SurahBloc(QuranApiService())..add(LoadSurahs()),
        child: const HomeScreen(),
      ),
    );
  }
}
