class Ayat {
  final String ar;
  final String id;
  final String nomor;
  final String tr;

  Ayat(
      {required this.ar,
      required this.id,
      required this.nomor,
      required this.tr});

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      ar: json['ar'] as String,
      id: json['id'] as String,
      nomor: json['nomor'] as String,
      tr: json['tr'] as String,
    );
  }
}

class AyatList {
  final List<Ayat> ayatList;

  AyatList({required this.ayatList});

  factory AyatList.fromJson(List<dynamic> json) {
    List<Ayat> ayatList = <Ayat>[];
    ayatList = json.map((e) => Ayat.fromJson(e)).toList();

    return AyatList(ayatList: ayatList);
  }
}
