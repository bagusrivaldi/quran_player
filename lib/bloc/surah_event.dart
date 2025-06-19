// === blocs/surah_event.dart ===
import 'package:equatable/equatable.dart';

abstract class SurahEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSurahs extends SurahEvent {}

class UpdateSearchQuery extends SurahEvent {
  final String query;
  UpdateSearchQuery(this.query);
}
