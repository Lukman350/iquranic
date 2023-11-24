import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:iquranic/api/api.dart';
import 'package:iquranic/models/ayat.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/screens/mobile/surah_screen.dart';
import 'package:iquranic/screens/web/surah_screen.dart';

class QuranScreen extends StatefulWidget {
  static const routeName = '/surah';

  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late Future<AyatList> futureAyat;
  late Surah _favorite;
  final AudioPlayer _audioPlayer = AudioPlayer(
    handleInterruptions: true,
    androidApplyAudioAttributes: true,
  );
  final TextEditingController _selectAudio = TextEditingController();
  final Map<String, String> _audioData = {
    'Abdullah Al Juhany': '01',
    'Abdul Muhsin Al Qasim': '02',
    'Abdurrahman as Sudais': '03',
    'Ibrahim Al Dossari': '04',
    'Misyari Rasyid Al Afasi': '05',
  };

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    setState(() {
      futureAyat = Api().getAyat(args.nomor.toString());
      _favorite = Surah(
        arti: args.arti,
        audioFull: args.audioFull,
        deskripsi: args.deskripsi,
        jumlahAyat: args.jumlahAyat,
        nama: args.nama,
        namaLatin: args.namaLatin,
        nomor: args.nomor,
        tempatTurun: args.tempatTurun,
      );
    });

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return QuranScreenMobile(
              futureAyat: futureAyat,
              favorite: _favorite,
              audioPlayer: _audioPlayer,
              selectAudio: _selectAudio,
              audioData: _audioData,
              args: args);
        } else {
          return QuranScreenDesktop(
              futureAyat: futureAyat,
              favorite: _favorite,
              audioPlayer: _audioPlayer,
              selectAudio: _selectAudio,
              audioData: _audioData,
              args: args);
        }
      },
    );
  }
}

class ScreenArguments {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, dynamic> audioFull;

  ScreenArguments(
      {required this.nomor,
      required this.nama,
      required this.namaLatin,
      required this.jumlahAyat,
      required this.tempatTurun,
      required this.arti,
      required this.deskripsi,
      required this.audioFull});
}
