class SuratExtra {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  SuratExtra(
      {required this.nomor,
      required this.nama,
      required this.namaLatin,
      required this.jumlahAyat});

  factory SuratExtra.fromJson(Map<String, dynamic> json) {
    return SuratExtra(
        nomor: json['nomor'] as int,
        nama: json['nama'] as String,
        namaLatin: json['namaLatin'] as String,
        jumlahAyat: json['jumlahAyat'] as int);
  }
}

class Ayat {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, dynamic> audio;

  Ayat(
      {required this.nomorAyat,
      required this.teksArab,
      required this.teksLatin,
      required this.teksIndonesia,
      required this.audio});

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
        nomorAyat: json['nomorAyat'] as int,
        teksArab: json['teksArab'] as String,
        teksLatin: json['teksLatin'] as String,
        teksIndonesia: json['teksIndonesia'] as String,
        audio: json['audio'] as Map<String, dynamic>);
  }
}

class DataSurat<T, E> {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, dynamic> audioFull;
  final List<Ayat> ayat;
  final T suratSelanjutnya;
  final E suratSebelumnya;

  DataSurat(
      {required this.nomor,
      required this.nama,
      required this.namaLatin,
      required this.jumlahAyat,
      required this.tempatTurun,
      required this.arti,
      required this.deskripsi,
      required this.audioFull,
      required this.ayat,
      required this.suratSelanjutnya,
      required this.suratSebelumnya});

  factory DataSurat.fromJson(Map<String, dynamic> json) {
    final List<Ayat> ayatList = <Ayat>[];

    for (var ayat in json['ayat']) {
      ayatList.add(Ayat.fromJson(ayat));
    }

    return DataSurat(
        nomor: json['nomor'] as int,
        nama: json['nama'] as String,
        namaLatin: json['namaLatin'] as String,
        jumlahAyat: json['jumlahAyat'] as int,
        tempatTurun: json['tempatTurun'] as String,
        arti: json['arti'] as String,
        deskripsi: json['deskripsi'] as String,
        audioFull: json['audioFull'] as Map<String, dynamic>,
        ayat: ayatList,
        suratSelanjutnya: json['SurahSelanjutnya'],
        suratSebelumnya: json['SurahSebelumnya']);
  }
}

class AyatList {
  final int code;
  final String message;
  final DataSurat data;

  AyatList({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AyatList.fromJson(Map<String, dynamic> json) {
    DataSurat dataSurat = DataSurat(
        nomor: 0,
        nama: '',
        namaLatin: '',
        jumlahAyat: 0,
        tempatTurun: '',
        arti: '',
        deskripsi: '',
        audioFull: {},
        ayat: [],
        suratSelanjutnya: {},
        suratSebelumnya: {});

    if (json['data'].runtimeType == String) {
      throw Exception({
        'message': 'Surah tidak ditemukan',
        'code': '404',
      });
    } else {
      dataSurat = DataSurat.fromJson(json['data']);
    }

    return AyatList(
        code: json['code'] as int,
        message: json['message'] as String,
        data: dataSurat);
  }
}
