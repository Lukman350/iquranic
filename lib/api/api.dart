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
          throw Exception('Surat tidak ditemukan');
        }

        return SurahList.fromJson(resp);
      } else {
        throw Exception('Failed to load surah');
      }
    });
  }

  Future<SurahList> searchSurah(String query) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      final response = await http.get(Uri.parse('$baseUrl/surat'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.isEmpty) {
          throw Exception('Surat tidak ditemukan');
        }

        final List<Surah> surahList = <Surah>[];
        for (var surah in data.data) {
          if (surah.nama.toLowerCase().contains(query.toLowerCase())) {
            surahList.add(surah);
          }
        }

        if (surahList.isEmpty) {
          throw Exception({
            'message': 'Surat tidak ditemukan',
            'code': '404',
          });
        }

        return SurahList(
          code: 200,
          message: 'Success',
          data: surahList,
        );
      } else {
        throw Exception('Failed to load surah');
      }
    });
  }
}
