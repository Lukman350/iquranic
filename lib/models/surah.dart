class Surah {
  final String nomor;
  final String arti;
  final String asma;
  final int ayat;
  final String nama;
  final String type;
  final String urut;
  final String audio;
  final String rukuk;
  final String keterangan;

  Surah(
      {required this.nomor,
      required this.arti,
      required this.asma,
      required this.ayat,
      required this.nama,
      required this.type,
      required this.urut,
      required this.audio,
      required this.rukuk,
      required this.keterangan});

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
        nomor: json['nomor'] as String,
        arti: json['arti'] as String,
        asma: json['asma'] as String,
        ayat: json['ayat'] as int,
        nama: json['nama'] as String,
        type: json['type'] as String,
        urut: json['urut'] as String,
        audio: json['audio'] as String,
        rukuk: json['rukuk'] as String,
        keterangan: json['keterangan'] as String);
  }
}

class SurahList {
  final List<Surah> surahList;

  SurahList({required this.surahList});

  factory SurahList.fromJson(List<dynamic> json) {
    List<Surah> surahList = <Surah>[];
    surahList = json.map((e) => Surah.fromJson(e)).toList();

    return SurahList(surahList: surahList);
  }
}
