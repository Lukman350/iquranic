import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/components/audio_widget.dart';
import 'package:iquranic/components/bottom_nav.dart';
import 'package:iquranic/components/favorite_button.dart';
import 'package:iquranic/components/skeleton_surah.dart';
import 'package:iquranic/models/ayat.dart';
import 'package:iquranic/components/alert_error.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/screens/surah_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class QuranScreenMobile extends StatefulWidget {
  final Future<AyatList> futureAyat;
  final Surah favorite;
  final AudioPlayer audioPlayer;
  final TextEditingController selectAudio;
  final Map<String, String> audioData;
  final ScreenArguments args;

  const QuranScreenMobile(
      {Key? key,
      required this.futureAyat,
      required this.favorite,
      required this.audioPlayer,
      required this.selectAudio,
      required this.audioData,
      required this.args})
      : super(key: key);

  @override
  State<QuranScreenMobile> createState() => _QuranScreenMobileState();
}

class _QuranScreenMobileState extends State<QuranScreenMobile> {
  String selectedAudio = '01';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
                surah: widget.favorite,
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: AppBarTitle(title: widget.args.namaLatin),
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
                        Text(widget.args.arti.toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                fontSize: 18)),
                        Text('Asal: ${widget.args.tempatTurun.toUpperCase()}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                fontSize: 18)),
                        Text('${widget.args.jumlahAyat.toString()} AYAT',
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
                              backgroundColor: WidgetStateColor.resolveWith(
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
                                        title: Text(widget.args.namaLatin),
                                        content: Text(widget.args.deskripsi
                                            .replaceAll('<i>', '')
                                            .replaceAll('</i>', '')
                                            .replaceAll('<br>', '')),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateColor.resolveWith(
                                                      (states) =>
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
                            player: widget.audioPlayer,
                            url: widget.args.audioFull[selectedAudio]),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: DropdownMenu<String>(
                  initialSelection: widget.audioData.keys.first,
                  controller: widget.selectAudio,
                  label: const Text('Pilih Qori'),
                  width: MediaQuery.of(context).size.width - 32,
                  onSelected: (value) {
                    setState(() {
                      selectedAudio = value ?? '01';
                    });
                  },
                  textStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  menuStyle: MenuStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.inversePrimary),
                    elevation: WidgetStateProperty.all(4.0),
                  ),
                  inputDecorationTheme:
                      const InputDecorationTheme(filled: true),
                  dropdownMenuEntries: widget.audioData.values.map((value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: widget.audioData.keys.firstWhere(
                          (element) => widget.audioData[element] == value),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                  flex: screenHeight < 800 ? 3 : 5,
                  child: FutureBuilder<AyatList>(
                    future: widget.futureAyat,
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
                                          player: widget.audioPlayer,
                                          url: data.audio[selectedAudio]),
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

                      return const Skeletonizer(
                        child: SkeletonSurah(),
                      );
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
