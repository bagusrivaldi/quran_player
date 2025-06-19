
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/surah_model.dart';

class QuranApiService {
  static const baseUrl = 'https://open-api.my.id/api/quran/surah';

  Future<List<Surah>> fetchSurahs() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Surah.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load surahs');
    }
  }
}