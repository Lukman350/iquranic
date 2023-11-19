import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iquranic/api/api.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/models/ayat.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:iquranic/components/alert_error.dart';

class QuranScreen extends StatefulWidget {
  static const routeName = '/surah';

  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  bool isPlaying = false;
  Map<int, bool> isPlayingAyat = {};
  late Future<AyatList> futureAyat;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    isPlaying = false;
    isPlayingAyat = {};
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    setState(() {
      futureAyat = Api().getAyat(args.nomor);
    });

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () async {
                Navigator.pop(context);
                await player.stop();
              },
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: AppBarTitle(title: args.namaLatin)),
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
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    Theme.of(context).colorScheme.primary),
                          ),
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Theme.of(context).colorScheme.onPrimary),
                          onPressed: () async {
                            setState(() {
                              isPlaying = !isPlaying;
                            });

                            if (!isPlaying) {
                              await player.stop();
                            } else {
                              await player
                                  .play(UrlSource(args.audioFull['02']))
                                  .catchError((error) =>
                                      {AlertError(message: error.toString())});

                              player.onPlayerComplete.listen((event) {
                                setState(() {
                                  isPlaying = false;
                                });
                              });
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                  flex: 5,
                  child: FutureBuilder<AyatList>(
                    future: futureAyat,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var ayat = snapshot.data!.data.ayat;

                        return ListView.builder(
                          itemCount: ayat.length,
                          itemBuilder: (context, int index) {
                            var data = ayat[index];

                            SchedulerBinding.instance
                                .addPostFrameCallback((_) => setState(() {
                                      isPlayingAyat[index] = false;
                                    }));

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
                                      IconButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                        ),
                                        icon: Icon(
                                            isPlayingAyat[index] == true
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                        onPressed: () async {
                                          setState(() {
                                            isPlayingAyat[index] =
                                                !isPlayingAyat[index]!;
                                          });

                                          if (isPlayingAyat[index] == false) {
                                            await player.stop();
                                          } else {
                                            await player
                                                .play(
                                                    UrlSource(data.audio['01']))
                                                .catchError((error) => {
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) => showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return AlertError(
                                                                        message:
                                                                            error.toString());
                                                                  }))
                                                    });

                                            player.onPlayerComplete
                                                .listen((event) {
                                              setState(() {
                                                isPlayingAyat[index] = false;
                                              });
                                            });
                                          }
                                        },
                                      ),
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
                                          children: <Widget>[
                                            Text(data.teksArab,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24)),
                                            Text(data.teksLatin,
                                                style: TextStyle(
                                                    fontFamily: 'ArabLatin',
                                                    locale: const Locale(
                                                        'ar', 'AR'),
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                    fontSize: 16)),
                                            Text(data.teksIndonesia,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                    fontSize: 12)),
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
        )));
  }
}

class ScreenArguments {
  final String nomor;
  final String namaLatin;
  final String tempatTurun;
  final String arti;
  final int jumlahAyat;
  final String deskripsi;
  final Map<String, dynamic> audioFull;

  ScreenArguments(
      {required this.nomor,
      required this.namaLatin,
      required this.tempatTurun,
      required this.arti,
      required this.jumlahAyat,
      required this.deskripsi,
      required this.audioFull});
}
