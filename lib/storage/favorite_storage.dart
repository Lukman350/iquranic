import 'package:iquranic/models/surah.dart';
import 'dart:convert' as convert;
import 'package:localstorage/localstorage.dart';

class ListSurah {
  final List<Surah> surahList;

  ListSurah({required this.surahList});

  factory ListSurah.fromJson(List<dynamic> json) {
    final List<Surah> surahList = <Surah>[];

    for (var surah in json) {
      surahList.add(Surah.fromJson(surah));
    }

    return ListSurah(surahList: surahList);
  }
}

class FavoriteStorage {
  static const String _fileName = 'iquranic.json';

  static Future<String> get _localStorage async {
    final localStorage = LocalStorage(_fileName);
    await localStorage.ready;

    return localStorage.getItem('favorite') ?? '[]';
  }

  static Future<void> writeFavorite(List<Surah> surahList) async {
    final json =
        convert.jsonEncode(surahList.map((surah) => surah.toJson()).toList());

    final localStorage = LocalStorage(_fileName);
    await localStorage.ready;

    await localStorage.setItem('favorite', json);
  }

  static Future<List<Surah>> readFavorite() async {
    try {
      final contents = await _localStorage;

      if (contents.isEmpty) {
        return <Surah>[];
      }

      final json = convert.jsonDecode(contents);
      final result = ListSurah.fromJson(json);

      return result.surahList;
    } catch (e) {
      return <Surah>[];
    }
  }
}
