import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iquranic/models/ayat.dart';
import 'package:iquranic/models/surah.dart';

class Api {
  final String baseUrl = 'https://equran.id/api/v2';

  Future<AyatList> getAyat(String surah) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      final response = await http.get(Uri.parse('$baseUrl/surat/$surah'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.isEmpty) {
          throw Exception('Ayat tidak ditemukan');
        }

        return AyatList.fromJson(data);
      } else {
        throw Exception('Failed to load ayat');
      }
    });
  }

  Future<SurahList> getAllSurah() async {
    return Future.delayed(const Duration(seconds: 1), () async {
      final response = await http.get(Uri.parse('$baseUrl/surat'));

      if (response.statusCode == 200) {
        var resp = jsonDecode(response.body);

        if (resp.isEmpty) {
          throw Exception('Surah tidak ditemukan');
        }

        return SurahList.fromJson(resp);
      } else {
        throw Exception('Failed to load surah');
      }
    });
  }

  Future<SurahList> searchSurah(String query) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      final response = await getAllSurah();

      if (response.data.isEmpty) {
        throw Exception(
            {'code': 404, 'content': 'Surah yang anda cari tidak ditemukan'});
      }

      final List<Surah> data = <Surah>[];

      for (var surah in response.data) {
        if (surah.namaLatin.toLowerCase().contains(query.toLowerCase())) {
          data.add(surah);
        }
      }

      if (data.isEmpty) {
        throw Exception(
            {'code': 404, 'content': 'Surah yang anda cari tidak ditemukan'});
      }

      return SurahList(code: 200, message: 'OK', data: data);
    });
  }
}
