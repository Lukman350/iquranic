// {
// "nomor": 1,
// "nama": "الفاتحة",
// "namaLatin": "Al-Fatihah",
// "jumlahAyat": 7,
// "tempatTurun": "Mekah",
// "arti": "Pembukaan",
// "deskripsi": "Surat <i>Al Faatihah</i> (Pembukaan) yang diturunkan di Mekah dan terdiri dari 7 ayat adalah surat yang pertama-tama diturunkan dengan lengkap  diantara surat-surat yang ada dalam Al Quran dan termasuk golongan surat Makkiyyah. Surat ini disebut <i>Al Faatihah</i> (Pembukaan), karena dengan surat inilah dibuka dan dimulainya Al Quran. Dinamakan <i>Ummul Quran</i> (induk Al Quran) atau <i>Ummul Kitaab</i> (induk Al Kitaab) karena dia merupakan induk dari semua isi Al Quran, dan karena itu diwajibkan membacanya pada tiap-tiap sembahyang.<br> Dinamakan pula <i>As Sab'ul matsaany</i> (tujuh yang berulang-ulang) karena ayatnya tujuh dan dibaca berulang-ulang dalam sholat.",
// "audioFull": {
// "01": "https://equran.nos.wjv-1.neo.id/audio-full/Abdullah-Al-Juhany/001.mp3",
// "02": "https://equran.nos.wjv-1.neo.id/audio-full/Abdul-Muhsin-Al-Qasim/001.mp3",
// "03": "https://equran.nos.wjv-1.neo.id/audio-full/Abdurrahman-as-Sudais/001.mp3",
// "04": "https://equran.nos.wjv-1.neo.id/audio-full/Ibrahim-Al-Dossari/001.mp3",
// "05": "https://equran.nos.wjv-1.neo.id/audio-full/Misyari-Rasyid-Al-Afasi/001.mp3"
// }
// },

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
