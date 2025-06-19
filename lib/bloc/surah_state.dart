import 'package:equatable/equatable.dart';
import '../models/surah_model.dart';

abstract class SurahState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final List<Surah> surahs;
  final String searchQuery;
  SurahLoaded(this.surahs, {this.searchQuery = ''});
  @override
  List<Object?> get props => [surahs, searchQuery];
}

class SurahError extends SurahState {
  final String message;
  SurahError(this.message);
  @override
  List<Object?> get props => [message];
}
