import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quran_player/bloc/surah_bloc.dart';
import 'package:quran_player/bloc/surah_event.dart';
import 'package:quran_player/bloc/surah_state.dart';
import '../models/surah_model.dart';
import 'player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quran Surahs')),
      body: const Column(
        children: [
          _SearchBar(),
          SizedBox(height: 8),
          Expanded(child: _SurahListView()),
        ],
      ),
    );
  }
}

/// Widget pencarian surah
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari surah...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.green[900] ?? Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.green[900] ?? Colors.green, width: 2),
          ),
        ),
        onChanged: (value) {
          context.read<SurahBloc>().add(UpdateSearchQuery(value));
        },
      ),
    );
  }
}

/// Widget list surah berdasarkan state BLoC
class _SurahListView extends StatelessWidget {
  const _SurahListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahBloc, SurahState>(
      builder: (context, state) {
        if (state is SurahLoading) {
          return const Center(
            child: SpinKitWaveSpinner(
              color: Colors.green,
              size: 50.0,
            ),
          );
        } else if (state is SurahError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is SurahLoaded) {
          final filteredSurahs = _filterSurahs(state);
          return _SurahList(surahs: filteredSurahs);
        }
        return const Center(child: Text('No data loaded.'));
      },
    );
  }

  List<Surah> _filterSurahs(SurahLoaded state) {
    return state.surahs.where((s) {
      final name = s.namaLatin?.toLowerCase() ?? '';
      return name.contains(state.searchQuery.toLowerCase());
    }).toList();
  }
}

/// Widget daftar surah
class _SurahList extends StatelessWidget {
  final List<Surah> surahs;

  const _SurahList({required this.surahs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        return ListTile(
          title: Text(surah.namaLatin ?? ''),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PlayerScreen(
                  allSurahs: surahs,
                  currentIndex: index,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
