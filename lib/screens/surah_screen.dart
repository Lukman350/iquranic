import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iquranic/api/api.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/audio_widget.dart';
import 'package:iquranic/components/bottom_nav.dart';
import 'package:iquranic/components/favorite_button.dart';
import 'package:iquranic/models/ayat.dart';
import 'package:iquranic/components/alert_error.dart';
import 'package:iquranic/models/surah.dart';

class QuranScreen extends StatefulWidget {
  static const routeName = '/surah';

  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late Future<AyatList> futureAyat;
  late Surah _favorite;
  final AudioPlayer _audioPlayer = AudioPlayer(playerId: 'iquranic');
  final TextEditingController _selectAudio = TextEditingController();
  final Map<String, String> _audioData = {
    'Abdullah Al Juhany': '01',
    'Abdul Muhsin Al Qasim': '02',
    'Abdurrahman as Sudais': '03',
    'Ibrahim Al Dossari': '04',
    'Misyari Rasyid Al Afasi': '05',
  };
  String _selectedAudio = '01';

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

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              FavoriteButton(
                surah: _favorite,
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: AppBarTitle(title: args.namaLatin),
            automaticallyImplyLeading: false),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(args.arti.toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                fontSize: 18)),
                        Text('Asal: ${args.tempatTurun.toUpperCase()}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                fontSize: 18)),
                        Text('${args.jumlahAyat.toString()} AYAT',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w300,
                                fontSize: 12)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Theme.of(context).colorScheme.primary),
                            ),
                            onPressed: () {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text(args.namaLatin),
                                        content: Text(args.deskripsi
                                            .replaceAll('<i>', '')
                                            .replaceAll('</i>', '')),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Tutup',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                          ),
                                        ],
                                      );
                                    });
                              });
                            },
                            child: const Text('Deskripsi',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))),
                        AudioWidget(
                            player: _audioPlayer,
                            url: args.audioFull[_selectedAudio]),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                flex: 1,
                child: DropdownMenu<String>(
                  initialSelection: _audioData.keys.first,
                  controller: _selectAudio,
                  label: const Text('Pilih Qori'),
                  width: MediaQuery.of(context).size.width - 32,
                  onSelected: (value) {
                    setState(() {
                      _selectedAudio = value ?? '01';
                    });
                  },
                  dropdownMenuEntries: _audioData.values.map((value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: _audioData.keys.firstWhere(
                          (element) => _audioData[element] == value),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: FutureBuilder<AyatList>(
                    future: futureAyat,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var ayat = snapshot.data!.data.ayat;

                        return ListView.builder(
                          itemCount: ayat.length,
                          itemBuilder: (context, int index) {
                            var data = ayat[index];

                            return Column(
                              children: <Widget>[
                                Card(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0,
                                      bottom: 4.0,
                                      left: 16.0,
                                      right: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CircleAvatar(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: Text(data.nomorAyat.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      AudioWidget(
                                          player: _audioPlayer,
                                          url: data.audio[_selectedAudio]),
                                    ],
                                  ),
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0,
                                      bottom: 16.0,
                                      left: 8.0,
                                      right: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(data.teksArab,
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontFamily: 'Amiri',
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 26)),
                                            const SizedBox(height: 8),
                                            Text(data.teksLatin,
                                                style: TextStyle(
                                                    fontFamily: 'Amiri',
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                    fontSize: 18)),
                                            Text(data.teksIndonesia,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((_) => showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertError(
                                      message: snapshot.error.toString());
                                }));
                      }

                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        color: Colors.white,
                      ));
                    },
                  )),
            ],
          ),
        )),
        bottomNavigationBar: const BottomNavWidget(
          currentIndex: 1,
        ));
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
