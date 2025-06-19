import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_player/services/quran_api_services.dart';
import 'surah_event.dart';
import 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final QuranApiService apiService;
  SurahBloc(this.apiService) : super(SurahInitial()) {
    on<LoadSurahs>((event, emit) async {
      emit(SurahLoading());
      try {
        final surahs = await apiService.fetchSurahs();
        emit(SurahLoaded(surahs));
      } catch (e) {
        emit(SurahError(e.toString()));
      }
    });

    on<UpdateSearchQuery>((event, emit) {
      if (state is SurahLoaded) {
        final current = state as SurahLoaded;
        emit(SurahLoaded(current.surahs, searchQuery: event.query));
      }
    });
  }
}
