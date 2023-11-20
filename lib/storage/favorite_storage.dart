import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:iquranic/models/surah.dart';
import 'dart:convert' as convert;

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
  static const String _fileName = 'favorite.json';

  static Future<void> _createFileIfNotExists() async {
    final file = await _localFile;

    if (!await File(file).exists()) {
      await File(file).create();
    }
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get _localFile async {
    final path = await _localPath;
    return '$path/$_fileName';
  }

  static Future<File> writeFavorite(List<Surah> surahList) async {
    await _createFileIfNotExists();

    final file = await _localFile;
    final json =
        convert.jsonEncode(surahList.map((surah) => surah.toJson()).toList());

    return File(file).writeAsString(json);
  }

  static Future<List<Surah>> readFavorite() async {
    try {
      await _createFileIfNotExists();

      final file = await _localFile;
      final contents = await File(file).readAsString();
      final json = convert.jsonDecode(contents);
      final result = ListSurah.fromJson(json);

      return result.surahList;
    } catch (e) {
      debugPrint('FavoriteStorage[readFavorite]: $e');
      return <Surah>[];
    }
  }
}
