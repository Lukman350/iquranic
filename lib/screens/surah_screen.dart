import 'package:flutter/material.dart';
import 'package:iquranic/api/api.dart';
import 'package:iquranic/components/appbar_title.dart';
import 'package:iquranic/models/ayat.dart';
import 'package:audioplayers/audioplayers.dart';

class QuranScreen extends StatefulWidget {
  static const routeName = '/surah';

  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  bool isPlaying = false;
  late Future<AyatList> futureAyat;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    setState(() {
      futureAyat = Api().getAyat(args.surah);
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
            title: AppBarTitle(title: args.name)),
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
                        Text('Asal: ${args.asal.toUpperCase()}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                fontSize: 18)),
                        Text('${args.ayat.toString()} AYAT',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w300,
                                fontSize: 12)),
                      ],
                    ),
                    IconButton(
                        tooltip: 'Mainkan surat',
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        disabledColor: Colors.grey,
                        onPressed: () async {
                          setState(() {
                            isPlaying = !isPlaying;
                          });

                          if (!isPlaying) {
                            await player.stop();
                          } else {
                            await player
                                .play(UrlSource(args.audioUrl))
                                .catchError((error) => {
                                      AlertDialog(
                                        title: const Text('Error'),
                                        content: Text(error.toString()),
                                      )
                                    });

                            player.onPlayerComplete.listen((event) {
                              setState(() {
                                isPlaying = false;
                              });
                            });
                          }
                        },
                        color: Colors.white,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                  flex: 8,
                  child: FutureBuilder<AyatList>(
                    future: futureAyat,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var ayat = snapshot.data!.ayatList;

                        return ListView.builder(
                          itemCount: ayat.length,
                          itemBuilder: (context, index) {
                            var data = ayat[index];

                            return ListTile(
                                minVerticalPadding: 18,
                                title: Text(data.ar,
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(data.id,
                                    style: const TextStyle(fontSize: 14)),
                                contentPadding: const EdgeInsets.all(4),
                                leading: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    maxRadius: 14,
                                    child: Text(data.nomor,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))));
                          },
                        );
                      } else if (snapshot.hasError) {
                        return AlertDialog(
                          title: const Text('Error'),
                          icon: const Icon(Icons.error),
                          iconColor: Colors.red,
                          content: Text(snapshot.error.toString()),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
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
  final String surah;
  final String name;
  final String asal;
  final String arti;
  final int ayat;
  final String audioUrl;

  ScreenArguments(
      {required this.surah,
      required this.name,
      required this.asal,
      required this.arti,
      required this.ayat,
      required this.audioUrl});
}
