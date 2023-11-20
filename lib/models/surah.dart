class Surah {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, dynamic> audioFull;

  Surah(
      {required this.nomor,
      required this.nama,
      required this.namaLatin,
      required this.jumlahAyat,
      required this.tempatTurun,
      required this.arti,
      required this.deskripsi,
      required this.audioFull});

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
        nomor: json['nomor'] as int,
        nama: json['nama'] as String,
        namaLatin: json['namaLatin'] as String,
        jumlahAyat: json['jumlahAyat'] as int,
        tempatTurun: json['tempatTurun'] as String,
        arti: json['arti'] as String,
        deskripsi: json['deskripsi'] as String,
        audioFull: json['audioFull'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    return {
      'nomor': nomor,
      'nama': nama,
      'namaLatin': namaLatin,
      'jumlahAyat': jumlahAyat,
      'tempatTurun': tempatTurun,
      'arti': arti,
      'deskripsi': deskripsi,
      'audioFull': audioFull
    };
  }
}

class SurahList {
  final int code;
  final String message;
  final List<Surah> data;

  SurahList({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SurahList.fromJson(Map<String, dynamic> json) {
    final List<Surah> surahList = <Surah>[];

    for (var surah in json['data']) {
      surahList.add(Surah.fromJson(surah));
    }

    return SurahList(
        code: json['code'] as int,
        message: json['message'] as String,
        data: surahList);
  }
}
