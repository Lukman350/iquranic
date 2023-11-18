import 'package:flutter/material.dart';
import 'package:iquranic/models/surah.dart';
import 'package:iquranic/screens/surah_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SurahCard extends StatelessWidget {
  final List<Surah> surah;
  final bool isSearching;

  const SurahCard({Key? key, required this.surah, required this.isSearching})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: isSearching,
        child: ListView.builder(
          itemCount: surah.length,
          itemBuilder: (context, index) {
            final data = surah[index];

            return InkWell(
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Text(data.nomor.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(data.nama,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20)),
                          Text(
                              '${data.type.toUpperCase()} • ${data.ayat.toString().toUpperCase()} AYAT',
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(data.asma,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                    ),
                  ],
                ),
              )),
              onTap: () {
                Navigator.pushNamed(context, QuranScreen.routeName,
                    arguments: ScreenArguments(
                      surah: data.nomor,
                      name: data.nama,
                      asal: data.type,
                      arti: data.arti,
                      ayat: data.ayat,
                      audioUrl: data.audio,
                    ));
              },
            );
          },
        ));
  }
}
